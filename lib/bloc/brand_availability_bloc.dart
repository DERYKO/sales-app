import 'package:solutech_sat/helpers/availability_manager.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class BrandAvailabilityBloc extends Bloc {
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
          availabilityManager.loadAvailability(pickedDates);
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
    print("AvItems ${availabilityManager.getAvailabilityItemsById(66).length}");
  }
}
