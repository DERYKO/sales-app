import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/availability.dart';
import 'package:solutech_sat/data/models/availability_item.dart';
import 'package:solutech_sat/data/models/brand.dart';
import 'package:solutech_sat/data/models/inventory.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/role.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/virtual_stock.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/availability_manager.dart';
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

class BrandAuditBloc extends Bloc {
  Customer customer;
  Brand brand;
  int currentScreen = 0;
  var brandsAudit = [];
  BrandAuditBloc({@required this.customer}) : assert(customer != null);

  void onBrandChanged(Brand value) {
    brand = value;
    notifyChanges();
  }

  void saveAudit() async {
    if (brandsAudit.length > 0) {
      bool shouldShowRecent = !availabilityManager.hasTodaysRecord(customer.id);
      bool accept = await confirm(
          "Save Audit?", "This will save the availability audit.");
      if (accept) {
        List<AvailabilityItem> availabilityItems = brandsAudit
            .map(
              (brand) => AvailabilityItem(
                productName: brand["product_name"],
                productId: brand["product_id"],
                availabilityReason: null,
                availabilityStatus: brand["status"],
              ),
            )
            .toList();
        await availabilityManager.saveAvailability(
          availability: Availability(
            shopName: customer.shopName,
            shopId: "${customer.id}",
            entryTime: DateTime.now(),
          ),
          availabilityItems: availabilityItems,
        );

        alert("Saved audit", "The audit was saved successfuly", onOk: () {
          if (shouldShowRecent) {
            popAndNavigate(
              screen: RecentActivityScreen(
                customer: customer,
                mode: "Brand",
              ),
            );
          } else {
            pop();
          }
        });
      }
    } else {
      alert("No brands audited", "Audit at least one brand to continue.");
    }
  }

  void onSaveAuditResponse(response) {
    if (response.data["status"] == 1) {
      alert("Success", "${response.data["message"]}", onOk: () {
        pop();
      });
    } else {
      alert("Failed", "Failed to save the audit. Please try again.");
    }
  }

  void prevScreen(pos) {
    currentScreen = pos;
    notifyChanges();
  }

  void nextScreen(pos) {
    currentScreen = pos;
    notifyChanges();
  }

  void errorHandler(error) {
    showToast("Something went wrong");
    debugPrint("An error $error");
    if (error is DioError) {
      debugPrint(error.response.data);
    }
  }

  hasAudit(brandName) {
    return brandsAudit
            .where((audit) => audit["product_name"] == brandName)
            .toList()
            .length >
        0;
  }

  setAuditValue(brandName, {value = ""}) {
    var index = getAuditIndex(brandName);
    if (index != -1) {
      print("Updating");
      print("$brandsAudit");
      brandsAudit[index]["status"] = value;
      notifyChanges();
    } else {
      print("Adding");
      brandsAudit.add({
        "product_id": 0,
        "product_name": brandName,
        "status": value,
      });
      notifyChanges();
    }
  }

  getAuditIndex(brandName) {
    return brandsAudit
        .indexWhere((audit) => audit["product_name"] == brandName);
  }

  getAuditValue(
    brandName,
  ) {
    if (hasAudit(brandName)) {
      var auditValue = brandsAudit
          .where((audit) => audit["product_name"] == brandName)
          .toList()
          .first["status"];
      return auditValue;
    } else {
      return null;
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
