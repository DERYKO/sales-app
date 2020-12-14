import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/product_updates_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/dialogs/contact_customer_dialog.dart';
import 'package:solutech_sat/ui/screen/customers_screen.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:solutech_sat/ui/screen/open_day_screen.dart';

class ProductUpdatesBloc extends Bloc {
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
          productUpdatesManager.loadProductUpdates(pickedDates);
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

  void chooseCustomer() async {
    if (dayManager.openedDay) {
      navigate(
        screen: CustomersScreen(),
      );
    } else {
      bool opened = await navigate(
        screen: OpenDayScreen(),
      );
      if (opened != null && opened) {
        navigate(
          screen: CustomersScreen(),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }
}
