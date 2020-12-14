import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart' hide Feedback;
import 'package:flutter_bluetooth_serial_caravanas/flutter_bluetooth_serial.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/brand.dart';
import 'package:solutech_sat/data/models/csku.dart';
import 'package:solutech_sat/data/models/feedback.dart';
import 'package:solutech_sat/data/models/order.dart';
import 'package:solutech_sat/data/models/order_item.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/product_update.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/user_location.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/bluetooth_manager.dart';
import 'package:solutech_sat/helpers/brands_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/competitor_activities_manager.dart';
import 'package:solutech_sat/helpers/csku_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/product_updates_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solutech_sat/ui/screen/search_screen.dart';
import 'package:solutech_sat/utils/device_utils.dart';
import 'package:solutech_sat/utils/fmp10.dart';
import 'package:solutech_sat/utils/image_utils.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

import '../data/models/competitor_activity.dart';
import '../helpers/session_manager.dart';

class EtrPrinterBloc extends Bloc {
  void selectDevice(BluetoothDevice device) async {
/*    progressDialog.message = "Connecting...";
    progressDialog.show();*/
    await bluetoothManager.connectToDevice(device);
/*    progressDialog.hide();*/
  }

  void generateZ() async {
    progressDialog.message = "Printing...";
    progressDialog.show();
    var response = await fmp10.generateZReport();
    progressDialog.hide();
  }

  void resetPrinter() async {
    this.selectDevice(bluetoothManager.bluetoothDevice);
  }

  @override
  void initState() {
    super.initState();
    if (bluetoothManager.isEnabled) {
      bluetoothManager.scanDevices();
    }
  }
}
