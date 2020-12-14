import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/models/sales_summary.dart';
import 'package:solutech_sat/data/models/update_profile.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/tools/manager.dart';

class StatsManager extends Manager {
  static StatsManager instance;
  factory StatsManager() => instance ??= StatsManager._instance();
  StatsManager._instance();
  SharedPreferences _prefs;
  final String SALES_SUMMARY = "salesSummary";

  SalesSummary get salesSummary {
    String _salesSummary = _prefs?.getString("salesSummary") ?? null;
    if (_salesSummary == null) return null;
    return SalesSummary.fromMap(json.decode(_salesSummary));
  }

  Future setSalesSummary(SalesSummary salesSummary) async {
    _prefs = await SharedPreferences.getInstance();
    salesSummary.performance =
        "${double.parse("${"${double.parse(salesSummary.monthSales ?? 0.0) / double.parse("${salesSummary.monthTarget}") * 100}"}").toStringAsFixed(2)}";
    String summary = json.encode(salesSummary.toMap());
    _prefs.setString(SALES_SUMMARY, summary);
  }

  void addSale(double sale, int shopId) {
    var monthlySale = double.parse("${salesSummary.monthSales ?? 0.0}") + sale;
    var totalSale = double.parse("${salesSummary.totalSales ?? 0.0}") + sale;
    var actual = int.parse("${salesSummary.actual ?? 0}") + 1;
    var success = int.parse("${salesSummary.success ?? 0}");
    if (!recordsManager.hasTodaysRecord(shopId, "Sale")) {
      success = int.parse("${salesSummary.success ?? 0}") + 1;
    }

    setSalesSummary(salesSummary
      ..monthSales = "$monthlySale"
      ..totalSales = "$totalSale"
      ..actual = "$actual"
      ..success = "$success");
    notifyChanges();
  }

  void addActual([int value = 1]) {
    var actual = int.parse("${salesSummary.actual ?? 0}") + value;
    setSalesSummary(salesSummary..actual = "$actual");
    notifyChanges();
  }

  Future loadSalesSummary() {
    return api.getRepSummary().then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await setSalesSummary(SalesSummary.fromMap(payload));
        return response;
      } else {
        throw DioError(
          response: response,
        );
      }
    });
  }

  @override
  Future init() async {
    super.init();
    _prefs = await SharedPreferences.getInstance();
  }
}

var statsManager = StatsManager();
