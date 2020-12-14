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
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/sos.dart';
import 'package:solutech_sat/data/models/sos_item.dart';
import 'package:solutech_sat/data/models/timesheet.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/manager.dart';
import 'package:solutech_sat/utils/format_utils.dart';
import 'package:solutech_sat/utils/image_utils.dart';

import '../data/models/competitor_activity.dart';

class SosManager extends Manager {
  static SosManager instance;
  factory SosManager() => instance ??= SosManager._instance();
  SosManager._instance();
  List<Sos> sos = [];
  List<SosItem> sosItems = [];
  bool _loadingSos = false;

  Future getDBData() async {
    sos = await db.sosBean.getAll();
    sosItems = await db.sosItemBean.getAll();
    notifyChanges();
  }

  bool get loadingSos => _loadingSos;

  set loadingSos(bool show) {
    _loadingSos = show;
    notifyChanges();
  }

  Future saveSos(Sos sos, List<SosItem> items) async {
    var recordId = await db.sosBean.insert(sos);
    for (var item in items) {
      item.sosId = recordId;
      await db.sosItemBean.insert(item);
    }
    print("Sos saved");
    await getDBData();
    syncManager.sync();
  }

  Future loadSos([List<DateTime> pickedDates]) async {
    loadingSos = true;
    var filterDates = filterDatesFrom(pickedDates);
    return api.getSos(filterDates).then((response) async {
      if (response.data["status"] == 1 || response.data["status"] == 0) {
        var data = response.data["payload"];
        await _saveSosLocally(data);
        loadingSos = false;
        return response;
      } else {
        loadingSos = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  bool hasTodaysRecordForCategory(int customerId, String category) {
    var now = DateTime.now();
    return sos
            .where((Sos sos) =>
                int.parse("${sos.shopId ?? 0}") == customerId &&
                DateTime(sos.entryTime.year, sos.entryTime.month,
                        sos.entryTime.day) ==
                    DateTime(now.year, now.month, now.day) &&
                sos.productCategory == category)
            .toList()
            .length >
        0;
  }

  List<SosItem> todaysSosItemsFor(int customerId, String category) {
    var now = DateTime.now();
    List<int> sosIds = sos
        .where((Sos sos) =>
            int.parse("${sos.shopId ?? 0}") == customerId &&
            DateTime(sos.entryTime.year, sos.entryTime.month,
                    sos.entryTime.day) ==
                DateTime(now.year, now.month, now.day) &&
            sos.productCategory == category)
        .toList()
        .map((Sos sos) => sos.id)
        .toList();

    return sosItems.where((sosItem) => sosIds.contains(sosItem.sosId)).toList();
  }

  List<SosItem> getSosItemsFor(int sosId) {
    return sosItems.where((sosItem) => sosItem.sosId == sosId).toList();
  }

  Sos getSosWhere(int productId, int customerId, String productCategory) {
    var now = DateTime.now();
    return sos.firstWhere(
        (Sos sos) =>
            int.parse("${sos.shopId ?? 0}") == customerId &&
            DateTime(sos.entryTime.year, sos.entryTime.month,
                    sos.entryTime.day) ==
                DateTime(now.year, now.month, now.day) &&
            sos.productCategory == productCategory,
        orElse: () => null);
  }

  bool hasTodaysRecord(int customerId) {
    var now = DateTime.now();
    return sos
            .where((Sos sos) =>
                int.parse("${sos.shopId ?? 0}") == customerId &&
                DateTime(sos.entryTime.year, sos.entryTime.month,
                        sos.entryTime.day) ==
                    DateTime(now.year, now.month, now.day))
            .toList()
            .length >
        0;
  }

  Future _saveSosLocally(data) async {
    await db.sosBean.removeAll();
    await db.sosItemBean.removeAll();
    for (var item in data) {
      await db.sosBean.insert(
        Sos.fromMap(item)
          ..shopName = Customer.fromMap(item["shop"]).shopName
          ..synced = true
          ..fromServer = true,
      );
      for (var sosItem in item["sos_details"]) {
        await db.sosItemBean.insert(SosItem.fromMap(sosItem));
      }
    }
    print("Sos saved");
    await getDBData();
  }

  List<Map> _buildSosItems(int recordId) {
    return sosItems
        .where((sosItem) => sosItem.sosId == recordId)
        .where((sosItem) => (roleManager.hasRole(Roles.USE_FACINGS_SOS) &&
                roleManager.hasRole(Roles.USE_LENGTH_SOS))
            ? (int.parse("${sosItem.facings != "" ? sosItem.facings : 0}") !=
                    0) ||
                (int.parse("${sosItem.length != "" ? sosItem.length : 0}") != 0)
            : int.parse("${sosItem.position != "" ? sosItem.position : 0}") !=
                0)
        .map((sosItem) {
      return {
        "product_id": sosItem.productId,
        "product_name": sosItem.productName,
        "facings": sosItem.facings,
        "length": sosItem.length,
        "position": sosItem.position
      };
    }).toList();
  }

  Future syncSos() async {
    await getDBData();
    List<Sos> unsyncedSos =
        sos.where((Sos sos) => sos.synced == false).toList();
    for (Sos sos in unsyncedSos) {
      if (routePlansManager
          .getCustomerById(int.parse("${sos.shopId}"))
          .synced) {
        try {
          var currentLocation = await locationManager.currentLocation();
          var response = await api.saveSos({
            "rep_id": authManager.user.id,
            "shop_id": routePlansManager
                .getCustomerById(int.parse("${sos.shopId}"))
                ?.shopId,
            'product_category': sos.productCategory,
            'total_facings': sos.totalFacings,
            "total_length": sos.totalLength,
            "sos_notes": sos.sosNotes,
            "entry_time": formatDate(sos.entryTime?.toString(), "xt"),
            "sositems": json.encode(_buildSosItems(sos.id)),
            'photo': (sos.photo != null && sos.photo.trim() != "")
                ? await base64FromFile(File(sos.photo))
                : null,
          });

          if (response.data["status"] == 1) {
            _onSosSyncResponse(response.data, sos);
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

  _onSosSyncResponse(data, Sos sos) {
    db.sosBean.update(sos..synced = true);
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

var sosManager = SosManager();
