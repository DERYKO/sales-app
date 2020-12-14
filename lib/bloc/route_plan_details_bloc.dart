import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/route_plan.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/shop_category.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/setup_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/screen/customer_screen.dart';

class RoutePlanDetailsBloc extends Bloc {
  RoutePlan routePlan;
  BitmapDescriptor mapIcon;
  List<Customer> customers = [];
  List<ShopCategory> customerCategories = [];
  TabController tabController = TabController(
    length: 2,
    vsync: ScrollableState(),
  );

  RoutePlanDetailsBloc({
    this.routePlan,
  });

  Set<Marker> getMapMarkers() {
    Set<Marker> markers = Set();
    customers.forEach((customer) {
      if ((double.parse("${customer.slatitude ?? 0}") != 0) &&
          (double.parse("${customer.slongitude ?? 0}") != 0)) {
        print(
          "Adding marker ${customer.shopName}, lat: ${customer.slatitude}, lon: ${customer.slongitude}",
        );
        markers.add(
          Marker(
            markerId: MarkerId("${customer.id}"),
            icon: BitmapDescriptor.fromBytes(setupManager.markerIcon),
            position: LatLng(
              double.parse("${customer.slatitude ?? 0}"),
              double.parse("${customer.slongitude ?? 0}"),
            ),
            infoWindow: InfoWindow(
              title: "${customer.shopName}",
              snippet: "${customer.contactPerson ?? ""}",
            ),
          ),
        );
      }
    });
    return markers;
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

  void viewCustomer(Customer customer) {
    navigate(
        screen: CustomerScreen(
      customer: customer,
      routePlan: routePlan,
    ));
  }

  String customerType(int shopcatId) {
    ShopCategory category = customerCategories.firstWhere(
      (category) => category.shopcatId == shopcatId,
      orElse: () => null,
    );
    return category != null ? "${category.shopCatName}" : "";
  }

  loadCustomers() {
    customerCategories = commonsManager.shopCategories;
    customers = routePlansManager.shopsForRoute(routePlan.id);
    print("shops $customers");
    notifyChanges();
  }

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        size: Size(200, 200),
      ),
      "assets/images/map-marker.png",
    ).then((onValue) {
      mapIcon = onValue;
    });
    loadCustomers();
    tabController.addListener(() {
      notifyChanges();
    });
  }
}
