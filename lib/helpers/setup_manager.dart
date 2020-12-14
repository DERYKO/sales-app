import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solutech_sat/utils/image_utils.dart';

class SetupManager {
  Box _box;
  static SetupManager instance;
  factory SetupManager() => instance ??= SetupManager._instance();
  SetupManager._instance();

  String get variantCode => _box.get("variant", defaultValue: null);
  bool get isFirstTime => _box.get("isFirstTime", defaultValue: true);
  DateTime get lastRefreshed => _box.get("lastRefreshed", defaultValue: null);
  Uint8List markerIcon;

  Future setVariantCode(String client) async {
    await _box.put("variant", client);
  }

  Future setIsFirstTime(bool shouldSetup) async {
    await _box.put("isFirstTime", shouldSetup);
  }

  Future setLastRefreshed(DateTime lastOpened) async {
    await _box.put("lastRefreshed", lastOpened);
  }

  init() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    _box = await Hive.openBox('setupBox');
    markerIcon = await getBytesFromAsset('assets/images/map-marker.png', 100);
  }
}

SetupManager setupManager = SetupManager();
