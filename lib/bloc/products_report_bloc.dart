import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/reports_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class ProductsReportBloc extends Bloc {
  var pickedDates = [
    DateTime.now(),
    DateTime.now(),
  ];
  String category;
  ProductsReportBloc({this.category, this.pickedDates});
  @override
  void initState() {
    super.initState();

    if (connectionManager.isConnected) {
      reportsManager
          .loadSkusByCategory(category, pickedDates)
          .catchError((error) {
        reportsManager.loadingSkusByCategory = false;
      });
    } else {
      Future.delayed(Duration(milliseconds: 1)).then((done) {
        alert(
            "You are offline", "Make sure you enable data then tap on refresh");
      });
    }
  }
}
