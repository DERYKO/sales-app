import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/session.dart';
import 'package:solutech_sat/data/models/update_profile.dart';
import 'package:solutech_sat/tools/manager.dart';

class SettingsManager extends Manager {
  static SettingsManager instance;
  factory SettingsManager() => instance ??= SettingsManager._instance();
  SettingsManager._instance();
  SharedPreferences _prefs;

  UpdateProfile get updateProfile {
    String _userProfile = _prefs?.getString("updateProfile") ?? null;
    if (_userProfile == null) return null;
    return UpdateProfile.fromMap(json.decode(_userProfile));
  }

  Future refreshUpdateProfile() {
    return api.getUpdateProfile().then((response) {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        settingsManager.setUpdateProfile(UpdateProfile.fromMap(payload));
        return response;
      } else {
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future<bool> setUpdateProfile(UpdateProfile user) async {
    return await _prefs?.setString("updateProfile", json.encode(user.toMap()));
  }

  bool get isCorrectVersion {
    var correctVersion = updateProfile?.appversion;
    var currentVersion = config.appVersion;
    if (correctVersion == null ||
        updateProfile?.forceupdate == "NO" ||
        (correctVersion == currentVersion)) {
      return true;
    } else {
      var version1 = correctVersion.split(".");
      var version2 = currentVersion.split(".");
      if (int.parse(version1[0]) > int.parse(version2[0]) ||
          ((int.parse(version1[0]) == int.parse(version2[0])) &&
              (int.parse(version1[1]) > int.parse(version2[1]))) ||
          ((int.parse(version1[0]) == int.parse(version2[0])) &&
                  (int.parse(version1[1]) == int.parse(version2[1]))) &&
              (int.parse(version1[2]) > int.parse(version2[2]))) {
        return false;
      } else {
        return true;
      }
    }
  }

  @override
  Future init() async {
    super.init();

    _prefs = await SharedPreferences.getInstance();
  }
}

var settingsManager = SettingsManager();
