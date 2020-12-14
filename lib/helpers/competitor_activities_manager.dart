import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/manager.dart';
import 'package:solutech_sat/utils/format_utils.dart';
import 'package:solutech_sat/utils/image_utils.dart';

import 'package:solutech_sat/data/models/competitor_activity.dart';

class CompetitorActivitiesManager extends Manager {
  static CompetitorActivitiesManager instance;
  factory CompetitorActivitiesManager() =>
      instance ??= CompetitorActivitiesManager._instance();
  CompetitorActivitiesManager._instance();
  List<CompetitorActivity> competitorActivities = [];
  bool _loadingCompetitorActivities = false;

  Future getDBData() async {
    competitorActivities = await db.competitorActivityBean.getAll();
    notifyChanges();
  }

  bool get loadingCompetitorActivities => _loadingCompetitorActivities;

  set loadingCompetitorActivities(bool show) {
    _loadingCompetitorActivities = show;
    notifyChanges();
  }

  Future saveCompetitorActivity(CompetitorActivity competitorActivity) async {
    await db.competitorActivityBean.insert(competitorActivity);
    await getDBData();
    syncManager.sync();
  }

  Future loadCompetitorActivities([List<DateTime> pickedDates]) async {
    loadingCompetitorActivities = true;
    var filterDates = filterDatesFrom(pickedDates);
    return api.getCompetitorActivities(filterDates).then((response) async {
      if (response.data["status"] == 1 || response.data["status"] == 0) {
        var payload = response.data["payload"];
        await _saveCompetitorActivitiesLocally(payload);
        loadingCompetitorActivities = false;
        return response;
      } else {
        loadingCompetitorActivities = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  bool hasTodaysRecord(int customerId, String updateType) {
    var now = DateTime.now();
    return competitorActivities
            .where((CompetitorActivity competitorActivity) =>
                int.parse("${competitorActivity.shopId ?? 0}") == customerId &&
                DateTime(
                        competitorActivity.entryTime.year,
                        competitorActivity.entryTime.month,
                        competitorActivity.entryTime.day) ==
                    DateTime(now.year, now.month, now.day))
            .toList()
            .length >
        0;
  }

  Future _saveCompetitorActivitiesLocally(payload) async {
    await db.competitorActivityBean.removeAll();
    for (var item in payload) {
      await db.competitorActivityBean.insert(CompetitorActivity.fromMap(item)
        ..synced = true
        ..fromServer = true);
    }
    print("Competitor activities saved");
    await getDBData();
  }

  Future syncCompetitorActivities() async {
    await getDBData();
    List<CompetitorActivity> unsyncedCompetitorActivities = competitorActivities
        .where((CompetitorActivity competitorActivity) =>
            competitorActivity.synced == false)
        .toList();
    for (CompetitorActivity competitorActivity
        in unsyncedCompetitorActivities) {
      if (routePlansManager
          .getCustomerById(int.parse("${competitorActivity.shopId}"))
          .synced) {
        try {
          var currentLocation = await locationManager.currentLocation();

          var response = await api.saveCompetitorActivity({
            "rep_id": authManager.user.id,
            "shop_id": routePlansManager
                .getCustomerById(int.parse("${competitorActivity.shopId}"))
                ?.shopId,
            'competitor': competitorActivity.competitor,
            "product_name": competitorActivity.productName,
            "product_sku": competitorActivity.productSku,
            "mechanism": competitorActivity.mechanism,
            'notes': competitorActivity.notes,
            'before_value': competitorActivity.beforeValue,
            "company_id": competitorActivity.companyId,
            'after_value': competitorActivity.afterValue,
            "csku": competitorActivity.csku,
            "record_time":
                formatDate(competitorActivity.entryTime?.toString(), "xt"),
            "longitude": "${currentLocation.longitude}",
            "visitid": competitorActivity.visitId,
            "latitude": "${currentLocation.latitude}",
            'photo': (competitorActivity.photo != null &&
                    competitorActivity.photo.trim() != "")
                ? await base64FromFile(File(competitorActivity.photo))
                : null,
          });

          if (response.data["status"] == 1) {
            _onCompetitorActivitySyncResponse(
                response.data, competitorActivity);
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

  _onCompetitorActivitySyncResponse(
      data, CompetitorActivity competitorActivity) {
    db.competitorActivityBean.update(competitorActivity..synced = true);
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

var competitorActivitiesManager = CompetitorActivitiesManager();
