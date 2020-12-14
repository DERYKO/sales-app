import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/shop_category.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/helpers/timesheet_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/dialogs/contact_customer_dialog.dart';
import 'package:solutech_sat/ui/screen/add_edit_customer_screen.dart';
import 'package:solutech_sat/ui/screen/customer_screen.dart';
import 'package:solutech_sat/ui/screen/customers_screen.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:solutech_sat/ui/screen/open_day_screen.dart';

class CheckinsBloc extends Bloc {
  List<ShopCategory> customerCategories = [];
  var pickedDates = [
    DateTime.now(),
    DateTime.now(),
  ];
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
      } else {
        timesheetManager.loadTimesheets(pickedDates);
        routePlansManager.loadRoutePlans();
      }
    } else {
      alert(
        "No connection",
        "Please make sure you are connected and have data before syncing.",
      );
    }
  }

  void filterByDate() async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: pickedDates.first,
      initialLastDate: pickedDates.last,
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked.length > 0) {
      pickedDates = picked;
      refresh();
    }
  }

  String customerType(int shopcatId) {
    ShopCategory category = customerCategories.firstWhere(
      (category) => category.shopcatId == shopcatId,
      orElse: () => null,
    );
    return category != null ? "${category.shopCatName}" : "";
  }

  void viewCustomer(Customer customer) {
    if (customer == null) {
      alert(
          "Customer not found", "Customer does not exist in your route plans.");
      return;
    }
    navigate(
      screen: CustomerScreen(
        customer: customer,
        routePlan: routePlansManager.currentRoutePlan,
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

  void editCustomer(Customer customer) {
    navigate(
      screen: AddEditCustomerScreen(
        mode: "edit",
        customer: customer,
        routePlan: routePlansManager.currentRoutePlan,
      ),
    );
  }

  showClosedDayDialog() {
    alert("Day already closed",
        "You can't perform this activity after closing the day. Go rest and pick up from tomorrow");
  }

  @override
  void initState() {
    super.initState();
  }
}
