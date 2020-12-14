import 'dart:convert';
import 'dart:io';

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
import 'package:solutech_sat/data/models/stock_take.dart';
import 'package:solutech_sat/data/models/stock_take_item.dart';
import 'package:solutech_sat/data/models/stockpoint.dart';
import 'package:solutech_sat/data/models/update_profile.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/manager.dart';
import 'package:solutech_sat/utils/format_utils.dart';
import 'package:solutech_sat/utils/image_utils.dart';

class StockTakesManager extends Manager {
  static StockTakesManager instance;
  factory StockTakesManager() => instance ??= StockTakesManager._instance();
  StockTakesManager._instance();
  List<StockTake> stockTakes = [];
  List<StockTakeItem> stockTakeItems = [];

  Future getDBData() async {
    stockTakes = await db.stockTakeBean.getAll();
    stockTakeItems = await db.stockTakeItemBean.getAll();
    notifyChanges();
  }

  Future saveStockTake(
      {StockTake order, List<StockTakeItem> stockTakeItems}) async {
    int result = await db.stockTakeBean.insert(
      order
        ..visitid = sessionManager.session?.sessionId ?? ""
        ..synced = false
        ..fromServer = false,
    );
    for (var item in stockTakeItems) {
      await db.stockTakeItemBean.insert(item..stockTakeId = result);
    }
    print("Stock take inserted");
    await getDBData();
    syncManager.sync();
  }

  Future loadStockTakes(pickedDates) {
    showLoader(true);
    var filterDates = filterDatesFrom(pickedDates, "yyyy-MM-dd");
    return api.getStockTakes(filterDates).then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveStockTakesLocally(payload);
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

  Future _saveStockTakesLocally(payload) async {
    await db.stockTakeBean.removeAll();
    await db.stockTakeItemBean.removeAll();
    for (var item in payload) {
      var recordId = await db.stockTakeBean.insert(StockTake.fromMap(item));
      for (var stockTakeItem in item["stockitems"]) {
        await db.stockTakeItemBean.insert(StockTakeItem(
          stockTakeId: recordId,
          productId: stockTakeItem["product_id"],
          quantity: stockTakeItem["quantity"],
          packaging: stockTakeItem["packaging"],
        ));
      }
    }
    print("Stock takes saved");
    await getDBData();
  }

  List<StockTakeItem> stockTakeItemsFromStockTakeId(int stockTakeId) {
    return stockTakeItems
        .where((orderItem) => orderItem.stockTakeId == stockTakeId)
        .toList();
  }

  List<Map<String, dynamic>> _buildStockTakeItems(int orderId) {
    var items = stockTakeItemsFromStockTakeId(orderId);
    return items
        .where((orderItem) => orderItem.stockTakeId == orderId)
        .toList()
        .map((orderItem) {
      return {
        "product_id": orderItem.productId,
        "quantity": orderItem.quantity,
        "packaging": (orderItem.packaging == "ctns") ? "crt" : "pcs",
      };
    }).toList();
  }

  Future syncStockTakes() async {
    await getDBData();
    List<StockTake> unsyncedStockTakes = stockTakes
        .where((StockTake stockTake) => stockTake.synced == false)
        .toList();
    for (StockTake stockTake in unsyncedStockTakes) {
      if (routePlansManager.getCustomerById(stockTake.outletId).synced) {
        try {
          var response = await api.saveStockTake({
            "latitude": stockTake.latitude,
            "visitid": stockTake.visitid,
            "longitude": stockTake.longitude,
            "entry_time": formatDate(stockTake.entryTime?.toString(), "xt"),
            "saler_id": stockTake.salerId,
            "items": json.encode(_buildStockTakeItems(stockTake.id)),
            "shop_id": int.parse(
              "${routePlansManager.getCustomerById(stockTake.outletId).shopId}",
            ),
            "stockphoto": (stockTake.stockphoto != null &&
                    stockTake.stockphoto.trim() != "")
                ? await base64FromFile(File(stockTake.stockphoto))
                : null,
          });
          if (response.data["status"] == 1) {
            _onSkipRecordSyncResponse(response.data, stockTake);
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

  bool hasTodaysRecord(int customerId) {
    var now = DateTime.now();
    return stockTakes
            .where((StockTake stockTake) =>
                int.parse("${stockTake.outletId ?? 0}") == customerId &&
                DateTime(stockTake.entryTime.year, stockTake.entryTime.month,
                        stockTake.entryTime.day) ==
                    DateTime(now.year, now.month, now.day))
            .toList()
            .length >
        0;
  }

  _onSkipRecordSyncResponse(data, StockTake stockTake) {
    db.stockTakeBean.update(stockTake..synced = true);
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

var stockTakesManager = StockTakesManager();
