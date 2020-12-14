import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solutech_sat/data/models/sales_summary.dart';

class PreferenceManager {
  // Singleton
  static PreferenceManager instance;
  factory PreferenceManager() => instance ??= PreferenceManager._instance();
  PreferenceManager._instance();
  SharedPreferences prefs;
  final String SALES_SUMMARY = "salesSummary";

  Future saveSalesSummary(SalesSummary salesSummary) async {
    prefs = await SharedPreferences.getInstance();
    String summary = json.encode(salesSummary.toMap());
    prefs.setString(SALES_SUMMARY, summary);
  }

  Future<SalesSummary> getSalesSummary() async {
    prefs = await SharedPreferences.getInstance();
    String summary = prefs.getString(SALES_SUMMARY);
    return summary != null ? SalesSummary.fromMap(json.decode(summary)) : null;
  }

  clearPreferences() async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove(SALES_SUMMARY);
  }
}

var preferenceManager = PreferenceManager();
