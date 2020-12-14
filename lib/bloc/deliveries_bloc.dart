import 'package:solutech_sat/data/models/delivery.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/deliveries_manager.dart';
import 'package:solutech_sat/helpers/posm_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:solutech_sat/ui/dialogs/contact_customer_dialog.dart';
import 'package:solutech_sat/ui/screen/delivery_screen.dart';

class DeliveriesBloc extends Bloc {
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
          deliveriesManager.loadDeliveries();
        }
      }
    } else {
      alert(
        "No connection",
        "Please make sure you are connected and have data before syncing.",
      );
    }
  }

  void onDelivery(Delivery delivery) {
    navigate(screen: DeliveryScreen(delivery: delivery));
  }

  void contactCustomer(int shopId) {
    var shop = routePlansManager.getCustomerById(shopId);
    var contactCustomerDialog = ContactCustomerDialog(context);
    if (shop != null) {
      contactCustomerDialog..phoneNumber = shop.shopPhoneno;
      contactCustomerDialog.show();
    }
  }

  void startTrip(int scheduleId) async {
    progressDialog.message = "Starting...";
    progressDialog.show();
    await deliveriesManager.startTrip(scheduleId);
    progressDialog.hide();
  }

  void endTrip(int scheduleId) async {
    progressDialog.message = "Ending...";
    progressDialog.show();
    await deliveriesManager.endTrip(scheduleId);
    progressDialog.hide();
  }

  @override
  void initState() {
    super.initState();
  }
}
