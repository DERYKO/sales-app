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
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/customer_group_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/manager.dart';
import 'package:solutech_sat/utils/device_utils.dart';
import 'package:solutech_sat/utils/format_utils.dart';
import 'package:solutech_sat/utils/image_utils.dart';

class PriceListsManager extends Manager {
  static PriceListsManager instance;
  factory PriceListsManager() => instance ??= PriceListsManager._instance();
  PriceListsManager._instance();
  List<PriceList> priceLists = [];
  bool _loadingPriceList = false;

  Future getDBData() async {
    priceLists = await db.priceListBean.getAll();
    notifyChanges();
  }

  bool get loadingPriceList => _loadingPriceList;

  set loadingPriceList(bool show) {
    _loadingPriceList = show;
    notifyChanges();
  }

  List<PriceList> get uniquePriceLists {
    List<PriceList> uniquePriceLists = [];
    List<int> priceListIds = [];
    priceLists.forEach((priceList) {
      if (!priceListIds.contains(priceList.pricelistId)) {
        uniquePriceLists.add(priceList);
        priceListIds.add(priceList.pricelistId);
      }
    });
    return uniquePriceLists;
  }

  List<PriceList> getPriceListOfAssignedProducts(pricelist) {
    return priceListsManager.priceLists
        .where((priceList) =>
            priceList.pricelistId == pricelist?.pricelistId &&
            commonsManager.products
                .map((product) => product.productId)
                .toList()
                .contains(priceList.productId))
        .toList();
  }

  PriceList priceListForCustomer(int customerId, int productId) {
    var customer = routePlansManager.getCustomerById(customerId);
    if (customer?.groupId == null) return null;
    var group = customerGroupsManager.customerGroupById(customer.groupId);
    return priceLists.firstWhere(
        (priceList) =>
            priceList?.pricelistId == group?.pricelistId &&
            priceList.productId == productId,
        orElse: () => null);
  }

  Future loadPriceLists() async {
    loadingPriceList = true;
    return api.getPriceLists().then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _savePriceListsLocally(payload);
        loadingPriceList = false;
        return response;
      } else {
        loadingPriceList = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future _savePriceListsLocally(payload) async {
    List<PriceList> priceLists = [];
    await db.priceListBean.removeAll();
    for (var item in payload) {
      await db.priceListBean.insert(PriceList.fromMap(item));
    }
    await getDBData();
  }

  @override
  Future init() async {
    super.init();
    await getDBData();
  }
}

var priceListsManager = PriceListsManager();
