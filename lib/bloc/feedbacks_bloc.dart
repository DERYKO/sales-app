import 'dart:io';

import 'package:flutter/material.dart' hide Feedback;
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/feedback.dart';
import 'package:solutech_sat/data/models/user_location.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/screen/add_feedback_screen.dart';
import 'package:solutech_sat/ui/screen/add_status_update_screen.dart';
import 'package:solutech_sat/ui/screen/feedback_comments_screen.dart';
import 'package:solutech_sat/ui/screen/open_day_screen.dart';
import 'package:solutech_sat/ui/screen/search_screen.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class FeedbacksBloc extends Bloc {
  TextEditingController customerNameCtrl;
  TextEditingController phoneNumberCtrl;
  TextEditingController contactPersonCtrl;

  UserLocation location;
  File image;
  AppData appData;
  var pickedDates = [
    DateTime.now(),
    DateTime.now(),
  ];
  FeedbacksBloc();

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
          }),
    );
    if (location != null) {
      onLocationChanged(location);
    }
  }

  void onLocationChanged(location) {
    this.location = location;
    notifyChanges();
  }

  void openFeedbackComments(Feedback feedback) {
    navigate(
        screen: FeedbackCommentsScreen(
      feedback: feedback,
    ));
  }

  void refresh() async {
    if (connectionManager.isConnected) {
      if (await syncManager.shouldSync) {
        progressDialog.message = "Syncing data...";
        progressDialog.show();
        syncManager.sync().then((data) async {
          progressDialog.hide();
          if (!await syncManager.shouldSync) {
            refresh();
          } else {
            alert("Sync failed", "Data could not be synced.");
          }
        });
      } else {
        if (!syncManager.syncing) {
          recordsManager.loadFeedbacks(pickedDates);
        }
      }
    } else {
      alert(
        "No connection",
        "Please make sure you are connected and have data before syncing.",
      );
    }
  }

  void filterByDate() async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: pickedDates.first,
      initialLastDate: pickedDates.last,
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked.length > 0) {
      pickedDates = picked;
      refresh();
    }
  }

  void onAppDataChanged(location) {
    this.appData = location;
    notifyChanges();
  }

  showClosedDayDialog() {
    alert(
      "Day already closed",
      "You can't perform this activity after closing the day. Go rest and pick up from tomorrow",
    );
  }

  void addFeedback() async {
    if (dayManager.openedDay) {
      navigate(
        screen: AddFeedbackScreen(),
      );
    } else {
      bool opened = await navigate(
        screen: OpenDayScreen(),
      );
      if (opened != null && opened) {
        navigate(
          screen: AddFeedbackScreen(),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }
}
