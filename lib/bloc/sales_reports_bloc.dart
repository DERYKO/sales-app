import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/reports_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/dialogs/contact_customer_dialog.dart';
import 'package:solutech_sat/ui/screen/customers_screen.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:solutech_sat/ui/screen/products_report_screen.dart';

class SalesReportsBloc extends Bloc {
  List<DateTime> pickedDates = [
    DateTime.now(),
    DateTime.now(),
  ];
  void filterByDate() async {
    if (connectionManager.isConnected) {
      final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: pickedDates.first,
        initialLastDate: pickedDates.last,
        firstDate: DateTime(2015),
        lastDate: DateTime.now(),
      );
      if (picked != null && picked.length > 0) {
        pickedDates = picked;
        reportsManager.loadCatlist(picked);
      }
    } else {
      alert("You are offline", "Make sure you enable data to continue");
    }
  }

  void onRefresh() {
    if (connectionManager.isConnected) {
      reportsManager.loadCatlist().catchError((error) {
        reportsManager.loadingCatlist = false;
      });
    } else {
      alert("You are offline", "Make sure you enable data then tap on refresh");
    }
  }

  void openProductsReport(String category) {
    navigate(
        screen: ProductsReportScreen(
      category: category,
      pickedDates: pickedDates,
    ));
  }

  @override
  void initState() {
    super.initState();
    if (connectionManager.isConnected) {
      reportsManager.loadCatlist().catchError((error) {
        reportsManager.loadingCatlist = false;
      });
    } else {
      Future.delayed(Duration(milliseconds: 1)).then((done) {
        alert(
            "You are offline", "Make sure you enable data then tap on refresh");
      });
    }
  }
}
