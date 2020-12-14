import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';

import 'api/api.dart';
import 'helpers/setup_manager.dart';

class Config {
  String _variant = "DEMO";
  String get variant => this._variant;
  static Config INSTANCE;
  factory Config() => INSTANCE ??= Config._instance();
  Config._instance();
  StreamController<dynamic> _controller = StreamController<dynamic>.broadcast();
  Stream<dynamic> get stream => _controller.stream;

  Map<String, _Variant> _variants = {
    "DEMO": _Variant(
      appName: "Solutech SAT",
      apiUrl: "https://app.solutechlabs.com/api",
      appDatabase: "sat_admin",
      appIcon: "assets/images/icon.png",
      themeData: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.orangeAccent,
      ),
      appIconSize: AppIconSize(
        splash: 60.0,
        login: 80.0,
      ),
    ),
    "KI": _Variant(
      appName: "Kenafric SAT",
      apiUrl: "https://ki.solutechlabs.com/api",
      appIcon: "assets/images/ki_icon.png",
      themeData: ThemeData(
        primaryColor: Color(0xFF7a1c2d), // CAPWEL Color(0xFFfad350)
        accentColor: Color(0xFF292829),
      ),
      appIconSize: AppIconSize(
        splash: 100.0,
        login: 120.0,
      ),
    ),
    "DIL": _Variant(
      appName: "Diamond SAT",
      apiUrl: "https://dil.solutechlabs.com/api",
      appIcon: "assets/images/icon.png",
      themeData: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.orangeAccent,
      ),
      appIconSize: AppIconSize(
        splash: 60.0,
        login: 80.0,
      ),
    ),
    "MZURI": _Variant(
      appName: "Mzuri SAT",
      apiUrl: "https://mzuri.solutechlabs.com/api",
      appIcon: "assets/images/mzuri_icon.png",
      themeData: ThemeData(
        primaryColor: Color(0xFFed1c24), // CAPWEL Color(0xFFfad350)
        accentColor: Color(0xFF292829),
      ),
      appIconSize: AppIconSize(
        splash: 100.0,
        login: 120.0,
      ),
    ),
    "PWANI": _Variant(
      appName: "Pwani SAT",
      apiUrl: "https://pwani.solutechlabs.com/api",
      appIcon: "assets/images/pwani_icon.png",
      themeData: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.red,
      ),
      appIconSize: AppIconSize(
        splash: 100.0,
        login: 120.0,
      ),
    ),
    "UNITED": _Variant(
      appName: "United SAT",
      apiUrl: "https://united.solutechlabs.com/api",
      appIcon: "assets/images/united_icon.png",
      themeData: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.red,
      ),
      appIconSize: AppIconSize(
        splash: 100.0,
        login: 120.0,
      ),
    ),
    "HIGHLANDS": _Variant(
      appName: "HIGHLANDS SAT",
      apiUrl: "https://highlands.solutechlabs.com/api",
      appIcon: "assets/images/highlands_icon.png",
      themeData: ThemeData(
        primaryColor: Color(0xFF0055a5),
        accentColor: Color(0xFFf79521),
      ),
      appIconSize: AppIconSize(
        splash: 100.0,
        login: 120.0,
      ),
    ),
    "CAPWELL": _Variant(
      appName: "CAPWELL SAT",
      apiUrl: "https://capwell.solutechlabs.com/api",
      appIcon: "assets/images/capwell_icon.png",
      themeData: ThemeData(
        primaryColor: Color(0xFFfad350),
        accentColor: Color(0xFF292829),
      ),
      contrastColor: Color(0xFF292829),
      appIconSize: AppIconSize(
        splash: 100.0,
        login: 100.0,
      ),
    ),
    "BOWIP": _Variant(
      appName: "BOWIP SAT",
      apiUrl: "https://bowip.solutechlabs.com/api",
      appIcon: "assets/images/bowip_icon.jpg",
      themeData: ThemeData(
        primaryColor: Color(0xFF35bebc),
        accentColor: Color(0xFF292829),
      ),
      contrastColor: Colors.white,
      appIconSize: AppIconSize(
        splash: 100.0,
        login: 100.0,
      ),
    ),
    "HKL": _Variant(
      appName: "Hasbah SAT",
      apiUrl: "https://hasbah.solutechlabs.com/api",
      appIcon: "assets/images/hasbah_icon.png",
      themeData: ThemeData(
        primaryColor: Color(0xFF292829),
        accentColor: Colors.red,
      ),
      appIconSize: AppIconSize(
        splash: 100.0,
        login: 100.0,
      ),
    ),
    "KETEPA": _Variant(
      appName: "KETEPA SAT",
      apiUrl: "https://ketepa.solutechlabs.com/api",
      appIcon: "assets/images/ketepa_icon.png",
      themeData: ThemeData(
        primaryColor: Color(0xff2ca251),
        accentColor: Colors.black54,
      ),
      appIconSize: AppIconSize(
        splash: 80.0,
        login: 100.0,
      ),
    ),
    "PALMHOUSE": _Variant(
      appName: "PALMHOUSE SAT",
      apiUrl: "https://palmhouse.solutechlabs.com/api",
      appIcon: "assets/images/palmhouse_icon.png",
      themeData: ThemeData(
        primaryColor: Color(0xff03a64d),
        accentColor: Colors.black54,
      ),
      appIconSize: AppIconSize(
        splash: 80.0,
        login: 100.0,
      ),
    ),
    "FTG": _Variant(
      appName: "Flame Tree SAT",
      apiUrl: "https://flametree.solutechlabs.com/api",
      appIcon: "assets/images/flametree_icon.jpeg",
      themeData: ThemeData(
        primaryColor: Color(0xFF202020),
        accentColor: Color(0xFF3e884d),
      ),
      appIconSize: AppIconSize(
        splash: 80.0,
        login: 80.0,
      ),
    ),
  };
  ThemeData get themeData => _variants[_variant].themeData;
  String get appName => _variants[_variant].appName;
  String get apiUrl => _variants[_variant].apiUrl;
  String get appDescription => _variants[_variant].appDescription;
  String get appVersion => "${_variants[_variant].appVersion}";
  String get appDatabase => _variants[_variant].appDatabase;
  String get appIcon => _variants[_variant].appIcon;
  String get serverIp => _variants[_variant].serverIp;
  AppIconSize get appIconSize => _variants[_variant].appIconSize;
  Color get contrastColor => _variants[_variant].contrastColor;

  Future setVariant(String code) async {
    if (_variants.containsKey(code)) {
      _variant = code;
      await setupManager.setVariantCode(code);
      api = Api(config.apiUrl);
      connectionManager.setServerIp(config.serverIp);
      _controller.add(1);
      return true;
    } else {
      return false;
    }
  }
}

class _Variant {
  String appName;
  String apiUrl;
  String appVersion;
  String appDatabase;
  String appIcon;
  String appDescription;
  String serverIp;
  Color contrastColor;
  AppIconSize appIconSize = AppIconSize();
  ThemeData themeData = ThemeData(
    primaryColor: Colors.blue,
    accentColor: Colors.orangeAccent,
  );
  _Variant({
    this.appName: "SAT Demo",
    this.apiUrl: "https://app.solutechlabs.com/api",
    this.appVersion: "2.0.40",
    this.appDatabase: "sat_admin",
    this.serverIp: "1.0.0.1",
    this.appIcon: "assets/images/icon.png",
    this.appDescription:
        "Manage and grow your sales and customers more effectively with Kenya's leading sales automation tool",
    this.themeData,
    this.appIconSize,
    this.contrastColor: Colors.white,
  });
}

class AppIconSize {
  double splash;
  double login;
  double drawer;
  AppIconSize({
    this.splash = 80.0,
    this.login = 80.0,
    this.drawer = 80.0,
  });
}

var config = Config();
