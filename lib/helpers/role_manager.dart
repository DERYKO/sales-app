import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/module_name.dart';
import 'package:solutech_sat/data/models/role.dart';
import 'package:solutech_sat/tools/manager.dart';

class RoleManager extends Manager {
  static RoleManager instance;
  factory RoleManager() => instance ??= RoleManager._instance();
  RoleManager._instance();
  List<Role> roles = [];
  List<ModuleName> moduleNames = [];

  Future getDBData() async {
    roles = await db.roleBean.getAll();
    moduleNames = await db.moduleNameBean.getAll();
    notifyChanges();
  }

  bool hasRole(String key) {
    if (roles == null || roles.length == 0) {
      debugPrint("Role $key not found: $roles");
      return false;
    }
    var userRole =
        roles.firstWhere((Role role) => role.key == key, orElse: () => null);
    if (userRole == null) return false;
    return (userRole.status == "checked") ? true : false;
  }

  bool hasModuleName(String key) {
    if (moduleNames == null || moduleNames.length == 0) {
      debugPrint("Module $key not found: $moduleNames");
      return false;
    }
    var userModuleName = moduleNames
        .firstWhere((ModuleName role) => role.key == key, orElse: () => null);
    if (userModuleName == null) return false;
    debugPrint("ModuleName: ${userModuleName.key}");
    return (userModuleName != null) ? true : false;
  }

  String resolveTitle(
      {@required String title, @required module, capitalize: false}) {
    var moduleTitle = hasModuleName(module)
        ? moduleNames
            .firstWhere((ModuleName role) => role.key == module)
            .moduleName
        : title;
    return capitalize ? moduleTitle?.toUpperCase() : moduleTitle;
  }

  Future getRoles() {
    return api.getRoles().then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveRolesLocally(payload);
        return response;
      } else {
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future loadModuleNames() {
    return api.getModuleNames().then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveModuleNamesLocally(payload);
        return response;
      } else {
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future _saveRolesLocally(payload) async {
    await db.roleBean.removeAll();
    for (var item in payload) {
      await db.roleBean.insert(Role.fromMap(item));
    }
    print("Roles saved");
    getDBData();
  }

  Future _saveModuleNamesLocally(payload) async {
    await db.moduleNameBean.removeAll();
    for (var item in payload) {
      await db.moduleNameBean.insert(ModuleName.fromMap(item));
    }
    await getDBData();
  }

  @override
  Future init() async {
    super.init();
    await getDBData();
  }
}

class Roles {
  static const SALES = "sales";
  static const CHECK_IN = "checkin";
  static const ALLOW_MULTIPLE_CHECKIN = "multiplecheckins";
  static const INVENTORY = "inventory";
  static const RETURNS = "returns";
  static const QR_CODE = "qrcode";
  static const INITIATIVES = "initiatives";
  static const EXPIRIES = "expiries";
  static const COMPETITOR_SOS = "competitorsos";
  static const ALLOW_CARTONS = "cratesoption";
  static const STATUS_UPDATE = "statusupdate";
  static const FEEDBACK = "feedback";
  static const SURVEY = "survey";
  static const BANKING = "banking";
  static const ALLOW_UPLIFTS = "allowuplifts";
  static const ALLOW_GALLERY = "allowgallery";
  static const ENFORCE_VALIDATION = "enforcevalidation";
  static const USE_VIRTUAL_INVENTORY = "usevirtualinventory";
  static const VIRTUAL_WITH_STOCKPOINT = "virtualwithstockpoint";
  static const GEOFENCE = "geofence";
  static const PAYMENTS = "payments";
  static const ORDERS = "orders";
  static const AVAILABILITY = "availability";
  static const MANDATORY_ON_SHELF = "mandatoryonshelf";
  static const MANDATORY_AVAILABILITY = "mandatoryavailability";
  static const MANDATORY_POSM = "mandatoryposm";
  static const MANDATORY_BRANDAUDIT = "mandatorybrandaudit";
  static const SHELF_SHARE = "shelfshare";
  static const SHARE_OF_DISPLAY = "shareofdisplay";
  static const DISABLE_INVENTORY = "disableinventory";
  static const DISABLE_ADDING_CUSTOMERS = "disableaddingcustomers";
  static const DAMAGES = "damages";
  static const IMAGES = "images";
  static const COMPETITOR = "competitor";
  static const CRATES = "crates";
  static const USE_LENGTH_SOS = "uselengthsos";
  static const USE_FACINGS_SOS = "usefacingssos";
  static const POSM_AUDIT = "posmaudit";
  static const STOCK_TAKING = "stocktaking";
  static const BRAND_AVAILABILITY = "brandavailability";
  static const DELIVERY = "delivery";
  static const USE_DEFAULT_PRICE_LIST = "usedefaultpricelist";
  static const DISABLE_CHANGING_SELLING_PRICE = "disablechangingsellingprice";
  static const DISABLE_CHANGING_BUYING_PRICE = "disablechangingbuyingprice";
  static const ALLOW_OFF_ROUTE = "offroute";
  static const ALLOW_PRINTING = "printer";
  static const REQUISITION_STOCK = "requisitionstock";
  static const USE_ODOMETER = "useodometer";
}

var roleManager = RoleManager();
