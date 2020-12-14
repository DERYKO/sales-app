import 'package:flutter/material.dart';
import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/route_plan.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/shop_category.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/dialogs/contact_customer_dialog.dart';
import 'package:solutech_sat/ui/screen/add_edit_customer_screen.dart';
import 'package:solutech_sat/ui/screen/add_feedback_screen.dart';
import 'package:solutech_sat/ui/screen/brand_audit_screen.dart';
import 'package:solutech_sat/ui/screen/posm_audit_screen.dart';
import 'package:solutech_sat/ui/screen/posm_screen.dart';
import 'package:solutech_sat/ui/screen/recent_activity_screen.dart';
import 'package:solutech_sat/ui/screen/sale_order_screen.dart';
import 'package:solutech_sat/ui/screen/skip_customer_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenDayBloc extends Bloc {
  TextEditingController odometerCtrl = TextEditingController();
  TextEditingController commentsCtrl = TextEditingController();

  void openDay() async {
    if (await confirm(
      "Start day?",
      "This will enable you to perform activities in outlets.",
    )) {
      if (commentsCtrl.text.trim() == "") {
        alert("Enter comment", "Comment about your day.");
        return;
      }
      dayManager
          .openDay(
        comments: commentsCtrl.text,
        odometer: odometerCtrl.text,
      )
          .then((response) {
        pop(true);
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }
}
