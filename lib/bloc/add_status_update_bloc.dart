import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/shop_category.dart';
import 'package:solutech_sat/data/models/status_update.dart';
import 'package:solutech_sat/data/models/stock.dart';
import 'package:solutech_sat/data/models/stock_item.dart';
import 'package:solutech_sat/data/models/stockpoint.dart';
import 'package:solutech_sat/data/models/user_location.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solutech_sat/ui/screen/inventory_screen.dart';
import 'package:solutech_sat/ui/screen/search_screen.dart';
import 'package:solutech_sat/utils/format_utils.dart';
import 'package:solutech_sat/utils/image_utils.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class AddStatusUpdateBloc extends Bloc {
  String mode = "status";
  TextEditingController notesCtrl = TextEditingController();
  List<DateTime> pickedDates = [
    DateTime.now(),
    DateTime.now(),
  ];
  TextEditingController leavePeriodCtrl = TextEditingController();
  UserLocation location;
  File image;
  AppData statusCategory;

  void selectUserLocation() async {
    var location = await navigate(
      screen: SearchScreen(
        title: "Select location",
        items: locationManager.userLocations,
        onFilter: (UserLocation location, searchTerm) {
          return location.locationName
              .toString()
              .trim()
              .toLowerCase()
              .contains(searchTerm);
        },
        builder: (UserLocation location, index) {
          return Container(
            color: ((index + 1) % 2 == 0) ? Colors.white : Colors.grey[200],
            padding: EdgeInsets.all(20.0),
            child: Text("${location.locationName}"),
          );
        },
      ),
    );
    if (location != null) {
      onLocationChanged(location);
    }
  }

  void onModeChange(mode) {
    this.mode = mode;
    notifyChanges();
  }

  void takePhoto() async {
    var pickedImage = await ImagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = await compressImageFile(pickedImage);
      notifyChanges();
    }
  }

  void onLocationChanged(location) {
    this.location = location;
    notifyChanges();
  }

  void onAppDataChanged(location) {
    this.statusCategory = location;
    notifyChanges();
  }

  void filterByDate() async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: pickedDates.first,
      initialLastDate: pickedDates.last,
      firstDate: DateTime.now().subtract(Duration(days: 20)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked.length > 0) {
      pickedDates = picked;

      leavePeriodCtrl.text =
          "${formatDate(pickedDates.first, "MMM d, yyyy")} - ${formatDate(pickedDates.last, "MMM d, yyyy")}";
    }
  }

  bool validFields() {
    if (mode == "status" && statusCategory == null) {
      alert("Select status category", "You have to select the status category");
      return false;
    }

    if (mode == "leave" && leavePeriodCtrl.text.toString().trim() == "") {
      alert("Select leave period", "You have to select the leave period");
      return false;
    }
    return true;
  }

  void saveStatusUpdate() async {
    if (validFields()) {
      if (!await confirm(
          "Save status update?", "This will save the status update.")) return;
      var currentLocation = await locationManager.currentLocation();
      await recordsManager.saveUpdateStatus(
        StatusUpdate(
          latitude: "${currentLocation.latitude}",
          longitude: "${currentLocation.longitude}",
          statusType: mode,
          salerId: authManager.user.id,
          statusCategory: mode == "leave" ? "Leave" : statusCategory?.data,
          startDate: pickedDates.first,
          endDate: pickedDates.last,
          statusPhoto: image?.path,
          statusTime: DateTime.now(),
          statusNotes: notesCtrl.text,
        ),
      );
      alert("Status saved", "Your status update has been saved.", onOk: () {
        pop(context);
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }
}
