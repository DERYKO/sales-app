import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart' hide Feedback;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/bank.dart';
import 'package:solutech_sat/data/models/banking.dart';
import 'package:solutech_sat/data/models/brand.dart';
import 'package:solutech_sat/data/models/cheque.dart';
import 'package:solutech_sat/data/models/csku.dart';
import 'package:solutech_sat/data/models/feedback.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/product_update.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/sos.dart';
import 'package:solutech_sat/data/models/sos_item.dart';
import 'package:solutech_sat/data/models/user_location.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/banking_manager.dart';
import 'package:solutech_sat/helpers/brands_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/competitor_activities_manager.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/csku_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/product_updates_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/sos_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solutech_sat/ui/screen/search_screen.dart';
import 'package:solutech_sat/utils/image_utils.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

import '../data/models/competitor_activity.dart';
import '../helpers/session_manager.dart';

class BankingBloc extends Bloc {
  File image;
  Bank bank;
  String entryType;
  Cheque cheque;
  List<String> entryTypes = ["CASH", "CHEQUE"];
  TextEditingController bankingAmountCtrl = TextEditingController();
  TextEditingController notesCtrl = TextEditingController();

  void onBankChange(value) {
    bank = value;
    notifyChanges();
  }

  void onChequeChange(value) {
    cheque = value;
    notifyChanges();
  }

  void onOptionChange(value) {
    entryType = value;
    notifyChanges();
  }

  void saveBanking() async {
    if (bank == null) {
      alert("Select bank", "You haven't selected the bank.");
      return;
    }

    if (entryType == null) {
      alert("Select entry type", "You haven't selected  an entry type.");
      return;
    }

    if (bankingAmount <= 0) {
      alert("No money to be banked",
          "You haven't selected the appropriate cheque to be banked.");
      return;
    }

    if (image == null) {
      alert(
        "Take slip photo",
        "You haven't taken a photo of the banking slip.",
      );
      return;
    }

    if (bankingAmountCtrl.text.trim() == "" || bankingAmountCtrl.text == "0") {
      alert("Enter amount to bank",
          "You haven't entered the amount you want to bank.");
      return;
    }

    if (double.parse("${bankingAmountCtrl.text}") >
        double.parse("$bankingAmount")) {
      alert("Enter amount to bank",
          "You haven't entered the amount you want to bank.");
      return;
    }
    var currentLocation = await locationManager.currentLocation();
    bankingManager.saveBanking(Banking(
      amount: bankingAmountCtrl.text,
      notes: notesCtrl.text,
      slipPhoto: image?.path,
      entryType: entryType?.toLowerCase(),
      bankId: bank?.id,
      customerId: int.parse("${cheque?.outletId ?? 0}"),
      collectionId: cheque?.collectionId,
      bankName: bank?.bankName,
      accountNumber: bank?.accountNumber,
      branchName: bank?.branchName,
      entryTime: DateTime.now(),
      longitude: "${currentLocation.longitude}",
      latitude: "${currentLocation.latitude}",
    ));
    alert("Saved", "Banking saved successfuly", onOk: () {
      pop();
    });
  }

  void selectCheque() async {
    var cheque = await navigate(
      screen: SearchScreen(
        title: "Select cheque",
        items: bankingManager.cheques,
        onFilter: (Cheque item, searchTerm) {
          return item.paymentRef
              .toString()
              .trim()
              .toLowerCase()
              .contains(searchTerm);
        },
        builder: (cheque, index) {
          return Container(
            color: ((index + 1) % 2 == 0) ? Colors.white : Colors.grey[200],
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "${routePlansManager.getCustomerById(int.parse("${cheque.outletId}")).shopName}",
                      ),
                    ),
                    Text(
                      "${cheque.amountPaid}",
                    ),
                  ],
                ),
                Text(
                  "${cheque.paymentRef}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12.0,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
    if (cheque != null) {
      onChequeChange(cheque);
    }
  }

  void takePhoto() async {
    var selection = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select image source"),
            content: SizedBox(
              height: 100.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pop(context, 1);
                      },
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          "Camera",
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ),
                  if (roleManager.hasRole(Roles.ALLOW_GALLERY))
                    Container(
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pop(context, 2);
                        },
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            "Gallery",
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        });
    if (selection != null) {
      File pickedImage = await ImagePicker.pickImage(
        source: (selection == 1) ? ImageSource.camera : ImageSource.gallery,
      );
      if (pickedImage != null) {
        image = await compressImageFile(pickedImage);
        notifyChanges();
      }
    }
  }

  double get bankingAmount {
    return (entryType == "CASH")
        ? bankingManager.cashToBank
        : cheque != null ? double.parse("${cheque.amountPaid}") : 0;
  }

  @override
  void initState() {
    super.initState();
  }
}
