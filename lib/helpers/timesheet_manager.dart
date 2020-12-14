import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/session.dart';
import 'package:solutech_sat/data/models/timesheet.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/tools/manager.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class TimesheetManager extends Manager {
  static TimesheetManager instance;
  factory TimesheetManager() => instance ??= TimesheetManager._instance();
  TimesheetManager._instance();
  List<Timesheet> timesheets = [];
  bool _loadingTimesheets = false;

  Future getDBData() async {
    timesheets = await db.timesheetBean.getAll();
    notifyChanges();
  }

  bool get loadingTimesheets => _loadingTimesheets;

  set loadingTimesheets(bool show) {
    _loadingTimesheets = show;
    notifyChanges();
  }

  Future saveTimesheet(Timesheet timesheet) async {
    await db.timesheetBean.upsert(timesheet);
    await getDBData();
  }

  Future loadTimesheets([List<DateTime> pickedDates]) async {
    loadingTimesheets = true;
    var filterDates = filterDatesFrom(pickedDates);
    return api.getTimesheets(filterDates).then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveTimesheetsLocally(payload);
        loadingTimesheets = false;
        return response;
      } else {
        loadingTimesheets = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future _saveTimesheetsLocally(payload) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    await db.timesheetBean.removeAll();
    if (!await sessionManager.shouldSync) {
      await db.sessionBean.removeAll();
    }
    for (var item in payload) {
      Timesheet timesheet = Timesheet.fromMap(item);
      final recordDate = DateTime(
        timesheet.checkinTime.year,
        timesheet.checkinTime.month,
        timesheet.checkinTime.day,
      );
      if (recordDate == today) {
        await db.sessionBean.upsert(Session(
          photo: timesheet.checkinPhoto,
          syncedStart: timesheet.checkinTime != null,
          syncedEnd: timesheet.checkoutTime != null,
          latitude: double.parse("${timesheet.checkinLatitude ?? 0}"),
          longitude: double.parse("${timesheet.checkinLongitude ?? 0}"),
          startTime: timesheet.checkinTime,
          endTime: timesheet.checkoutTime,
          fromServer: true,
          sessionId: "${timesheet.visitid ?? timesheet.timesheetId}",
          customerId: timesheet.branchId,
        ));
      } else {
        await db.timesheetBean.insert(timesheet);
      }
    }
    print("Saved timesheet");
    await sessionManager.getDBData();
    await getDBData();
  }

  @override
  Future init() async {
    super.init();
    await getDBData();
  }
}

var timesheetManager = TimesheetManager();
