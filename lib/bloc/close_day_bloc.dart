import 'package:flutter/material.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/stats_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';

class CloseDayBloc extends Bloc {
  TextEditingController odometerCtrl = TextEditingController();
  TextEditingController generalCommentCtrl = TextEditingController();
  TextEditingController callageCommentCtrl = TextEditingController();
  TextEditingController salesCommentCtrl = TextEditingController();

  void closeDay() async {
    if (validFields()) {
      if (await confirm("Close day?",
          "You will not be able to perform any other activity until tomorrow.")) {
        dayManager
            .closeDay(
          generalComment: generalCommentCtrl.text,
          odometer: odometerCtrl.text,
          callageComment: callageCommentCtrl.text,
          salesComment: callageCommentCtrl.text,
        )
            .then((response) {
          alert("Day closed",
              "Your day was closed successfuly, you deserve a rest.", onOk: () {
            pop();
          });
        });
      }
    }
  }

  bool validFields() {
    if ((int.parse("${statsManager.salesSummary.target}") >
            int.parse(
                "${Set.from(sessionManager.sessions.map((session) => session.customerId).toList()).length}")) &&
        callageCommentCtrl.text.trim() == "") {
      alert("Enter callage comment",
          "You have to give a reason why you where not able to achieve your customer visit targets.");
      return false;
    }

    if ((double.parse("${statsManager.salesSummary.targetValue}") >
            double.parse("${statsManager.salesSummary.totalSales}")) &&
        salesCommentCtrl.text.trim() == "") {
      alert("Enter sales comment",
          "You have to give a reason why you where not able to achieve your sales targets.");
      return false;
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
  }
}
