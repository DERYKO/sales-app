import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart' hide Feedback;
import 'package:flutter_bluetooth_serial_caravanas/flutter_bluetooth_serial.dart';
import 'package:solutech_sat/data/models/order.dart';
import 'package:solutech_sat/data/models/order_item.dart';
import 'package:solutech_sat/data/models/printed_etr.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/bluetooth_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/utils/fmp10.dart';
import 'package:solutech_sat/utils/format_utils.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class EtrPrintingBloc extends Bloc {
  Order order;
  List<OrderItem> orderItems = [];

  EtrPrintingBloc({
    this.order,
    this.orderItems,
  });

  void selectDevice(BluetoothDevice device) async {
/*    progressDialog.message = "Connecting...";
    progressDialog.show();*/
    await bluetoothManager.connectToDevice(device);
/*    progressDialog.hide();*/
  }

  void printEtr() async {
    if (order.orderId == null) {
      alert("Sale not synced",
          "You will be able to print once the sale is synced.");
      return;
    }
    if ((await recordsManager.printedEtrDate(order.orderId)) != null) {
      alert("ETR has already been printed",
          "This ${order.entryType}(${order}) ETR receipt was printed on ${formatDate((await recordsManager.printedEtrDate(order.orderId))?.toString(), "xt")}. You can't print another receipt.");
      return;
    }
    if (orderItems
        .map((orderItem) =>
            commonsManager.productById(orderItem.productId)?.taxCode)
        .toList()
        .contains(null)) {
      alert(
        "Printing Failed",
        "Make sure you are assigned all the products and they all have a tax code.",
      );
      return;
    }
    fmp10.openFiscalCheckWithDefaultValues();
    if (order.synced) {
      fmp10.command54Variant0Version0("DOC NO.: ${order.orderId}");
    }
    fmp10.command54Variant0Version0(
        "Customer: ${routePlansManager.getCustomerById(order.shopId)?.shopName}");
    fmp10.command54Variant0Version0("");

    for (int i = 0; i < orderItems.length; i++) {
      String pckg = orderItems[i].productPackaging;
      pckg = pckg.replaceAll("\\s", "");
      fmp10.sellThisWithQuantity(
        "${commonsManager.productById(orderItems[i].productId)?.productCode ?? ""} ${commonsManager.productById(orderItems[i].productId)?.productDesc?.toUpperCase()}",
        commonsManager.productById(orderItems[i].productId)?.taxCode,
        orderItems[i].sellingPrice,
        "${orderItems[i].quantity}",
      );
    }

    fmp10.command54Variant0Version0(" ");
    fmp10.command54Variant0Version0(
        "-------------------------------------------");
    fmp10.command51Variant0Version1("-0.00");
    fmp10.totalInCash();

    fmp10.command54Variant0Version0(
        "Serviced By: ${authManager.user.name} (${authManager.user.phoneNumber})");
    fmp10.closeFiscalCheck();
    recordsManager.savePrintedEtr(PrintedEtr(
      printedAt: DateTime.now(),
      synced: false,
      orderId: order.orderId,
      printedBy: authManager.user.id,
    ));
  }

  void generateZ() async {
    progressDialog.message = "Printing...";
    progressDialog.show();
    var response = await fmp10.generateZReport();
    progressDialog.hide();
  }

  void duplicateReceipt() async {
    fmp10.command109Variant0Version0("1");
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
