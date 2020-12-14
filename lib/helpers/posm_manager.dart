import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/availability.dart';
import 'package:solutech_sat/data/models/posm.dart';
import 'package:solutech_sat/data/models/posm_material.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/manager.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class PosmManager extends Manager {
  static PosmManager instance;
  factory PosmManager() => instance ??= PosmManager._instance();
  PosmManager._instance();
  List<Posm> posms = [];
  List<PosmMaterial> posmMaterials = [];
  bool _loadingPosms = false;
  bool _loadingPosmMaterials = false;

  Future getDBData() async {
    posms = await db.posmBean.getAll();
    posmMaterials = await db.posmMaterialBean.getAll();
    notifyChanges();
  }

  bool get loadingPosms => _loadingPosms;

  set loadingPosms(bool show) {
    _loadingPosms = show;
    notifyChanges();
  }

  bool get loadingPosmMaterials => _loadingPosmMaterials;

  set loadingPosmMaterials(bool show) {
    _loadingPosmMaterials = show;
    notifyChanges();
  }

  Future loadPosmMaterials() async {
    loadingPosmMaterials = true;
    await db.posmMaterialBean.removeAll();
    return api.getPosmMaterials().then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _savePosmMaterialsLocally(payload);
        loadingPosmMaterials = false;
        return response;
      } else {
        loadingPosmMaterials = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  PosmMaterial posmMaterialById(int id) {
    return posmMaterials.firstWhere(
      (posmMaterial) => posmMaterial.id == id,
      orElse: () => null,
    );
  }

  bool hasTodaysRecord(
    int customerId,
  ) {
    var now = DateTime.now();
    return posms
            .where((Posm posm) =>
                posm.shopId == customerId &&
                DateTime(posm.entryTime.year, posm.entryTime.month,
                        posm.entryTime.day) ==
                    DateTime(now.year, now.month, now.day))
            .toList()
            .length >
        0;
  }

  List<Posm> todaysPosmsByCustomerId(int customerId) {
    var now = DateTime.now();
    return posms
        .where((Posm posm) =>
            posm.shopId == customerId &&
            DateTime(posm.entryTime.year, posm.entryTime.month,
                    posm.entryTime.day) ==
                DateTime(now.year, now.month, now.day))
        .toList();
  }

  savePosmAudit(Posm posm) async {
    int result = await db.posmBean.insert(posm
      ..visitId = sessionManager.session.sessionId
      ..synced = false
      ..fromServer = false);
    print("Posm inserted");
    await getDBData();
    syncManager.sync();
  }

  Future loadPosm([List<DateTime> pickedDates]) async {
    loadingPosms = true;
    posmMaterials.clear();
    await db.posmBean.removeAll();
    var filterDates = filterDatesFrom(pickedDates);
    return api.getPosm(filterDates).then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _savePosmsLocally(payload);
        loadingPosms = false;
        return response;
      } else {
        loadingPosms = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future _savePosmsLocally(payload) async {
    await db.posmBean.removeAll();
    for (var item in payload) {
      await db.posmBean.insert(Posm.fromMap(item)
        ..synced = true
        ..fromServer = true);
    }
    print("Posms saved");
    await getDBData();
  }

  Future _savePosmMaterialsLocally(payload) async {
    List<PosmMaterial> posmMaterials = [];
    for (var item in payload) {
      posmMaterials.add(PosmMaterial.fromMap(item));
    }
    if (posmMaterials.length > 0) {
      await db.posmMaterialBean.insertMany(posmMaterials);
    }
    await getDBData();
  }

  Future updatePosmCustomerId(int oldId, int newId) async {
    List<Posm> posms = await db.posmBean.findWhere(
        db.posmBean.shopId.iss(oldId).and(db.posmBean.synced.iss(false)));
    for (var i = 0; i < posms.length; i++) {
      posms[i].shopId = newId;
    }

    await db.posmBean.updateMany(posms);
    getDBData();
    syncManager.sync();
  }

  Future syncPosm() async {
    List<Posm> unsyncedPosms =
        posms.where((Posm posm) => posm.synced == false).toList();
    for (Posm posm in unsyncedPosms) {
      if (routePlansManager
          .getCustomerById(int.parse("${posm.shopId}"))
          .synced) {
        try {
          var response = await api.savePosmAudit({
            "user_id": authManager.user.id,
            'shop_id': routePlansManager
                .getCustomerById(int.parse("${posm.shopId}"))
                ?.shopId,
            "visitid": posm.visitId,
            "brand": posm.productName,
            "items": "${json.encode([
              {
                "item_id": posm.itemId,
                "itemname": posm.itemname,
                "itemtype": posmMaterialById(posm.itemId).itemtype,
                "availability": posm.availability,
                "stocked": posm.stocked,
                "visibility": posm.visibility,
              }
            ])}",
            'notes': posm.notes,
            'entry_time': formatDate(posm.entryTime?.toString(), "xt"),
            "lon": posm.longitude,
            "lat": posm.latitude,
          });

          if (response.data["status"] == 1) {
            _onPosmAuditSyncResponse(response.data, posm);
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

  _onPosmAuditSyncResponse(data, Posm posm) async {
    await db.posmBean.update(posm..synced = true);
    await getDBData();
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

var posmManager = PosmManager();
