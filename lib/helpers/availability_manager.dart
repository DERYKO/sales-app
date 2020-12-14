import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/availability.dart';
import 'package:solutech_sat/data/models/availability_item.dart';
import 'package:solutech_sat/data/models/posm.dart';
import 'package:solutech_sat/data/models/posm_material.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/manager.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class AvailabilityManager extends Manager {
  static AvailabilityManager instance;
  factory AvailabilityManager() => instance ??= AvailabilityManager._instance();
  AvailabilityManager._instance();
  List<Availability> availabilities = [];
  List<AvailabilityItem> availabilityItems = [];
  bool _loadingAvailability = false;

  Future getDBData() async {
    availabilities = await db.availabilityBean.getAll();
    availabilityItems = await db.availabilityItemBean.getAll();
    notifyChanges();
  }

  bool get loadingAvailability => _loadingAvailability;

  set loadingAvailability(bool show) {
    _loadingAvailability = show;
    notifyChanges();
  }

  Future updateAvailabilityCustomerId(int oldId, int newId) async {
    List<Availability> availability = await db.availabilityBean.findWhere(db
        .availabilityBean.shopId
        .iss("$oldId")
        .and(db.availabilityBean.synced.iss(false)));
    for (var i = 0; i < availability.length; i++) {
      availability[i].shopId = "$newId";
    }

    await db.availabilityBean.updateMany(availability);
    getDBData();
    syncManager.sync();
  }

  List<AvailabilityItem> getAvailabilityItemsById(int recordId) {
    return availabilityItems
        .where((item) => item.availabilityId == recordId)
        .toList();
  }

  Future saveAvailability(
      {Availability availability,
      List<AvailabilityItem> availabilityItems}) async {
    int result = await db.availabilityBean.insert(availability
      ..visitId = sessionManager.session.sessionId
      ..synced = false
      ..fromServer = false);
    availabilityItems.forEach((item) async {
      await db.availabilityItemBean.insert(item..availabilityId = result);
    });
    print("Availability inserted");
    await getDBData();
    syncManager.sync();
  }

  List<Map<String, dynamic>> _buildAvailabilityItems(int recordId) {
    return availabilityItems
        .where(
            (availabilityItem) => availabilityItem.availabilityId == recordId)
        .map((item) => {
              "product_id": 0,
              "product_name": item.productName,
              "status": item.availabilityStatus
            })
        .toList();
  }

  Future syncAvailability() async {
    List<Availability> unsyncedAvailabilities = availabilities
        .where((Availability availability) => availability.synced == false)
        .toList();
    for (Availability availability in unsyncedAvailabilities) {
      if (routePlansManager
          .getCustomerById(int.parse("${availability.shopId}"))
          .synced) {
        try {
          var currentLocation = await locationManager.currentLocation();

          var response = await api.saveBrandAudit({
            "saler_id": authManager.user.id,
            "shop_id": routePlansManager
                .getCustomerById(int.parse("${availability.shopId}"))
                ?.shopId,
            "record_time": formatDate(availability.entryTime?.toString(), "xt"),
            "longitude": "${currentLocation.longitude}",
            "visitid": availability.visitId,
            "latitude": "${currentLocation.latitude}",
            "items":
                "${json.encode(_buildAvailabilityItems(availability.recordId))}",
          });

          if (response.data["status"] == 1) {
            _onAvailabilitySyncResponse(response.data, availability);
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
    availabilities.clear();
    await db.availabilityBean.removeAll();
    var filterDates = filterDatesFrom(pickedDates);
    return api.getAvailability(filterDates).then((response) async {
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
    return availabilities
            .where((Availability availability) =>
                int.parse("${availability.shopId ?? 0}") == customerId &&
                DateTime(
                        availability.entryTime.year,
                        availability.entryTime.month,
                        availability.entryTime.day) ==
                    DateTime(now.year, now.month, now.day))
            .toList()
            .length >
        0;
  }

  List<Availability> todaysAvailabilityByCustomerId(int customerId) {
    var now = DateTime.now();
    return availabilities
        .where((availability) =>
            int.parse("${availability.shopId ?? 0}") == customerId &&
            DateTime(availability.entryTime.year, availability.entryTime.month,
                    availability.entryTime.day) ==
                DateTime(now.year, now.month, now.day))
        .toList();
  }

  Future _saveAvailabilityLocally(payload) async {
    await db.availabilityBean.removeAll();
    await db.availabilityItemBean.removeAll();
    for (var item in payload) {
      print("BEFF $item ${item["shops"][0]["shop_id"]}");
      var availability = Availability(
        recordId: item["record_id"],
        shopId: "${item["shops"][0]["shop_id"]}",
        shopName: item["shops"][0]["shop_name"],
        entryTime: item["entry_time"] != null
            ? DateTime.parse("${item["entry_time"]}")
            : null,
      )
        ..synced = true
        ..fromServer = true;
      await db.availabilityBean.insert(availability);
      for (var availabilityDetail in item["availability_details"]) {
        await db.availabilityItemBean
            .insert(AvailabilityItem.fromMap(availabilityDetail));
      }
    }
    print("Availability saved");
    await getDBData();
  }

  _onAvailabilitySyncResponse(data, Availability availability) {
    db.availabilityBean.update(availability..synced = true);
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

var availabilityManager = AvailabilityManager();
