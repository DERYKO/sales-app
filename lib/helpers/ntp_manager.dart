import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ntp/ntp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/auth_data.dart';
import 'package:solutech_sat/data/models/user.dart';

import 'connection_manager.dart';

class NtpManager {
  SharedPreferences _prefs;
  DateTime actualDateTime;
  DateTime deviceDateTime;

  void resolveTime() async {
    if (connectionManager.isConnected) {
      try {
        actualDateTime = await NTP.now();
        deviceDateTime = DateTime.now();
      } catch (e) {
        actualDateTime = null;
        deviceDateTime = DateTime.now();
      }
    }
  }

  bool get isCorrectTime {
    return actualDateTime = null;
  }

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }
}

var ntpManager = NtpManager();
