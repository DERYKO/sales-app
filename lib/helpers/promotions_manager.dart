import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/brand.dart';
import 'package:solutech_sat/data/models/commons.dart';
import 'package:solutech_sat/data/models/date_week.dart';
import 'package:solutech_sat/data/models/initiative_free.dart';
import 'package:solutech_sat/data/models/initiative_qualify.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/promotion.dart';
import 'package:solutech_sat/data/models/shop_category.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/tools/manager.dart';

class PromotionsManager extends Manager {
  static PromotionsManager instance;
  factory PromotionsManager() => instance ??= PromotionsManager._instance();
  PromotionsManager._instance();
  List<Promotion> promotions = [];
  List<InitiativeQualify> initiativesQualify = [];
  List<InitiativeFree> initiativesFree = [];

  Future getDBData() async {
    promotions = await db.promotionBean.getAll();
    initiativesQualify = await db.initiativeQualifyBean.getAll();
    initiativesFree = await db.initiativeFreeBean.getAll();
    notifyChanges();
  }

  Promotion promotionById(int promotionId) {
    return promotions.firstWhere((promotion) => promotion.id == promotionId,
        orElse: () => null);
  }

  Promotion promotionFor(int productId) {
    InitiativeQualify qualified = initiativesQualify.firstWhere(
        (qualified) => qualified.qualifiedProduct == productId,
        orElse: () => null);
    return (qualified != null)
        ? promotions.firstWhere(
            (promotion) => promotion.id == qualified.initiativeId,
            orElse: () => null)
        : null;
  }

  List<InitiativeFree> freeInitiativesFor(int initiativeId) {
    return initiativesFree
        .where((free) => free.initiativeId == initiativeId)
        .toList();
  }

  Future loadPromotions() {
    return api.getPromotions().then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _savePromotionsLocally(payload);
        return response;
      } else {
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future _savePromotionsLocally(payload) async {
    await db.promotionBean.removeAll();
    for (var item in payload) {
      await db.promotionBean.insert(Promotion.fromMap(item));
      for (var qualify in item["initiatives_qualify"]) {
        await db.initiativeQualifyBean
            .insert(InitiativeQualify.fromMap(qualify));
      }

      for (var free in item["initiatives_free"]) {
        await db.initiativeFreeBean.insert(InitiativeFree.fromMap(free));
      }
    }
    print("Promotions saved");
    await getDBData();
  }

  @override
  Future init() async {
    super.init();
    await getDBData();
  }
}

var promotionsManager = PromotionsManager();
