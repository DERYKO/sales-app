import 'dart:async';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:solutech_sat/tools/manager.dart';

class PermissionManager extends Manager {
  static PermissionManager instance;
  factory PermissionManager() => instance ??= PermissionManager._instance();
  PermissionManager._instance();

  List<PermissionGroup> permissionGroups = [
    PermissionGroup.phone,
    PermissionGroup.camera,
    PermissionGroup.storage,
    PermissionGroup.location,
  ];
  void checkPermissions([bool askForPermissions = false]) async {
    var toRemove = [];
    for (PermissionGroup permissionGroup in permissionGroups) {
      PermissionStatus permissionStatus =
          await PermissionHandler().checkPermissionStatus(permissionGroup);
      print("Permission Granting status: $permissionStatus");
      if (isIgnored(permissionStatus)) {
        toRemove.add(permissionGroup);
      }
    }
    permissionGroups.removeWhere((e) => toRemove.contains(e));
    print("PERMISSIONS_AFTER_REM: ${permissionGroups.length}");
    notifyChanges(); //Sync changes
    // Request permissions not granted
    if (askForPermissions && permissionGroups.length > 0) {
      try {
        grantPermissions();
      } catch (e) {
        if (e is PlatformException) {
          if (e.message
              .contains("A request for permissions is already running")) {
            checkPermissions(true);
          }
        }
      }
    }
  }

  bool isIgnored(permissionStatus) {
    return permissionStatus == PermissionStatus.granted ||
        permissionStatus == PermissionStatus.restricted ||
        permissionStatus == PermissionStatus.disabled;
  }

  bool shouldAskPermissions() {
    return permissionGroups.length > 0 ? true : false;
  }

  void grantPermissions() async {
    print("Permissions length: ${permissionGroups.length}");
    if (permissionGroups.length > 0) {
      try {
        PermissionHandler().requestPermissions(permissionGroups);
      } on PlatformException catch (e) {
        print("PERM_ERROR ${e.message}");
      }
    }
    await Future.delayed(Duration(milliseconds: 500));
    checkPermissions(true);
  }

  @override
  destroy() {
    super.destroy();
  }
}

var permissionManager = PermissionManager();
