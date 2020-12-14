import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart' hide Feedback;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/bank.dart';
import 'package:solutech_sat/data/models/banking.dart';
import 'package:solutech_sat/data/models/brand.dart';
import 'package:solutech_sat/data/models/cheque.dart';
import 'package:solutech_sat/data/models/csku.dart';
import 'package:solutech_sat/data/models/feedback.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/product_update.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/sos.dart';
import 'package:solutech_sat/data/models/sos_item.dart';
import 'package:solutech_sat/data/models/user_location.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/banking_manager.dart';
import 'package:solutech_sat/helpers/brands_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/competitor_activities_manager.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/csku_manager.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/product_updates_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/sos_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solutech_sat/ui/screen/banking_screen.dart';
import 'package:solutech_sat/ui/screen/open_day_screen.dart';
import 'package:solutech_sat/ui/screen/search_screen.dart';
import 'package:solutech_sat/utils/image_utils.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

import '../data/models/competitor_activity.dart';
import '../helpers/session_manager.dart';

class BankingsBloc extends Bloc {
  var pickedDates = [
    DateTime.now(),
    DateTime.now(),
  ];

  void addBanking() async {
    if (dayManager.openedDay) {
      navigate(screen: BankingScreen());
    } else {
      bool opened = await navigate(
        screen: OpenDayScreen(),
      );
      if (opened != null && opened) {
        navigate(screen: BankingScreen());
      }
    }
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
          bankingManager.loadBankings(pickedDates);
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

  @override
  void initState() {
    super.initState();
  }
}
