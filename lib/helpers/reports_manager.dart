import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/cat.dart';
import 'package:solutech_sat/data/models/feedback.dart';
import 'package:solutech_sat/data/models/monthly_performance.dart';
import 'package:solutech_sat/data/models/order.dart';
import 'package:solutech_sat/data/models/order_item.dart';
import 'package:solutech_sat/data/models/performance.dart';
import 'package:solutech_sat/data/models/skip_record.dart';
import 'package:solutech_sat/data/models/sku.dart';
import 'package:solutech_sat/data/models/status_update.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/stats_manager.dart';
import 'package:solutech_sat/tools/manager.dart';
import 'package:solutech_sat/utils/device_utils.dart';
import 'package:solutech_sat/utils/format_utils.dart';
import 'package:solutech_sat/utils/image_utils.dart';

class ReportsManager extends Manager {
  static ReportsManager instance;
  factory ReportsManager() => instance ??= ReportsManager._instance();
  ReportsManager._instance();
  bool _loadingMonthlyPerformance = false;
  bool _loadingPerformance = false;
  bool _loadingCatlist = false;
  bool _loadingSkusByCategory = false;
  List<MonthlyPerformance> monthlyPerformance = [];
  List<Performance> performances = [];
  List<Cat> catList = [];
  List<Sku> skusByCategory = [];

  bool get loadingMonthlyPerformance => _loadingMonthlyPerformance;
  bool get loadingPerformance => _loadingPerformance;
  set loadingMonthlyPerformance(bool show) {
    _loadingMonthlyPerformance = show;
    notifyChanges();
  }

  set loadingPerformance(bool show) {
    _loadingPerformance = show;
    notifyChanges();
  }

  bool get loadingCatlist => _loadingCatlist;

  set loadingCatlist(bool show) {
    _loadingCatlist = show;
    notifyChanges();
  }

  bool get loadingSkusByCategory => _loadingSkusByCategory;

  set loadingSkusByCategory(bool show) {
    _loadingSkusByCategory = show;
    notifyChanges();
  }

  Future loadMonthlyPerformance() {
    loadingMonthlyPerformance = true;
    return api.getMonthlyPerformance().then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveMonthlyPerformanceLocally(payload);
        loadingMonthlyPerformance = false;
        return response;
      } else {
        loadingMonthlyPerformance = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future loadPerformance(
    List<DateTime> pickedDates,
    int year,
    int period,
  ) {
    loadingPerformance = true;
    var filterDates = filterDatesFrom(pickedDates);
    return api.getPerformance(filterDates, year, period).then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _savePerformanceLocally(payload);
        loadingPerformance = false;
        return response;
      } else {
        loadingPerformance = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future loadCatlist([List<DateTime> pickedDates]) {
    loadingCatlist = true;
    var filterDates = filterDatesFrom(pickedDates, "yyyy-MM-dd");
    return api.getCatlist(filterDates).then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveCatlistLocally(payload);
        loadingCatlist = false;
        return response;
      } else {
        loadingCatlist = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future loadSkusByCategory(String category, [List<DateTime> pickedDates]) {
    loadingSkusByCategory = true;
    var filterDates = filterDatesFrom(pickedDates);
    return api.getSkusByCategory(category, filterDates).then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveSkusByCategorylistLocally(payload);
        loadingSkusByCategory = false;
        return response;
      } else {
        loadingSkusByCategory = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future _saveMonthlyPerformanceLocally(payload) async {
    monthlyPerformance.clear();
    for (var item in payload) {
      monthlyPerformance.add(MonthlyPerformance.fromMap(item));
    }
    notifyChanges();
  }

  Future _savePerformanceLocally(payload) async {
    performances.clear();
    for (var item in payload) {
      performances.add(Performance.fromMap(item));
    }
    notifyChanges();
  }

  Future _saveCatlistLocally(payload) async {
    catList.clear();
    for (var item in payload) {
      catList.add(Cat.fromMap(item));
    }
    notifyChanges();
  }

  Future _saveSkusByCategorylistLocally(payload) async {
    skusByCategory.clear();
    for (var item in payload) {
      skusByCategory.add(Sku.fromMap(item));
    }
    notifyChanges();
  }

  @override
  Future init() async {
    super.init();
  }
}

var reportsManager = ReportsManager();
