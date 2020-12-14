import 'package:flutter/material.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/skip_record.dart';
import 'package:solutech_sat/data/models/status_update.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/screen/recent_activity_screen.dart';
import 'package:solutech_sat/utils/device_utils.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class SkipCustomerBloc extends Bloc {
  Customer customer;
  SkipCustomerBloc(this.customer);
  AppData skipReason;
  DateTime pickedDate;
  TextEditingController nextVisitDateCtrl = TextEditingController();
  TextEditingController notesCtrl = TextEditingController();

  void onSkipReasonChanged(value) {
    skipReason = value;
    notifyChanges();
  }

  void pickDate() async {
    pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(hours: 2)),
      lastDate: DateTime.now().add(
        Duration(days: 50),
      ),
    );
    if (pickedDate != null) {
      nextVisitDateCtrl.text = "${formatDate(pickedDate, "MMM d, yyyy")}";
    }
  }

  bool validFields() {
    if (skipReason == null) {
      alert("Select skip reason",
          "You have to select the reason why you are skipping this customer.");
      return false;
    }

    if (nextVisitDateCtrl.text == "") {
      alert("Select next visit date", "You have to select the next visit date");
      return false;
    }
    return true;
  }

  void onSave() async {
    if (validFields()) {
      if (!await confirm("Save skip?",
          "This will save the skip record and check you out of this customer."))
        return;
      var currentLocation = await locationManager.currentLocation();
      var batteryLevel = await battery.batteryLevel;
      var shouldShowRecent =
          recordsManager.skipByShopId(int.parse("${customer.id}")).length == 0;
      await recordsManager.saveSkip(
        SkipRecord(
          shopId: customer.id,
          salerId: authManager.user.id,
          routeId: "${customer.routeId}",
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude,
          orderTime: DateTime.now().toIso8601String(),
          newShop: 0,
          skipReason: skipReason.data,
          skipNotes: notesCtrl.text,
          nextVisitDate: pickedDate,
          callStatus: "visited",
          routeType: "ON",
          battery: "$batteryLevel",
        ),
      );
      alert("Skip saved", "Your skip record has been saved.", onOk: () {
        sessionManager.endSession();
        if (shouldShowRecent) {
          popAndNavigate(
            screen: RecentActivityScreen(
              customer: customer,
              routePlan: null,
              mode: "Skip",
            ),
          );
        } else {
          pop();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }
}
