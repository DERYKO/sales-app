import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/reports_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class PerformanceReportsBloc extends Bloc {
  void loadData() {
    if (connectionManager.isConnected) {
      reportsManager.loadMonthlyPerformance().catchError((error) {
        reportsManager.loadingMonthlyPerformance = false;
      });
    } else {
      Future.delayed(Duration(milliseconds: 1)).then((done) {
        alert(
            "You are offline", "Make sure you enable data then tap on refresh");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }
}
