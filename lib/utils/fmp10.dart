import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/auth_data.dart';
import 'package:solutech_sat/data/models/user.dart';

class FMP10 {
  MethodChannel _fmp10Channel = const MethodChannel('sat.solutech.com/fmp10');

  Future<String> openFiscalCheckWithDefaultValues() async {
    return await _fmp10Channel.invokeMethod('openFiscalCheckWithDefaultValues');
  }

  Future<String> command54Variant0Version0([String text = ""]) async {
    return await _fmp10Channel
        .invokeMethod('command54Variant0Version0', <String, String>{
      "text": text,
    });
  }

  Future<String> sellThisWithQuantity(
    String saleDescription,
    String taxCode,
    String singlePrice,
    String quantity,
  ) async {
    return await _fmp10Channel
        .invokeMethod('sellThisWithQuantity', <String, String>{
      "saleDescription": saleDescription,
      "taxCode": taxCode,
      "singlePrice": singlePrice,
      "quantity": quantity
    });
  }

  Future<String> command51Variant0Version1(
      String subTotalWithPercentDiscount) async {
    return await _fmp10Channel
        .invokeMethod('command51Variant0Version1', <String, String>{
      "subTotalWithPercentDiscount": subTotalWithPercentDiscount,
    });
  }

  Future<String> totalInCash() async {
    return await _fmp10Channel.invokeMethod('totalInCash');
  }

  Future<bool> generateZReport() async {
    return await _fmp10Channel.invokeMethod('generateZ');
  }

  Future<String> closeFiscalCheck() async {
    return await _fmp10Channel.invokeMethod('closeFiscalCheck');
  }

  Future<String> checkAndResolve() async {
    return await _fmp10Channel.invokeMethod('checkAndResolve');
  }

  Future<String> command109Variant0Version0(String value) async {
    return await _fmp10Channel
        .invokeMethod('command109Variant0Version0', <String, String>{
      "value": value,
    });
  }

  Future<String> command120Variant1Version0() async {
    return await _fmp10Channel.invokeMethod('command120Variant1Version0');
  }
}

var fmp10 = FMP10();
