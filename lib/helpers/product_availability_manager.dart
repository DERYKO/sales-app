import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/product_availability.dart';
import 'package:solutech_sat/data/models/product_availability_detail.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/manager.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class ProductAvailabilityManager extends Manager {
  static ProductAvailabilityManager instance;
  factory ProductAvailabilityManager() =>
      instance ??= ProductAvailabilityManager._instance();
  ProductAvailabilityManager._instance();
  List<ProductAvailability> productAvailabilities = [];
  List<ProductAvailabilityDetail> availabilityDetails = [];
  bool _loadingAvailability = false;

  Future getDBData() async {
    productAvailabilities = await db.productAvailabilityBean.getAll();
    availabilityDetails = await db.productAvailabilityDetailBean.getAll();
    notifyChanges();
  }

  bool get loadingAvailability => _loadingAvailability;

  set loadingAvailability(bool show) {
    _loadingAvailability = show;
    notifyChanges();
  }

  List<ProductAvailabilityDetail> getAvailabilityDetailsById(int recordId) {
    return availabilityDetails
        .where((item) => item.availabilityId == recordId)
        .toList();
  }

  Future saveAvailability(
      {ProductAvailability availability,
      List<ProductAvailabilityDetail> availabilityItems}) async {
    int result = await db.productAvailabilityBean.insert(availability
      ..visitid = sessionManager.session.sessionId
      ..synced = false
      ..fromServer = false);
    availabilityItems.forEach((item) async {
      await db.productAvailabilityDetailBean
          .insert(item..availabilityId = result);
    });
    print("Product Availability inserted");
    getDBData().then((done) async {
      await syncManager.sync();
    });
  }

  List<Map<String, dynamic>> _buildAvailabilityItems(int recordId) {
    return availabilityDetails
        .where(
            (availabilityItem) => availabilityItem.availabilityId == recordId)
        .map((item) => {
              "product_id": item.productId,
              "product_name": item.productName,
              "status": item.availabilityStatus,
              "reason": item.reason,
              "notes": item.notes,
              "quantity": item.quantity,
            })
        .toList();
  }

  Future syncProductAvailability() async {
    await getDBData();
    List<ProductAvailability> unsyncedAvailabilities = productAvailabilities
        .where(
            (ProductAvailability availability) => availability.synced == false)
        .toList();
    for (ProductAvailability productAvailability in unsyncedAvailabilities) {
      if (routePlansManager
          .getCustomerById(int.parse("${productAvailability.outletId}"))
          .synced) {
        try {
          var currentLocation = await locationManager.currentLocation();

          var response = await api.saveProductAudit({
            "saler_id": authManager.user.id,
            "shop_id": routePlansManager
                .getCustomerById(int.parse("${productAvailability.outletId}"))
                ?.shopId,
            "record_time":
                formatDate(productAvailability.entryTime?.toString(), "xt"),
            "longitude": "${currentLocation.longitude}",
            "visitid": productAvailability.visitid,
            "latitude": "${currentLocation.latitude}",
            "items":
                "${json.encode(_buildAvailabilityItems(productAvailability.id))}",
          });

          if (response.data["status"] == 1) {
            _onAvailabilitySyncResponse(response.data, productAvailability);
          } else {
            throw DioError(
              response: response,
            );
          }
        } catch (error) {
          _onSyncError(error);
        }
      }
    }
  }

  Future loadAvailability([List<DateTime> pickedDates]) async {
    loadingAvailability = true;
    var filterDates = filterDatesFrom(pickedDates);
    return api.getProductsAvailability(filterDates).then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveAvailabilityLocally(payload);
        loadingAvailability = false;
        return response;
      } else {
        loadingAvailability = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  bool hasTodaysRecord(
    int customerId,
  ) {
    var now = DateTime.now();
    return productAvailabilities
            .where((ProductAvailability availability) =>
                int.parse("${availability.outletId ?? 0}") == customerId &&
                DateTime(
                        availability.entryTime.year,
                        availability.entryTime.month,
                        availability.entryTime.day) ==
                    DateTime(now.year, now.month, now.day))
            .toList()
            .length >
        0;
  }

  List<ProductAvailability> todaysAvailabilityByCustomerId(int customerId) {
    var now = DateTime.now();
    return productAvailabilities
        .where((availability) =>
            int.parse("${availability.outletId ?? 0}") == customerId &&
            DateTime(availability.entryTime.year, availability.entryTime.month,
                    availability.entryTime.day) ==
                DateTime(now.year, now.month, now.day))
        .toList();
  }

  Future _saveAvailabilityLocally(payload) async {
    await db.productAvailabilityBean.removeAll();
    await db.productAvailabilityDetailBean.removeAll();
    for (var item in payload) {
      var productAvailability = ProductAvailability(
        id: item["id"],
        visitid: "${item["visitid"]}",
        outletId: item["outlet_id"],
        latitude: item["latitude"],
        longitude: item["longitude"],
        entryTime: item["entry_time"] != null
            ? DateTime.parse("${item["entry_time"]}")
            : null,
        createdAt: item["created_at"] != null
            ? DateTime.parse("${item["created_at"]}")
            : null,
        updatedAt: item["updated_at"] != null
            ? DateTime.parse("${item["updated_at"]}")
            : null,
      )
        ..synced = true
        ..fromServer = true;
      await db.productAvailabilityBean.insert(
        productAvailability,
      );
      for (var productAvailabilityDetail in item["availability_details"]) {
        await db.productAvailabilityDetailBean.insert(
            ProductAvailabilityDetail.fromMap(productAvailabilityDetail));
      }
    }
    await getDBData();
    await syncManager.sync();
  }

  _onAvailabilitySyncResponse(data, ProductAvailability availability) {
    db.productAvailabilityBean.update(availability..synced = true);
    getDBData();
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

var productAvailabilityManager = ProductAvailabilityManager();
