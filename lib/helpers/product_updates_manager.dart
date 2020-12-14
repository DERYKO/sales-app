import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/availability.dart';
import 'package:solutech_sat/data/models/posm.dart';
import 'package:solutech_sat/data/models/posm_material.dart';
import 'package:solutech_sat/data/models/product_update.dart';
import 'package:solutech_sat/data/models/session.dart';
import 'package:solutech_sat/data/models/timesheet.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/manager.dart';
import 'package:solutech_sat/utils/format_utils.dart';
import 'package:solutech_sat/utils/image_utils.dart';

class ProductUpdatesManager extends Manager {
  static ProductUpdatesManager instance;
  factory ProductUpdatesManager() =>
      instance ??= ProductUpdatesManager._instance();
  ProductUpdatesManager._instance();
  List<ProductUpdate> productUpdates = [];
  bool _loadingProductUpdates = false;

  Future getDBData() async {
    productUpdates = await db.productUpdateBean.getAll();
    notifyChanges();
  }

  bool get loadingProductUpdates => _loadingProductUpdates;

  set loadingProductUpdates(bool show) {
    _loadingProductUpdates = show;
    notifyChanges();
  }

  Future saveProductUpdate(ProductUpdate productUpdate) async {
    await db.productUpdateBean.insert(productUpdate);
    await getDBData();
    syncManager.sync();
  }

  Future loadProductUpdates([List<DateTime> pickedDates]) async {
    loadingProductUpdates = true;
    await db.posmBean.removeAll();
    var filterDates = filterDatesFrom(pickedDates);
    return api.getProductUpdates(filterDates).then((response) async {
      if (response.data["status"] == 1 || response.data["status"] == 0) {
        var payload = response.data["payload"];
        await _saveProductUpdatesLocally(payload);
        loadingProductUpdates = false;
        return response;
      } else {
        loadingProductUpdates = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  bool hasTodaysRecord(int customerId, String updateType) {
    var now = DateTime.now();
    return productUpdates
            .where(
              (ProductUpdate productUpdate) =>
                  int.parse("${productUpdate.shopId ?? 0}") == customerId &&
                  DateTime(
                          productUpdate.entryTime.year,
                          productUpdate.entryTime.month,
                          productUpdate.entryTime.day) ==
                      DateTime(now.year, now.month, now.day) &&
                  productUpdate.updateType == updateType,
            )
            .toList()
            .length >
        0;
  }

  Future _saveProductUpdatesLocally(payload) async {
    await db.productUpdateBean.removeAll();
    for (var item in payload) {
      await db.productUpdateBean.insert(
        ProductUpdate.fromMap(item)
          ..synced = true
          ..fromServer = true,
      );
    }
    print("Product updates saved");
    await getDBData();
  }

  Future syncProductUpdate() async {
    await getDBData();
    List<ProductUpdate> unsyncedProductUpdates = productUpdates
        .where((ProductUpdate availability) => availability.synced == false)
        .toList();
    for (ProductUpdate productUpdate in unsyncedProductUpdates) {
      if (routePlansManager
          .getCustomerById(int.parse("${productUpdate.shopId}"))
          .synced) {
        try {
          var currentLocation = await locationManager.currentLocation();

          var response = await api.saveProductUpdate({
            "rep_id": authManager.user.id,
            "shop_id": routePlansManager
                .getCustomerById(int.parse("${productUpdate.shopId}"))
                ?.shopId,
            "product_id": productUpdate.productId,
            'notes': productUpdate.notes,
            'update_type': productUpdate.updateType,
            'photo': (productUpdate.photo != null &&
                    productUpdate.photo.trim() != "")
                ? await base64FromFile(File(productUpdate.photo))
                : null,
            'quantity': productUpdate.quantity,
            "entry_time": formatDate(productUpdate.entryTime?.toString(), "xt"),
            if (productUpdate.updateType == "Expiry")
              "expiry_date":
                  formatDate(productUpdate.expiryDate?.toString(), "xt"),
            "longitude": "${currentLocation.longitude}",
            "visitid": productUpdate.visitId,
            "latitude": "${currentLocation.latitude}",
          });

          if (response.data["status"] == 1) {
            _onProductUpdateSyncResponse(response.data, productUpdate);
          } else {
            throw DioError(
              response: response,
            );
          }
        } catch (error) {
          _onSyncError(error);
        }
      }
    }
  }

  _onProductUpdateSyncResponse(data, ProductUpdate productUpdate) {
    db.productUpdateBean.update(productUpdate..synced = true);
    getDBData();
  }

  _onSyncError(error) {
    print("Error $error");
  }

  @override
  Future init() async {
    super.init();
    await getDBData();
  }
}

var productUpdatesManager = ProductUpdatesManager();
