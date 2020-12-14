import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/bank.dart';
import 'package:solutech_sat/data/models/banking.dart';
import 'package:solutech_sat/data/models/brand.dart';
import 'package:solutech_sat/data/models/cheque.dart';
import 'package:solutech_sat/data/models/commons.dart';
import 'package:solutech_sat/data/models/date_week.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/shop_category.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/manager.dart';
import 'package:solutech_sat/utils/device_utils.dart';
import 'package:solutech_sat/utils/format_utils.dart';
import 'package:solutech_sat/utils/image_utils.dart';

class BankingManager extends Manager {
  static BankingManager instance;
  factory BankingManager() => instance ??= BankingManager._instance();
  BankingManager._instance();
  List<Bank> banks = [];
  List<Cheque> cheques = [];
  List<Banking> bankings = [];
  SharedPreferences _prefs;
  bool _loadingBankings = false;
  Future getDBData() async {
    banks = await db.bankBean.getAll();
    cheques = await db.chequeBean.getAll();
    bankings = await db.bankingBean.getAll();
    notifyChanges();
  }

  bool get loadingBankings => _loadingBankings;

  set loadingBankings(bool show) {
    _loadingBankings = show;
    notifyChanges();
  }

  set cashToBank(double cashToBank) {
    _prefs.setDouble("cashToBank", cashToBank);
  }

  double get cashToBank {
    return _prefs.getDouble("cashToBank");
  }

  void saveBanking(Banking banking) async {
    await db.bankingBean.insert(banking
      ..userId = authManager.user.id
      ..synced = false
      ..fromServer = false);
    await getDBData();
    syncManager.sync();
  }

  Future loadBanks() {
    return api.getBanks().then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveBanksLocally(payload);
        return response;
      } else {
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future loadBankings([List<DateTime> pickedDates]) {
    loadingBankings = true;
    var filterDates = filterDatesFrom(pickedDates);
    return api.getBankings(filterDates).then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveBankingsLocally(payload);
        loadingBankings = false;
        return response;
      } else {
        loadingBankings = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future loadCheques() {
    return api.getToBankCheques().then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveToBankChequeLocally(payload);
        return response;
      } else {
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future loadCashToBank() {
    return api.getCashToBank().then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveToBankCashLocally(payload);
        return response;
      } else {
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future _saveToBankChequeLocally(payload) async {
    await db.chequeBean.removeAll();
    for (var item in payload) {
      await db.chequeBean.insert(Cheque.fromMap(item));
    }
    print("Cheques saved");
    await getDBData();
  }

  Future _saveToBankCashLocally(payload) async {
    cashToBank = double.parse("$payload");
    print("CashToBank saved");
    await getDBData();
  }

  Future _saveBankingsLocally(payload) async {
    await db.bankingBean.removeAll();
    for (var item in payload) {
      await db.bankingBean.insert(Banking.fromMap(item)
        ..synced = true
        ..fromServer = true);
    }
    print("Bankings saved");
    await getDBData();
  }

  Future _saveBanksLocally(payload) async {
    await db.bankBean.removeAll();
    for (var item in payload) {
      await db.bankBean.insert(Bank.fromMap(item));
    }
    print("Banks saved");
    await getDBData();
  }

  Future syncBanking() async {
    List<Banking> unsyncedBankings = (await db.bankingBean.getAll())
        .where((Banking banking) => banking.synced == false)
        .toList();
    for (Banking banking in unsyncedBankings) {
      try {
        var response = await api.saveBanking({
          "Battery": await battery.batteryLevel,
          "collection_id": banking.collectionId,
          "amount": banking.amount,
          "bank_id": banking.bankId,
          "user_id": banking.userId,
          "notes": banking.notes,
          "entry_type": banking.entryType,
          "shop_id": banking.customerId ?? 0,
          "entry_time": formatDate(banking.entryTime?.toString(), "xt"),
          "latitude": banking.latitude,
          "longitude": banking.longitude,
          "slip_photo":
              (banking.slipPhoto != null && banking.slipPhoto.trim() != "")
                  ? await base64FromFile(File(banking.slipPhoto))
                  : null,
        });

        if (response.data["status"] == 1) {
          var payload = response.data["payload"];
          _onBankingSyncResponse(payload, banking);
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

  _onBankingSyncResponse(data, Banking banking) {
    db.bankingBean.update(banking..synced = true);
    getDBData();
  }

  _onSyncError(error) {
    print("Error $error");
  }

  @override
  Future init() async {
    super.init();
    _prefs = await SharedPreferences.getInstance();
    await getDBData();
  }
}

var bankingManager = BankingManager();
