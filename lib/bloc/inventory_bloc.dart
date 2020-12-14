import 'package:flutter/material.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/inventory.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/role.dart';
import 'package:solutech_sat/data/models/virtual_stock.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/banking_manager.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/permission_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/screen/add_stock_screen.dart';
import 'package:solutech_sat/ui/screen/open_day_screen.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class InventoryBloc extends Bloc {
  var pickedDates = [
    DateTime.now(),
    DateTime.now(),
  ];

  String quantitySum(List<VirtualStock> products) {
    var quantity = 0;
    products.forEach((item) {
      quantity += int.parse("${item.quantity}");
    });
    return "$quantity";
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
          inventoryManager.loadStock(pickedDates);
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

  showClosedDayDialog() {
    alert("Day already closed",
        "You can't perform this activity after closing the day. Go rest and pick up from tomorrow");
  }

  void addStock() async {
    if (dayManager.openedDay) {
      navigate(
        screen: AddStockScreen(),
      );
    } else {
      bool opened = await navigate(
        screen: OpenDayScreen(),
      );
      if (opened != null && opened) {
        navigate(
          screen: AddStockScreen(),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    print("Guit ${inventoryManager.groupedVirtualStock}");
  }
}
