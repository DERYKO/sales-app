import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/brand.dart';
import 'package:solutech_sat/data/models/inventory.dart';
import 'package:solutech_sat/data/models/posm.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/role.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/virtual_stock.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/brands_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/permission_manager.dart';
import 'package:solutech_sat/helpers/posm_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/screen/add_stock_screen.dart';
import 'package:solutech_sat/ui/screen/recent_activity_screen.dart';
import 'package:solutech_sat/ui/screen/search_screen.dart';

class PosmAuditBloc extends Bloc {
  Customer customer;
  Brand brand;
  var posmAudits = [];
  PosmAuditBloc({@required this.customer}) : assert(customer != null);

  void onBrandChanged(Brand value) {
    brand = value;
    notifyChanges();
  }

  getAuditIndex(itemId) {
    return posmAudits.indexWhere((audit) => audit["item_id"] == itemId);
  }

  hasAudit(itemId) {
    return posmAudits
            .where((audit) => audit["item_id"] == itemId)
            .toList()
            .length >
        0;
  }

  getAuditValue(itemId, [audit = "availability"]) {
    if (hasAudit(itemId)) {
      var auditValue = posmAudits
          .where((audit) => audit["item_id"] == itemId)
          .toList()
          .first[audit];
      return auditValue;
    } else {
      return null;
    }
  }

  void savePosmAudit() async {
    if (posmAudits.length > 0) {
      bool shouldShowRecent = !posmManager.hasTodaysRecord(customer.id);
      var save = await confirm("Save audit?",
          "This will save the audit directly and cannot be reversed.");
      if (save) {
        var currentLocation = await locationManager.currentLocation();

        for (var item in posmAudits) {
          await posmManager.savePosmAudit(
            Posm(
              shopName: customer.shopName,
              shopId: customer.id,
              itemId: item["item_id"],
              itemname: posmManager.posmMaterialById(item["item_id"]).itemname,
              name: authManager.user.name?.toUpperCase(),
              longitude: currentLocation.longitude,
              latitude: currentLocation.latitude,
              availability: item["availability"],
              stocked: item["stocked"],
              visibility: item["visibility"],
              entryTime: DateTime.now(),
              productName: brand.brand,
              notes: "",
            ),
          );
        }
        alert("Saved", "Posm audit saved successfuly", onOk: () {
          if (shouldShowRecent) {
            popAndNavigate(
              screen: RecentActivityScreen(
                customer: customer,
                mode: "Posm",
              ),
            );
          } else {
            pop();
          }
        });
      }
    } else {
      alert(
        "No POSM audited",
        "Audit all POSM to continue.",
      );
    }
  }

  void errorHandler(error) {
    showToast("Something went wrong");
    debugPrint("An error $error");
    if (error is DioError) {
      debugPrint(error.response.data);
    }
  }

  setAuditValue(
    itemId, {
    String audit = "availability",
    value = "",
    String itemtype = "",
  }) {
    var index = getAuditIndex(itemId);

    if (index != -1) {
      print("Updating");
      posmAudits[index][audit] = value;
      notifyChanges();
    } else {
      print("Adding");
      posmAudits.add({"item_id": itemId, audit: value, "itemtype": itemtype});
      notifyChanges();
    }
  }

  void selectBrand() async {
    var brand = await navigate(
        screen: SearchScreen(
            title: "Select brand",
            items: brandsManager.brands,
            onFilter: (Brand item, searchTerm) {
              return item.brand
                  .toString()
                  .trim()
                  .toLowerCase()
                  .contains(searchTerm);
            },
            builder: (Brand brand, index) {
              return Container(
                color: ((index + 1) % 2 == 0) ? Colors.white : Colors.grey[200],
                padding: EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("${brand.brand}"),
                    )
                  ],
                ),
              );
            }));
    if (brand != null) {
      onBrandChanged(brand);
    }
  }

  @override
  void initState() {
    super.initState();
  }
}
