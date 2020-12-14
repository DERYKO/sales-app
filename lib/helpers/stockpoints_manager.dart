import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/commons.dart';
import 'package:solutech_sat/data/models/date_week.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/role.dart';
import 'package:solutech_sat/data/models/shop_category.dart';
import 'package:solutech_sat/data/models/stockpoint.dart';
import 'package:solutech_sat/data/models/update_profile.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/tools/manager.dart';

class StockpointsManager extends Manager {
  static StockpointsManager instance;
  factory StockpointsManager() => instance ??= StockpointsManager._instance();
  StockpointsManager._instance();
  List<Stockpoint> stockPoints = [];

  Future getDBData() async {
    stockPoints = await db.stockpointBean.getAll();
    notifyChanges();
  }

  Stockpoint stockpointFromId(int supplierId) {
    return stockPoints.firstWhere((stockPoint) => stockPoint.id == supplierId,
        orElse: () => null);
  }

  Future loadStockpoints() {
    showLoader(true);
    return api.getAllocatedStockpoint().then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveStockpointsLocally(payload);
        showLoader(false);
        return response;
      } else {
        showLoader(false);
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future _saveStockpointsLocally(payload) async {
    await db.stockpointBean.removeAll();
    for (var item in payload) {
      await db.stockpointBean.insert(Stockpoint.fromMap(item));
    }
    print("Stockpoints saved");
    await getDBData();
  }

  @override
  Future init() async {
    super.init();
    await getDBData();
  }
}

var stockPointsManager = StockpointsManager();
