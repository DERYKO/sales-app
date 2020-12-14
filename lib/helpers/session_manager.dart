import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/session.dart';
import 'package:solutech_sat/data/models/timesheet.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/helpers/timesheet_manager.dart';
import 'package:solutech_sat/tools/manager.dart';
import 'package:hive/hive.dart';
import 'package:solutech_sat/utils/device_utils.dart';
import 'package:solutech_sat/utils/format_utils.dart';
import 'package:solutech_sat/utils/image_utils.dart';
import 'package:uuid/uuid.dart';

class SessionManager extends Manager {
  static SessionManager instance;
  factory SessionManager() => instance ??= SessionManager._instance();
  SessionManager._instance();
  bool referred = false;
  List<Session> sessions = [];
  Timer _timer;

  Future<bool> get shouldSync async {
    List<bool> completedSyncs = [
      ...(await db.sessionBean.getAll())
          .map<bool>((session) => session.syncedStart)
          .toList(),
      ...(await db.sessionBean.getAll())
          .map<bool>((session) =>
              ((!session.syncedEnd && session.endTime == null) ||
                  session.syncedEnd))
          .toList(),
    ];
    return completedSyncs.contains(false) && !syncManager.syncing;
  }

  String get timeIn {
    if (session != null) {
      var difference = DateTime.now().difference(session.startTime);
      return "${difference.inHours.toString().padLeft(2, "0")}hrs ${(difference.inMinutes % 60).toString().padLeft(2, "0")}min ${(difference.inSeconds % 60).toString().padLeft(2, "0")}sec";
    } else {
      return "";
    }
  }

  bool get inSession {
    return session != null;
  }

  Session get session {
    return sessions.firstWhere((session) => session.endTime == null,
        orElse: () => null);
  }

  set session(Session session) {
    db.sessionBean.insert(session).then((done) {
      getDBData().then((done) {
        syncManager.sync();
      });
    });
  }

  startSession(int customerId, [File image]) async {
    Position currentLocation = await locationManager.currentLocation();
    var startTime = DateTime.now();
    var sessionId = Uuid().v4();

    session = Session(
      customerId: customerId,
      sessionId: sessionId,
      startTime: startTime,
      photo: image?.path ?? null,
      longitude: currentLocation.longitude,
      latitude: currentLocation.latitude,
      batteryLevel: await battery.batteryLevel,
      syncedStart: false,
      syncedEnd: false,
    );

    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      notifyChanges();
    });
  }

  endSession() async {
    _timer?.cancel();
    var endTime = DateTime.now();
    db.sessionBean.update(session..endTime = endTime).then((done) {
      getDBData().then((done) {
        syncManager.sync();
      });
    });
    notifyChanges();
  }

  resumeSession() {
    // Start updating session manager periodically for the time to update
    if (_timer == null && inSession) {
      _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        //print("Session ${session?.customerId}");
        notifyChanges();
      });
    }
  }

  syncStartSessions() async {
    List<Session> unsyncedStartSessions = (await db.sessionBean.getAll())
        .where((Session session) => session.syncedStart != true)
        .toList();
    for (Session session in unsyncedStartSessions) {
      if (routePlansManager.getCustomerById(session.customerId)?.synced ??
          false) {
        print("SESSION ${session.toMap()}");
        try {
          var response = await api.saveVisitSession({
            "sessiontype": "start",
            "visitid": session.sessionId,
            'shop_id':
                routePlansManager.getCustomerById(session.customerId).shopId,
            "saler_id": authManager.user.id,
            "longitude": session.longitude,
            "Battery": session.batteryLevel,
            "latitude": session.latitude,
            "entry_time": formatDate(session.startTime?.toString(), "xt"),
            "checkin_photo":
                (session.photo != null && session.photo.trim() != "")
                    ? await base64FromFile(File(session.photo))
                    : null,
          });

          if (response.data["status"] == 1) {
            _onSessionStartSyncResponse(session);
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

  syncEndSessions() async {
    List<Session> unsyncedEndSessions = (await db.sessionBean.getAll())
        .where((Session session) =>
            session.endTime != null && session.syncedEnd != true)
        .toList();
    for (Session session in unsyncedEndSessions) {
      if (routePlansManager.getCustomerById(session.customerId)?.synced ??
          false) {
        try {
          var response = await api.saveVisitSession({
            "sessiontype": "end",
            "visitid": session.sessionId,
            'shop_id':
                routePlansManager.getCustomerById(session.customerId).shopId,
            "saler_id": authManager.user.id,
            "longitude": session.longitude,
            "Battery": session.batteryLevel,
            "latitude": session.latitude,
            "entry_time": formatDate(session.endTime?.toString(), "xt"),
          });

          if (response.data["status"] == 1) {
            _onSessionEndSyncResponse(session);
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

  _onSessionStartSyncResponse(Session session) async {
    await db.sessionBean.update(session..syncedStart = true);
    await getDBData();
  }

  _onSessionEndSyncResponse(Session session) async {
    await db.sessionBean.update(session
      ..syncedStart = true
      ..syncedEnd = true);
    await getDBData();
  }

  _onSyncError(error) {
    print("Error $error");
  }

  Future getDBData() async {
    sessions = await db.sessionBean.getAll();
    print("SESSIONS ${sessions.length}");
  }

  @override
  Future init() async {
    await getDBData();
  }
}

var sessionManager = SessionManager();
