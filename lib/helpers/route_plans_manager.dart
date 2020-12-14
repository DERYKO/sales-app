import 'dart:io';

import 'package:dio/dio.dart';
import 'package:great_circle_distance2/great_circle_distance2.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/date_week.dart';
import 'package:solutech_sat/data/models/route_plan.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/shop_route.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/manager.dart';
import 'package:solutech_sat/utils/format_utils.dart';
import 'package:solutech_sat/utils/image_utils.dart';

class RoutePlansManager extends Manager {
  static RoutePlansManager instance;
  factory RoutePlansManager() => instance ??= RoutePlansManager._instance();
  RoutePlansManager._instance();
  bool _loadingRoutePlans = false;
  var visitDays = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
  List<RoutePlan> _routePlans = [];
  List<ShopRoute> shopRoutes = [];
  List<DateWeek> dateWeeks = [];
  List<Customer> shops = [];

  Future getDBData() async {
    _routePlans = await db.routePlanBean.getAll();
    dateWeeks = await db.dateWeekBean.getAll();
    shopRoutes = await db.shopRouteBean.getAll();
    shops = await db.customerBean.getAll();
    notifyChanges();
  }

  set loadingRoutePlans(bool loading) {
    _loadingRoutePlans = loading;
    notifyChanges();
  }

  get loadingRoutePlans => _loadingRoutePlans;

  List<RoutePlan> get routePlans {
    var weekDay = DateTime.now().weekday;
    var routePlans = [..._routePlans];
    routePlans.sort((a, b) =>
        visitDays.indexOf(a.visitDay).compareTo(visitDays.indexOf(b.visitDay)));
    return routePlans;
  }

  List<Customer> shopsForRoute(int routeId) {
    return shops
        .where((shop) => shopRoutes
            .where((shopRoute) => shopRoute.routeId == routeId)
            .map<int>((shopRoute) => shopRoute.shopId)
            .toList()
            .contains(shop.id))
        .toList();
  }

  int dateWeek(String frequency, int visitWeek) {
    if (frequency == "Fortnight") {
      return (currentDateWeek.week == 1 || currentDateWeek.week == 3) ? 1 : 2;
    } else if (frequency == "Triweekly") {
      if (visitWeek == 1) {
        if (currentDateWeek.week == 1 || currentDateWeek.week == 4) return 1;
      } else if (visitWeek == 2) {
        if (currentDateWeek.week == 2 || currentDateWeek.week == 1) return 2;
      } else if (visitWeek == 3) {
        if (currentDateWeek.week == 3 || currentDateWeek.week == 2) return 3;
      }
    }
    return 0;
  }

  RoutePlan get currentRoutePlan {
    var todayWeekDay = DateTime.now().weekday;
    var todayDay = visitDays[todayWeekDay - 1];
    if (currentDateWeek != null) {
      // Resolve Daily route
      return routePlans.firstWhere(
        (routePlan) => routePlan.frequency == "Daily",
        // Resolve Weekly route
        orElse: () => routePlans.firstWhere(
          (routePlan) =>
              routePlan.visitDay == todayDay && routePlan.frequency == "Weekly",
          // Resolve Fortnight route
          orElse: () => routePlans.firstWhere(
            (routePlan) =>
                routePlan.frequency == "Fortnight" &&
                routePlan.visitDay == todayDay &&
                int.parse("${routePlan.visitWeek}") ==
                    dateWeek(
                      routePlan.frequency,
                      int.parse("${routePlan.visitWeek}"),
                    ),
            // Resolve Triweekly route
            orElse: () => routePlans.firstWhere(
              (routePlan) =>
                  routePlan.frequency == "Triweekly" &&
                  routePlan.visitDay == todayDay &&
                  (int.parse("${routePlan.visitWeek}") ==
                      dateWeek(routePlan.frequency,
                          int.parse("${routePlan.visitWeek}"))),
              // Resolve Monthly route
              orElse: () => routePlans.firstWhere(
                (routePlan) =>
                    routePlan.frequency == "Monthly" &&
                    routePlan.visitDay == todayDay &&
                    int.parse("${routePlan.visitWeek}") == currentDateWeek.week,
                orElse: () => null,
              ),
            ),
          ),
        ),
      );
    }
    return routePlans.firstWhere(
      (routePlan) => routePlan.frequency == "Daily",
      orElse: () => routePlans.firstWhere(
        (routePlan) =>
            routePlan.frequency == "Weekly" && routePlan.visitDay == todayDay,
        orElse: () => null,
      ),
    );
  }

  DateWeek get currentDateWeek {
    var now = DateTime.now();
    return dateWeeks.firstWhere(
      (dateWeek) =>
          DateTime(
              dateWeek.date.year, dateWeek.date.month, dateWeek.date.day) ==
          DateTime(now.year, now.month, now.day),
      orElse: () => null,
    );
  }

  RoutePlan routePlanById(int routePlanId) {
    return routePlans.firstWhere(
      (routePlan) => routePlan.id == routePlanId,
      orElse: () => null,
    );
  }

  Future loadRoutePlans() {
    loadingRoutePlans = true;
    return api.getRoutePlans().then((response) async {
      loadingRoutePlans = false;
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveRoutePlansLocally(payload);
        return response;
      } else {
        loadingRoutePlans = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future _saveRoutePlansLocally(payload) async {
    await db.routePlanBean.removeAll();
    await db.customerBean.removeAll();
    for (var routePlan in payload) {
      await db.routePlanBean.insert(RoutePlan.fromMap({
        "id": routePlan["id"],
        "name": routePlan["name"],
        "description": routePlan["description"],
        "visitDay": routePlan["visitDay"],
        "visitWeek": routePlan["visitWeek"],
        "frequency": routePlan["frequency"],
        "shops": routePlan["shops"].length,
      }));
      for (var item in routePlan["shops"]) {
        var shop = Customer.fromMap(item)
          ..fromServer = true
          ..synced = true;
        await db.customerBean.upsert(shop);
        await db.shopRouteBean
            .insert(ShopRoute(shopId: shop.id, routeId: shop.routeId));
      }
    }
    print("Route plans saved");
    await getDBData();
  }

  Future<List<Customer>> getCustomers(
    int routePlanId, {
    bool hideVisited = false,
  }) async {
    List<Customer> customers = [];
    if (hideVisited) {
      List<int> shopsVisitedIds = [];
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      recordsManager.skipRecords.forEach((skipRecord) {
        final aDate = DateTime.parse(skipRecord.orderTime);
        final recordDate = DateTime(aDate.year, aDate.month, aDate.day);
        if (recordDate == today) {
          shopsVisitedIds.add(skipRecord.shopId);
        }
      });
      recordsManager.orders.forEach((order) {
        final aDate = order.orderTime;
        final recordDate = DateTime(aDate.year, aDate.month, aDate.day);
        if (recordDate == today) {
          shopsVisitedIds.add(order.shopId);
        }
      });

      customers = shops
          .where((shop) => shopRoutes
              .where((shopRoute) => shopRoute.routeId == routePlanId)
              .map<int>((shopRoute) => shopRoute.shopId)
              .toList()
              .contains(shop.id))
          .toList();

      customers.sort((a, b) => GreatCircleDistance.fromDegrees(
              latitude1: locationManager.position?.latitude ?? 0,
              longitude1: locationManager.position?.longitude ?? 0,
              latitude2: double.parse("${a.slatitude ?? 0}"),
              longitude2: double.parse("${a.slongitude ?? 0}"))
          .haversineDistance()
          .compareTo(GreatCircleDistance.fromDegrees(
                  latitude1: locationManager.position?.latitude ?? 0,
                  longitude1: locationManager.position?.longitude ?? 0,
                  latitude2: double.parse("${b.slatitude ?? 0}"),
                  longitude2: double.parse("${b.slongitude ?? 0}"))
              .haversineDistance()));

      return customers;
    } else {
      customers = shops
          .where((shop) => shopRoutes
              .where((shopRoute) => shopRoute.routeId == routePlanId)
              .map<int>((shopRoute) => shopRoute.shopId)
              .toList()
              .contains(shop.id))
          .toList();
      customers.sort((a, b) => GreatCircleDistance.fromDegrees(
            latitude1: locationManager.position?.latitude ?? 0,
            longitude1: locationManager.position?.longitude ?? 0,
            latitude2: double.parse("${a.slatitude ?? 0}"),
            longitude2: double.parse("${a.slongitude ?? 0}"),
          ).haversineDistance().compareTo(GreatCircleDistance.fromDegrees(
                latitude1: locationManager.position?.latitude ?? 0,
                longitude1: locationManager.position?.longitude ?? 0,
                latitude2: double.parse("${b.slatitude ?? 0}"),
                longitude2: double.parse(
                  "${b.slongitude ?? 0}",
                ),
              ).haversineDistance()));
    }

    return customers; //customers;
  }

  Customer getCustomerById(int customerId) {
    return shops.firstWhere((Customer customer) => customer.id == customerId,
        orElse: () => null);
  }

  String routeType(int routeId) {
    return routeId == currentRoutePlan?.id ? "ON" : "OFF";
  }

  Future saveCustomer(Customer customer) async {
    int result = await db.customerBean.insert(customer
      ..synced = false
      ..fromServer = false);
    await db.shopRouteBean
        .insert(ShopRoute(shopId: result, routeId: customer.routeId));
    print("Customer inserted");
    await getDBData();
    syncManager.sync();
  }

  Future saveUpdatedCustomer(Customer customer) async {
    int result = await db.customerBean.update(customer..updated = true);
    print("Customer updated");
    await getDBData();
    syncManager.sync();
  }

  Future syncCustomers() async {
    List<Customer> unsyncedCustomers =
        shops.where((Customer customer) => customer.synced == false).toList();
    for (Customer customer in unsyncedCustomers) {
      try {
        var response = await api.addCustomer({
          "route_id": customer.routeId,
          "shop_cat_id": customer.shopCatId,
          "shop_name": customer.shopName?.toUpperCase(),
          "shop_phoneno": customer.shopPhoneno,
          "entry_time": formatDate(customer.visitTime, "xt"),
          "longitude": customer.slongitude,
          "region_id": customer.regionId,
          "latitude": customer.slatitude,
          "location_id": customer.locationId,
          "verified": "Pending",
          "userid": authManager.user.id,
          "photo": (customer.photo != null && customer.photo.trim() != "")
              ? await base64FromFile(File(customer.photo))
              : null,
        });
        if (response.data["status"] == 1) {
          var data = response.data["payload"];
          _onCustomersSyncResponse(data, customer);
        } else {
          throw DioError(
            response: response,
          );
        }
      } catch (e) {
        _onSyncError(e);
      }
    }
  }

  Future syncUpdatedCustomers() async {
    List<Customer> unsyncedUpdatedCustomers =
        shops.where((Customer customer) => customer.updated == true).toList();
    for (Customer customer in unsyncedUpdatedCustomers) {
      try {
        var response = await api.updateCustomer({
          "route_id": customer.routeId,
          "shop_id": customer.shopId,
          "shop_cat_id": customer.shopCatId,
          "shop_name": customer?.shopName?.toUpperCase(),
          "shop_phoneno": customer.shopPhoneno,
          "longitude": customer.slongitude,
          "latitude": customer.slatitude,
          "location_id": customer.locationId,
          "region_id": customer.regionId,
          "entry_time": formatDate(customer.updatedTime, "xt"),
          "qrcode": null,
          "verified": customer.verified,
          "verifiedby": customer.verifiedby,
          "verification_date": customer.verificationDate,
          "userid": authManager.user.id,
          "photo": (customer.photo != null && customer.photo.trim() != "")
              ? await base64FromFile(File(customer.photo))
              : null,
        });
        if (response.data["status"] == 1) {
          var data = response.data["payload"];
          _onCustomerUpdateSyncResponse(data, customer);
        } else {
          throw DioError(
            response: response,
          );
        }
      } catch (e) {
        _onSyncError(e);
      }
    }
  }

  _onCustomersSyncResponse(data, Customer customer) async {
    print("Customer synced id: ${data["record_id"]}");
    await db.customerBean.update(
      customer
        ..synced = true
        ..shopId = "${data["record_id"]}",
    );
    await getDBData();
  }

  _onCustomerUpdateSyncResponse(data, Customer customer) async {
    await db.customerBean.update(customer..updated = false);
    await getDBData();
  }

  _onSyncError(error) {
    print("Error $error");
  }

  @override
  Future init() async {
    super.init();
    await getDBData();
  }
}

var routePlansManager = RoutePlansManager();
