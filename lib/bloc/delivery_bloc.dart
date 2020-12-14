import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_signature_view/flutter_signature_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solutech_sat/data/models/delivery.dart';
import 'package:solutech_sat/helpers/deliveries_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';

import 'package:solutech_sat/ui/dialogs/contact_customer_dialog.dart';
import 'package:solutech_sat/utils/image_utils.dart';

class DeliveryBloc extends Bloc {
  Delivery delivery;
  File image;
  bool hasSignature = false;
  DeliveryBloc({this.delivery});
  TextEditingController commentCtrl = TextEditingController();
  SignatureView signature = SignatureView(
    backgroundColor: Colors.white,
    penStyle: Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0,
  );

  void clearSignature() {
    signature.clear();
    hasSignature = false;
    notifyChanges();
  }

  void onSign(data) {
    hasSignature = true;
    notifyChanges();
  }

  void deliverItems() async {
    if (validateFields()) {
      if (!await confirm("Deliver order to ${delivery.shopName}",
          "This will deliver the order items to the customer")) return;
      var currentLocation = await locationManager.currentLocation();

      final data = await signature.exportBytes();
      var sign = await getImageFileFromUint8List(data, "signature");
      await deliveriesManager.saveDelivery(
        delivery
          ..shopLat = "${currentLocation.latitude}"
          ..shopLon = "${currentLocation.longitude}"
          ..photo = image.path
          ..deliveryTime = DateTime.now()
          ..deliveryNotes = commentCtrl.text
          ..receivedsignature = sign.path,
      );
      alert("Delivery successful",
          "Items where delivered to ${delivery.shopName} successfuly.",
          onOk: () => pop());
    }
  }

  bool validateFields() {
    if (signature.isEmpty) {
      alert("Enter signature", "Please enter your signature to continue.");
      return false;
    }

    if (commentCtrl.text.trim() == "") {
      alert("Enter comment", "Please enter a comment");
      return false;
    }

    if (image == null) {
      alert("Take a photo of stock",
          "Please take a photo of the stock to confirm its availability.");
      return false;
    }
    return true;
  }

  contactCustomer(int shopId) {
    var shop = routePlansManager.getCustomerById(shopId);
    var contactCustomerDialog = ContactCustomerDialog(context);
    if (shop != null) {
      contactCustomerDialog..phoneNumber = shop.shopPhoneno;
      contactCustomerDialog.show();
    }
  }

  void onDragStart(DragStartDetails details) {
    hasSignature = true;
    notifyChanges();
  }

  void takePhoto() async {
    var pickedImage = await ImagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = await compressImageFile(pickedImage);
      notifyChanges();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signature = SignatureView(
      backgroundColor: Colors.white,
      penStyle: Paint()
        ..color = Colors.black
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 5.0,
      onSigned: onSign,
    );
  }
}
