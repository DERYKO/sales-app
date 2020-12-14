import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/availability.dart';
import 'package:solutech_sat/data/models/general_photo.dart';
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

class GeneralPhotosManager extends Manager {
  static GeneralPhotosManager instance;
  factory GeneralPhotosManager() =>
      instance ??= GeneralPhotosManager._instance();
  GeneralPhotosManager._instance();
  List<GeneralPhoto> generalPhotos = [];
  bool _loadingGeneralPhotos = false;

  Future getDBData() async {
    generalPhotos = await db.generalPhotoBean.getAll();
    notifyChanges();
  }

  bool get loadingGeneralPhotos => _loadingGeneralPhotos;

  set loadingGeneralPhotos(bool show) {
    _loadingGeneralPhotos = show;
    notifyChanges();
  }

  Future saveGeneralPhoto(GeneralPhoto generalPhoto) async {
    await db.generalPhotoBean.insert(generalPhoto
      ..fromServer = false
      ..synced = false);

    await getDBData();
    syncManager.sync();
  }

  Future loadGeneralPhotos([List<DateTime> pickedDates]) async {
    loadingGeneralPhotos = true;
    var filterDates = filterDatesFrom(pickedDates);
    return api.getGeneralPhotos(filterDates).then((response) async {
      if (response.data["status"] == 1 || response.data["status"] == 0) {
        var data = response.data["payload"];
        await _saveGeneralPhotosLocally(data);
        loadingGeneralPhotos = false;
        return response;
      } else {
        loadingGeneralPhotos = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  bool hasTodaysRecord(int customerId) {
    var now = DateTime.now();
    return generalPhotos
            .where((GeneralPhoto sod) =>
                int.parse("${sod.shopId ?? 0}") == customerId &&
                DateTime(sod.imageTime.year, sod.imageTime.month,
                        sod.imageTime.day) ==
                    DateTime(now.year, now.month, now.day))
            .toList()
            .length >
        0;
  }

  Future _saveGeneralPhotosLocally(data) async {
    await db.generalPhotoBean.removeAll();
    for (var item in data) {
      await db.generalPhotoBean.insert(
        GeneralPhoto.fromMap(item)
          ..synced = true
          ..fromServer = true,
      );
    }
    print("General photos saved");
    await getDBData();
  }

  Future syncGeneralPhotos() async {
    await getDBData();
    List<GeneralPhoto> unsyncedPhotos = generalPhotos
        .where((GeneralPhoto generalPhoto) => generalPhoto.synced == false)
        .toList();
    for (GeneralPhoto generalPhoto in unsyncedPhotos) {
      if (routePlansManager
          .getCustomerById(int.parse("${generalPhoto.shopId}"))
          .synced) {
        try {
          var response = await api.saveGeneralPhoto({
            "rep_id": authManager.user.id,
            "shop_id": routePlansManager
                .getCustomerById(int.parse("${generalPhoto.shopId}"))
                ?.shopId,
            'image_notes': generalPhoto.imageNotes,
            "product_category": generalPhoto.productCategory,
            "brand_name": generalPhoto.brandName,
            "image_category": generalPhoto.imageCategory,
            "activity_id": generalPhoto.activityId,
            "product_category": generalPhoto.productCategory,
            "latitude": generalPhoto.latitude,
            "longitude": generalPhoto.longitude,
            "image_time": formatDate(generalPhoto.imageTime?.toString(), "xt"),
            "image_photo": (generalPhoto.imagePhoto != null &&
                    generalPhoto.imagePhoto.trim() != "")
                ? await base64FromFile(File(generalPhoto.imagePhoto))
                : null,
          });

          if (response.data["status"] == 1) {
            _onGeneralPhotoSyncResponse(response.data, generalPhoto);
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

  _onGeneralPhotoSyncResponse(data, GeneralPhoto generalPhoto) {
    db.generalPhotoBean.update(generalPhoto..synced = true);
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

var generalPhotosManager = GeneralPhotosManager();
