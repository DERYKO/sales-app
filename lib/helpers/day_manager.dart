import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/stats_manager.dart';
import 'package:solutech_sat/tools/manager.dart';
import 'package:hive/hive.dart';
import 'package:solutech_sat/utils/device_utils.dart';

class DayManager extends Manager {
  static DayManager instance;
  factory DayManager() => instance ??= DayManager._instance();
  DayManager._instance();
  bool _openingDay = false;
  bool _closingDay = false;
  bool _loadingCloseDay = false;
  Box _box;

  bool get loadingCloseDay => _loadingCloseDay;
  set loadingCloseDay(bool value) {
    _loadingCloseDay = value;
    notifyChanges();
  }

  bool get openingDay => _openingDay;

  DateTime get openDayTime => _box.get("openDayTime", defaultValue: null);
  DateTime get closeDayTime => _box.get("closeDayTime", defaultValue: null);

  set openingDay(bool value) {
    _openingDay = value;
    notifyChanges();
  }

  bool get closingDay => _closingDay;

  set closingDay(bool value) {
    _closingDay = value;
    notifyChanges();
  }

  bool get openedDay => _box.get("openedDay", defaultValue: false);

  bool get closedDay => _box.get("closedDay", defaultValue: false);

  Future loadOpenDay() {
    loadingCloseDay = true;
    return api.getCloseDay().then((response) {
      if (response.data["payload"].length > 0) {
        _box.put("openedDay", true);
        _box.put("openDayTime",
            DateTime.parse("${response.data["payload"][0]["start_time"]}"));
        if (response.data["payload"][0]["status"] != "Active") {
          _box.put("closedDay", true);
          if (response.data["payload"][0]["entry_time"] != null) {
            _box.put("closeDayTime",
                DateTime.parse("${response.data["payload"][0]["entry_time"]}"));
          }
        }
      }
      loadingCloseDay = false;
      return response;
    }).catchError((error) {
      loadingCloseDay = false;
      print("LoadOpenDayError $error");
    });
  }

  Future openDay({
    String comments,
    String odometer,
  }) async {
    openingDay = true;
    DateTime closeTime = DateTime.now();
    var currentLocation = await locationManager.currentLocation();
    return api.startCloseDay({
      "user_id": authManager.user.id,
      "entry_type": "startday",
      "startcomments": comments,
      "gpsaccuracy": currentLocation.accuracy.toStringAsFixed(2),
      "startbattery": await battery.batteryLevel,
      "startodometer": odometer,
      "start_time": closeTime?.toIso8601String(),
      "startlat": currentLocation.latitude,
      "startlon": currentLocation.longitude
    }).then((response) {
      _box.put("openedDay", true);
      _box.put("openDayTime", closeTime);
      openingDay = false;
      return response;
    }).catchError((error) {
      openingDay = false;
      print("OpenDayError $error");
    });
  }

  Future closeDay({
    String callageComment,
    String salesComment,
    String generalComment,
    String odometer,
  }) async {
    closingDay = true;
    DateTime closeTime = DateTime.now();
    var currentLocation = await locationManager.currentLocation();
    return api.startCloseDay({
      "user_id": authManager.user.id,
      "entry_type": "endday",
      "callage_target": statsManager.salesSummary.target,
      "callage_actual": statsManager.salesSummary.actual,
      "callage_success": statsManager.salesSummary.success,
      "callage_comment": callageComment,
      "sales_target": statsManager.salesSummary.targetValue,
      "sales_actual": statsManager.salesSummary.totalSales,
      "sales_comment": salesComment,
      "general_comment": generalComment,
      "endcomments": generalComment,
      "gpsaccuracy": currentLocation.accuracy.toStringAsFixed(2),
      "endbattery": await battery.batteryLevel,
      "endodometer": odometer,
      "end_time": closeTime?.toIso8601String(),
      "endlat": currentLocation.latitude,
      "endlon": currentLocation.longitude
    }).then((response) {
      closingDay = false;
      _box.put("closedDay", true);
      _box.put("closeDayTime", closeTime);
      return response;
    }).catchError((error) {
      closingDay = false;
      print("OpenDayError $error");
    });
  }

  void clear() {
    _box.clear();
    notifyChanges();
  }

  @override
  Future init() async {
    super.init();
    _box = await Hive.openBox('dayManager');
  }
}

var dayManager = DayManager();
