import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/availability.dart';
import 'package:solutech_sat/data/models/customer_group.dart';
import 'package:solutech_sat/data/models/delivery.dart';
import 'package:solutech_sat/data/models/delivery_order_detail.dart';
import 'package:solutech_sat/data/models/posm.dart';
import 'package:solutech_sat/data/models/posm_material.dart';
import 'package:solutech_sat/data/models/price_list.dart';
import 'package:solutech_sat/data/models/scheduled_delivery.dart';
import 'package:solutech_sat/data/models/session.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/manager.dart';
import 'package:solutech_sat/utils/device_utils.dart';
import 'package:solutech_sat/utils/format_utils.dart';
import 'package:solutech_sat/utils/image_utils.dart';

class CustomerGroupsManager extends Manager {
  static CustomerGroupsManager instance;
  factory CustomerGroupsManager() =>
      instance ??= CustomerGroupsManager._instance();
  CustomerGroupsManager._instance();
  List<CustomerGroup> customerGroups = [];
  bool _loadingCustomerGroup = false;

  Future getDBData() async {
    customerGroups = await db.customerGroupBean.getAll();
    notifyChanges();
  }

  bool get loadingCustomerGroup => _loadingCustomerGroup;

  set loadingCustomerGroup(bool show) {
    _loadingCustomerGroup = show;
    notifyChanges();
  }

  CustomerGroup customerGroupById(int groupId) {
    return customerGroups.firstWhere(
        (customerGroup) => customerGroup.id == groupId,
        orElse: () => null);
  }

  Future loadCustomerGroups() async {
    loadingCustomerGroup = true;
    return api.getCustomerGroups().then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveCustomerGroupsLocally(payload);
        loadingCustomerGroup = false;
        return response;
      } else {
        loadingCustomerGroup = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future _saveCustomerGroupsLocally(payload) async {
    await db.customerGroupBean.removeAll();
    for (var item in payload) {
      await db.customerGroupBean.insert(CustomerGroup.fromMap(item));
    }
    print("Customer groups saved locally");
    await getDBData();
  }

  @override
  Future init() async {
    super.init();
    await getDBData();
  }
}

var customerGroupsManager = CustomerGroupsManager();
