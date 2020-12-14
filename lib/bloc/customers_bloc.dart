import 'package:flutter/material.dart' show TextEditingController;
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/route_plan.dart';
import 'package:solutech_sat/data/models/shop_category.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/dialogs/contact_customer_dialog.dart';
import 'package:solutech_sat/ui/screen/add_edit_customer_screen.dart';
import 'package:solutech_sat/ui/screen/customer_screen.dart';

class CustomersBloc extends Bloc {
  RoutePlan routePlan;
  bool search = false;
  TextEditingController searchTextController = TextEditingController();
  bool viewVisitedCustomers = false;
  List<ShopCategory> customerCategories = [];
  String searchTerm = "";

  contactCustomer(int shopId) {
    var shop = routePlansManager.getCustomerById(shopId);
    var contactCustomerDialog = ContactCustomerDialog(context);
    if (shop != null) {
      contactCustomerDialog..phoneNumber = shop.shopPhoneno;
      contactCustomerDialog.show();
    }
  }

  void refresh() async {
    if (connectionManager.isConnected) {
      if (await syncManager.shouldSync) {
        progressDialog.message = "Syncing data...";
        progressDialog.show();
        syncManager.sync().then((data) async {
          progressDialog.hide();
          if (!await syncManager.shouldSync) {
            refresh();
          } else {
            alert("Sync failed", "Data could not be synced.");
          }
        });
      } else if (!await syncManager.shouldSync && syncManager.syncing) {
        routePlansManager.loadRoutePlans();
      }
    } else {
      alert(
        "No connection",
        "Please make sure you are connected and have data before syncing.",
      );
    }
  }

  void exitSearch() {
    search = false;
    notifyChanges();
  }

  void onSearch(data) {
    searchTerm = data;
    print("Search term: $data");
    notifyChanges();
  }

  void searchCustomers() {
    search = true;
    notifyChanges();
  }

  void toggleVisitedCustomers() {
    viewVisitedCustomers = !viewVisitedCustomers;
    notifyChanges();
  }

  String customerType(int shopcatId) {
    ShopCategory category = customerCategories.firstWhere(
      (category) => category.shopcatId == shopcatId,
      orElse: () => null,
    );
    return category != null ? "${category.shopCatName}" : "";
  }

  void onRoutePlanChanged(RoutePlan routePlan) {
    this.routePlan = routePlan;
    notifyChanges();
  }

  void editCustomer(Customer customer) {
    navigate(
      screen: AddEditCustomerScreen(
        mode: "edit",
        customer: customer,
        routePlan: routePlan,
      ),
    );
  }

  void viewCustomer(Customer customer) {
    navigate(
      screen: CustomerScreen(
        customer: customer,
        routePlan: routePlan,
      ),
    );
  }

  void alertInSession(int customerId) async {
    bool shouldNavigate = await confirm("You are still checked in",
        "Please checkout from ${routePlansManager.getCustomerById(sessionManager.session.customerId).shopName} first before you continue.");
    if (shouldNavigate) {
      Customer customer = routePlansManager.getCustomerById(customerId);
      navigate(
          screen: CustomerScreen(
        customer: customer,
        routePlan: routePlansManager.routePlanById(customer.routeId),
      ));
    }
  }

  void setCurrentRoutePlan() {
    routePlan = routePlansManager.currentRoutePlan;
    print("Current route plan $routePlan");
    notifyChanges();
  }

  void addCustomer() {
    navigate(
      screen: AddEditCustomerScreen(
        mode: "add",
        routePlan: routePlan,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setCurrentRoutePlan();
    routePlansManager.stream.listen((data) {
      if (routePlan == null) {
        setCurrentRoutePlan();
      }
    });
  }
}
