import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/availability.dart';
import 'package:solutech_sat/data/models/photo.dart';
import 'package:solutech_sat/data/models/posm.dart';
import 'package:solutech_sat/data/models/posm_material.dart';
import 'package:solutech_sat/data/models/product_update.dart';
import 'package:solutech_sat/data/models/session.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/sod.dart';
import 'package:solutech_sat/data/models/sos.dart';
import 'package:solutech_sat/data/models/sos_item.dart';
import 'package:solutech_sat/data/models/timesheet.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
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
  List<Sod> sods = [];
  List<Photo> sodPhotos = [];
  bool _loadingSods = false;

  Future getDBData() async {
    sods = await db.sodBean.getAll();
    sodPhotos = (await db.photoBean.getAll())
        .where((photoItem) => photoItem.source == "shareofdisplay")
        .toList();
    notifyChanges();
  }

  bool get loadingSods => _loadingSods;

  set loadingSods(bool show) {
    _loadingSods = show;
    notifyChanges();
  }

  Future saveSod(Sod sod, List<String> photos) async {
    var recordId = await db.sodBean.insert(sod
      ..fromServer = false
      ..synced = false);
    for (var url in photos) {
      await db.photoBean.insert(Photo(
        source: "shareofdisplay",
        sourceId: recordId,
        photoName: url,
      ));
    }
    await getDBData();
    syncManager.sync();
  }

  Future loadSods([List<DateTime> pickedDates]) async {
    loadingSods = true;
    var filterDates = filterDatesFrom(pickedDates);
    return api.getSods(filterDates).then((response) async {
      if (response.data["status"] == 1 || response.data["status"] == 0) {
        var data = response.data["payload"];
        await _saveSodsLocally(data);
        loadingSods = false;
        return response;
      } else {
        loadingSods = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  List<Photo> getSodPhotosFor(int sodId) {
    return sodPhotos.where((sodPhoto) => sodPhoto.sourceId == sodId).toList();
  }

  bool hasTodaysRecord(int customerId) {
    var now = DateTime.now();
    return sods
            .where((Sod sod) =>
                int.parse("${sod.shopId ?? 0}") == customerId &&
                DateTime(sod.entryTime.year, sod.entryTime.month,
                        sod.entryTime.day) ==
                    DateTime(now.year, now.month, now.day))
            .toList()
            .length >
        0;
  }

  Future _saveSodsLocally(data) async {
    await db.sodBean.removeAll();
    await db.photoBean.removeAll();

    for (var item in data) {
      await db.sodBean.insert(
        Sod.fromMap(item)
          ..synced = true
          ..fromServer = true,
      );
      for (var photo in item["imageslist"]) {
        await db.photoBean.insert(Photo.fromMap(photo));
      }
    }
    print("Sods and photos saved ");
    await getDBData();
  }

  Future<List<Map<String, String>>> _buildSodPhotos(int recordId) async {
    List<Map<String, String>> photos = [];

    for (var item
        in sodPhotos.where((sod) => sod.sourceId == recordId).toList()) {
      photos.add({"photo": await base64FromFile(File(item.photoName))});
    }
    return photos;
  }

  Future syncSod() async {
    await getDBData();
    List<Sod> unsyncedSods =
        sods.where((Sod sods) => sods.synced == false).toList();
    for (Sod sod in unsyncedSods) {
      if (routePlansManager
          .getCustomerById(int.parse("${sod.shopId}"))
          .synced) {
        try {
          var photos = await _buildSodPhotos(sod.id);
          print("SOD_PHOTOS ${photos.length}");
          var response = await api.saveSod({
            "rep_id": authManager.user.id,
            "shop_id": routePlansManager
                .getCustomerById(int.parse("${sod.shopId}"))
                ?.shopId,
            'display_type': sod.displayType,
            'notes': sod.notes,
            "brand": sod.brand,
            "competitor": sod.competitor,
            "quantity": sod.quantity,
            "latitude": sod.latitude,
            "longitude": sod.longitude,
            "entry_time": formatDate(sod.entryTime?.toString(), "xt"),
            'photos': json.encode(await _buildSodPhotos(sod.id)),
          });

          if (response.data["status"] == 1) {
            _onSodSyncResponse(response.data, sod);
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

  _onSodSyncResponse(data, Sod sod) {
    db.sodBean.update(sod..synced = true);
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

var sodManager = SosManager();
