import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/data/models/brand.dart';
import 'package:solutech_sat/data/models/product_availability.dart';
import 'package:solutech_sat/data/models/product_availability_detail.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/product_availability_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/screen/search_screen.dart';

class AuditOSABloc extends Bloc {
  Customer customer;
  int currentScreen = 0;
  var productsAudit = [];
  AuditOSABloc({
    @required this.customer,
  }) : assert(customer != null);

  void saveAudit() async {
    if (roleManager
        .hasRole(Roles.MANDATORY_AVAILABILITY)) if (productsAudit.length > 0) {
      // bool shouldShowRecent = !availabilityManager.hasTodaysRecord(customer.id);
      var currentLocation = await locationManager.currentLocation();
      bool accept = await confirm(
          "Save Audit?", "This will save the availability audit.");

      if (accept) {
        List<ProductAvailabilityDetail> availabilityDetails = productsAudit
            .map(
              (audit) => ProductAvailabilityDetail(
                  productName: audit["product_name"],
                  productId: audit["product_id"],
                  reason: audit["reason"],
                  notes: audit["notes"],
                  availabilityStatus: audit["status"],
                  quantity: "${audit["quantity"]}"),
            )
            .toList();
        await productAvailabilityManager.saveAvailability(
          availability: ProductAvailability(
            latitude: "${currentLocation.latitude ?? 0}",
            longitude: "${currentLocation.longitude ?? 0}",
            repId: authManager.user.id,
            outletId: customer.id,
            visitid: sessionManager.session.sessionId,
            entryTime: DateTime.now(),
          ),
          availabilityItems: availabilityDetails,
        );

        alert("Saved audit", "The audit was saved successfuly", onOk: () {
          /*if (shouldShowRecent) {
            popAndNavigate(
              screen: RecentActivityScreen(
                customer: customer,
                mode: "Brand",
              ),
            );
          } else {*/
          pop();
          //}
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
    return productsAudit
            .where((audit) => audit["product_name"] == brandName)
            .toList()
            .length >
        0;
  }

  setAuditValue(productName,
      {value = "",
      int productId = 0,
      String reason,
      String notes,
      int quantity}) {
    var index = getAuditIndex(productName);
    if (index != -1) {
      print("Updating");
      print("$productsAudit");
      productsAudit[index]["status"] = value;
      productsAudit[index]["notes"] = notes;
      productsAudit[index]["reason"] = reason;
      productsAudit[index]["quantity"] = quantity;
      notifyChanges();
    } else {
      print("Adding");
      productsAudit.add({
        "product_id": productId,
        "product_name": productName,
        "status": value,
        "notes": notes,
        "reason": reason,
        "quantity": quantity
      });
      notifyChanges();
    }
  }

  getAuditIndex(brandName) {
    return productsAudit
        .indexWhere((audit) => audit["product_name"] == brandName);
  }

  getAuditValue(
    brandName,
  ) {
    if (hasAudit(brandName)) {
      var auditValue = productsAudit
          .where((audit) => audit["product_name"] == brandName)
          .toList()
          .first["status"];
      return auditValue;
    } else {
      return null;
    }
  }

  getAuditQuantity(
    brandName,
  ) {
    if (hasAudit(brandName)) {
      var quantity = productsAudit
          .where((audit) => audit["product_name"] == brandName)
          .toList()
          .first["quantity"];
      return quantity;
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
  }
}
