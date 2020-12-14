import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/brand.dart';
import 'package:solutech_sat/data/models/commons.dart';
import 'package:solutech_sat/data/models/date_week.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/shop_category.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/tools/manager.dart';

class BrandsManager extends Manager {
  static BrandsManager instance;
  factory BrandsManager() => instance ??= BrandsManager._instance();
  BrandsManager._instance();
  List<Brand> brands = [];

  List<String> get categories => [
        ...Set.from(brands
            .where((brand) => (roleManager.hasRole(Roles.COMPETITOR_SOS))
                ? true
                : brand.iscompetitor == "NO")
            .toList()
            .map<String>((brand) => brand.category)
            .toList())
      ];

  List<Brand> getBrandByCategory(String category) {
    return brands
        .where((brand) => brand.category == category)
        .where((brand) => (roleManager.hasRole(Roles.COMPETITOR_SOS))
            ? true
            : brand.iscompetitor == "NO")
        .toList();
  }

  List<Map> get brandCategories {
    var categories = [];
    List<Map> brandCategories = [];
    for (var brand in brands
        .where((brand) => (roleManager.hasRole(Roles.COMPETITOR_SOS))
            ? true
            : brand.iscompetitor == "NO")
        .toList()) {
      if (!categories.contains(brand.category)) {
        categories.add(brand.category);
        brandCategories.add({
          "category": brand.category,
          "brands": [brand]
        });
      } else {
        int categoryIndex = categories.indexOf(brand.category);
        brandCategories[categoryIndex]["brands"].add(brand);
      }
    }
    return brandCategories;
  }

  Future getDBData() async {
    brands = await db.brandBean.getAll();
    notifyChanges();
  }

  Future loadBrands() {
    return api.getBrands().then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveBrandsLocally(payload);
        return response;
      } else {
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future _saveBrandsLocally(payload) async {
    await db.brandBean.removeAll();
    for (var item in payload) {
      await db.brandBean.insert(Brand.fromMap(item));
    }
    print("Brands saved");
    await getDBData();
  }

  @override
  Future init() async {
    super.init();
    await getDBData();
  }
}

var brandsManager = BrandsManager();
