import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/delivery.dart';
import 'package:solutech_sat/data/models/survey_info.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/deliveries_manager.dart';
import 'package:solutech_sat/helpers/posm_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/surveys_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:solutech_sat/ui/dialogs/contact_customer_dialog.dart';
import 'package:solutech_sat/ui/screen/delivery_screen.dart';
import 'package:solutech_sat/ui/screen/survey_screen.dart';

class SurveysBloc extends Bloc {
  Customer customer;
  SurveysBloc({this.customer});
  var pickedDates = [
    DateTime.now(),
    DateTime.now(),
  ];

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
          surveysManager.loadSurveyAnswers(pickedDates);
        }
      }
    } else {
      alert(
        "No connection",
        "Please make sure you are connected and have data before syncing.",
      );
    }
  }

  void fillSurvey() {
    navigate(screen: SurveyScreen());
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
      surveysManager.loadSurveyAnswers(picked);
      surveysManager.loadSurveyAnswers(picked);
    }
  }

  @override
  void initState() {
    super.initState();
  }
}
