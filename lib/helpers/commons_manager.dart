import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/commons.dart';
import 'package:solutech_sat/data/models/date_week.dart';
import 'package:solutech_sat/data/models/feedback_category.dart';
import 'package:solutech_sat/data/models/must_have_sku.dart';
import 'package:solutech_sat/data/models/packaging_option.dart';
import 'package:solutech_sat/data/models/payment_mode.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/shop_category.dart';
import 'package:solutech_sat/tools/manager.dart';

class CommonsManager extends Manager {
  static CommonsManager instance;
  factory CommonsManager() => instance ??= CommonsManager._instance();
  CommonsManager._instance();
  DateTime startTime;
  List<Product> products = [];
  List<AppData> appData = [];
  List<PackagingOption> packagingOptions = [
    /*PackagingOption(packageName: "Pieces", packageKey: "pcs"),
    PackagingOption(packageName: "Cartons", packageKey: "ctns")*/
  ];
  List<ShopCategory> shopCategories = [];
  List<FeedbackCategory> feedbackCategories = [];
  List<PaymentMode> paymentModes = [];
  List<MustHaveSku> mustHaveSkus = [];
  List<DateWeek> dateWeeks = [];

  void setStartTime(DateTime time) {
    startTime = time;
    notifyChanges();
  }

  List<String> get productCategories {
    return [
      ...Set.from(
        products.map((product) => product.productCategory),
      ),
    ];
  }

  List<String> mustHaveProductCategories(shopCatId) {
    return [
      ...Set.from((shopCatId != null &&
                  (commonsManager.mustHaveSkus
                          .where((mustHaveSku) =>
                              mustHaveSku.customercategory == shopCatId)
                          .length >
                      0)
              ? commonsManager.products
                  .where((product) => (commonsManager.mustHaveSkus
                      .where((mustHaveSku) =>
                          mustHaveSku.customercategory == shopCatId)
                      .map<int>((mustHaveSku) => mustHaveSku.productId)
                      .toList()
                      .contains(product.productId)))
                  .toList()
              : commonsManager.products.toList())
          .map((product) => product.productCategory)),
    ];
  }

  List<AppData> get skipReasons {
    return appData.where((data) => data.category == "Skip Reason").toList();
  }

  List<AppData> get statusCategory {
    return appData.where((data) => data.category == "Status Category").toList();
  }

  List<AppData> get displayTypes {
    return appData.where((data) => data.category == "Display-Type").toList();
  }

  List<AppData> get photoCategories {
    return appData.where((data) => data.category == "Photo Category").toList();
  }

  Product productById(int productId) {
    return products.firstWhere((product) => product.productId == productId,
        orElse: () => null);
  }

  List<Product> productsByCategory(String category) {
    return products
        .where((product) => product.productCategory == category)
        .toList();
  }

  ShopCategory shopCatById(int categoryId) {
    return shopCategories.firstWhere(
        (shopCat) => shopCat.shopcatId == categoryId,
        orElse: () => null);
  }

  Future getDBData() async {
    products = await db.productBean.getAll();
    appData = await db.appDataBean.getAll();
    shopCategories = await db.shopCategoryBean.getAll();
    dateWeeks = await db.dateWeekBean.getAll();
    paymentModes = await db.paymentModeBean.getAll();
    packagingOptions = await db.packagingOptionBean.getAll();
    mustHaveSkus = await db.mustHaveSkuBean.getAll();
    feedbackCategories = await db.feedbackCategoryBean.getAll();
    notifyChanges();
  }

  Future loadPaymentModes() {
    return api.getPaymentModes().then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _savePaymentModesLocally(payload);
        return response;
      } else {
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future loadFeedbackCategories() {
    return api.getFeedbackCategories().then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveFeedbackCategoriesLocally(payload);
        return response;
      } else {
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future loadMustHaveSkus() {
    return api.getMustHaveSkus().then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveMustHaveSkusLocally(payload);
        return response;
      } else {
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future loadPackagingOptions() {
    return api.getPackagingOptions().then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _savePackagingOptionsLocally(payload);
        return response;
      } else {
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future loadCommons() {
    return api.getCommons().then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveCommonsLocally(payload);
        return response;
      } else {
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future _saveMustHaveSkusLocally(payload) async {
    await db.mustHaveSkuBean.removeAll();
    for (var item in payload) {
      await db.mustHaveSkuBean.insert(MustHaveSku.fromMap(item));
    }
    await getDBData();
  }

  Future _savePaymentModesLocally(payload) async {
    await db.paymentModeBean.removeAll();
    for (var item in payload) {
      await db.paymentModeBean.insert(PaymentMode.fromMap(item));
    }
    await getDBData();
  }

  Future _saveFeedbackCategoriesLocally(payload) async {
    await db.feedbackCategoryBean.removeAll();
    for (var item in payload) {
      await db.feedbackCategoryBean.insert(FeedbackCategory.fromMap(item));
    }
    await getDBData();
  }

  List<Product> mustHaveProductsByCat(category, shopCatId) {
    return (shopCatId != null &&
            (commonsManager.mustHaveSkus
                    .where((mustHaveSku) =>
                        mustHaveSku.customercategory == shopCatId)
                    .length >
                0)
        ? commonsManager.products
            .where((product) =>
                (product.productCategory == category) &&
                (commonsManager.mustHaveSkus
                    .where((mustHaveSku) =>
                        mustHaveSku.customercategory == shopCatId)
                    .map<int>((mustHaveSku) => mustHaveSku.productId)
                    .toList()
                    .contains(product.productId)))
            .toList()
        : commonsManager.products
            .where((product) => product.productCategory == category)
            .toList());
  }

  Future _savePackagingOptionsLocally(payload) async {
    await db.packagingOptionBean.removeAll();
    for (var item in payload) {
      await db.packagingOptionBean.insert(PackagingOption.fromMap(item));
    }
    await getDBData();
  }

  Future _saveCommonsLocally(payload) async {
    Commons commons = Commons.fromMap(payload);
    await db.shopCategoryBean.removeAll();
    if (commons.shopCategories.length > 0) {
      for (var item in commons.shopCategories) {
        await db.shopCategoryBean.insert(item);
      }
      print("Shop categories saved");
    }

    await db.productBean.removeAll();
    if (commons.products.length > 0) {
      for (var item in commons.products) {
        await db.productBean.insert(item);
      }
      print("Products saved");
    }

    await db.appDataBean.removeAll();
    if (commons.appdata.length > 0) {
      for (var item in commons.appdata) {
        await db.appDataBean.insert(item);
      }
      print("App data saved");
    }

    await db.dateWeekBean.removeAll();
    if (commons.dateweeks.length > 0) {
      for (var item in commons.dateweeks) {
        await db.dateWeekBean.insert(item);
      }
      print("Date weeks saved");
    }
    await getDBData();
  }

  @override
  Future init() async {
    super.init();
    await getDBData();
  }
}

var commonsManager = CommonsManager();
