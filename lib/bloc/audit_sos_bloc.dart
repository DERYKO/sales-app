import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart' hide Feedback;
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/brand.dart';
import 'package:solutech_sat/data/models/csku.dart';
import 'package:solutech_sat/data/models/feedback.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/product_update.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/sos.dart';
import 'package:solutech_sat/data/models/sos_item.dart';
import 'package:solutech_sat/data/models/user_location.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/brands_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/competitor_activities_manager.dart';
import 'package:solutech_sat/helpers/csku_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/product_updates_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/sos_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solutech_sat/ui/screen/search_screen.dart';
import 'package:solutech_sat/utils/image_utils.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

import '../data/models/competitor_activity.dart';
import '../helpers/session_manager.dart';

class AuditSosBloc extends Bloc {
  Customer customer;
  String brandCategory;
  int currentScreen = 0;

  File image;
  TextEditingController notesCtrl = TextEditingController();
  TextEditingController totalLengthCtrl = TextEditingController();
  TextEditingController totalFacingsCtrl = TextEditingController();
  AuditSosBloc({this.customer, this.brandCategory}) {
    loadPrefilledData();
  }
  List<List<TextEditingController>> audits = [];

  void nextScreen(position) {
    if (position == 1) {
      calculateTotals();
      print("POSITT $position");
      currentScreen = position;
      notifyChanges();
    }
  }

  void prevScreen(position) {
    if (position == 0) {
      currentScreen = position;
      notifyChanges();
    }
  }

  void saveAudit() async {
    if (image == null) {
      alert("Take a photo",
          "You have to take a photo of the products before you save");
      return;
    }
    if (totalFacingsCtrl.text.trim() == "") {
      alert("Enter total facings", "You have to enter the total facings");
    }
    if (totalLengthCtrl.text.trim() == "") {
      alert("Enter total length", "You have to enter the total length");
    }
    if (!await confirm("Save SOS?", "This will save the share of shelf data")) {
      return;
    }
    List<SosItem> sosItems = [];
    for (int i = 0;
        i < brandsManager.getBrandByCategory(brandCategory).toList().length;
        i++) {
      sosItems.add(
        SosItem(
          productId: brandsManager.getBrandByCategory(brandCategory)[i].id,
          productName: brandsManager.getBrandByCategory(brandCategory)[i].brand,
          facings: audits[i][0].text,
          length: audits[i][1].text,
          position: audits[i][2].text,
        ),
      );
    }
    sosManager
        .saveSos(
            Sos(
              repId: authManager.user.id,
              totalFacings: totalFacingsCtrl.text,
              totalLength: totalLengthCtrl.text,
              sosNotes: notesCtrl.text,
              entryTime: DateTime.now(),
              shopId: customer.id,
              shopName: customer.shopName,
              productCategory: brandCategory,
              fromServer: false,
              synced: false,
              photo: image?.path,
            ),
            sosItems)
        .then((done) {
      alert("Sos saved", "The sos record was saved successfuly",
          onOk: () => pop());
    });
  }

  void takePhoto() async {
    var pickedImage = await ImagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = await compressImageFile(pickedImage);
      List<int> imageBytes = image.readAsBytesSync();
      var codec = Base64Codec();
      String encoded = codec.encode(imageBytes);
      print("ENCODED: $encoded");
      notifyChanges();
    }
  }

  void calculateTotals() {
    int totalFacings = 0;
    int totalLength = 0;
    print("AUDITS ${audits.length}");
    audits.forEach((item) {
      totalFacings += int.parse(
          "${item[0].text.toString().trim() != "" ? item[0].text : 0}");
      totalLength += int.parse(
          "${item[1].text.toString().trim() != "" ? item[1].text : 0}");
    });
    totalFacingsCtrl.text = "$totalFacings";
    totalLengthCtrl.text = "$totalLength";
    notifyChanges();
  }

  void addAuditListeners(int index) {
    audits[index][0].addListener(() => notifyChanges());
    audits[index][1].addListener(() => notifyChanges());
    audits[index][2].addListener(() => notifyChanges());
  }

  Future<bool> onWillPop() async {
    if (brandsManager.getBrandByCategory(brandCategory).length > 0)
      return confirm("Confirm exit", "Are you sure you want to exit?");
    else
      return true;
  }

  void loadPrefilledData() {
    brandsManager.getBrandByCategory(brandCategory).toList().forEach((brand) {
      bool categoryHasRecords =
          sosManager.hasTodaysRecordForCategory(customer.id, brandCategory);
      print("categoryHasRecords $categoryHasRecords");
      if (categoryHasRecords) {
        List<SosItem> sosItems =
            sosManager.todaysSosItemsFor(customer.id, brandCategory);
        var item = sosItems.lastWhere(
            (sosItem) => sosItem.productName == brand.brand,
            orElse: () => null);
        int facings = item != null
            ? int.parse("${item.facings != "" ? item.facings : 0}")
            : 0;
        int length = item != null
            ? int.parse("${item.length != "" ? item.length : 0}")
            : 0;
        int position = item != null
            ? int.parse("${item.position != "" ? item.position : 0}")
            : 0;

        audits.add([
          TextEditingController(text: "${facings > 0 ? facings : ""}"),
          TextEditingController(text: "${length > 0 ? length : ""}"),
          TextEditingController(text: "${position > 0 ? position : ""}"),
        ]);
      } else {
        audits.add([
          TextEditingController(),
          TextEditingController(),
          TextEditingController(),
        ]);
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }
}
