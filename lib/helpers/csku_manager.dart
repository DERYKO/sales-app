import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/brand.dart';
import 'package:solutech_sat/data/models/commons.dart';
import 'package:solutech_sat/data/models/csku.dart';
import 'package:solutech_sat/data/models/date_week.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/shop_category.dart';
import 'package:solutech_sat/data/models/sku.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/tools/manager.dart';

class CskuManager extends Manager {
  static CskuManager instance;
  factory CskuManager() => instance ??= CskuManager._instance();
  CskuManager._instance();
  List<Csku> cskus = [];

  List<Csku> getCskusByCategory(String category) {
    return cskus.where((csku) => csku.categoryName == category).toList();
  }

  Future getDBData() async {
    cskus = await db.cskuBean.getAll();
    notifyChanges();
  }

  Future loadCskus() {
    return api.getCategorySkus().then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveCskusLocally(payload);
        return response;
      } else {
        throw DioError(
          response: response,
        );
      }
    });
  }

  Csku getSkuById(int id) {
    return cskus.firstWhere((csku) => csku.id == id, orElse: () => null);
  }

  Future _saveCskusLocally(payload) async {
    await db.cskuBean.removeAll();
    for (var item in payload) {
      await db.cskuBean.insert(Csku.fromMap(item));
    }
    print("Cskus saved");
    await getDBData();
  }

  @override
  Future init() async {
    super.init();
    await getDBData();
  }
}

var cskusManager = CskuManager();
