import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart' hide Feedback;
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/brand.dart';
import 'package:solutech_sat/data/models/feedback.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/feedback_category.dart';
import 'package:solutech_sat/data/models/user_location.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/brands_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solutech_sat/ui/screen/search_screen.dart';
import 'package:solutech_sat/utils/image_utils.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class AddFeedbackBloc extends Bloc {
  Customer customer;
  String mode = "status";
  TextEditingController notesCtrl = TextEditingController();
  TextEditingController batchNumberCtrl = TextEditingController();
  TextEditingController quantityCtrl = TextEditingController();
  List<DateTime> pickedDates = [
    DateTime.now(),
    DateTime.now(),
  ];
  TextEditingController leavePeriodCtrl = TextEditingController();
  UserLocation location;
  File image;
  FeedbackCategory category;
  Brand brand;

  AddFeedbackBloc({
    this.customer,
  });

  void selectBrand() async {
    var brand = await navigate(
      screen: SearchScreen(
        title: "Select brand",
        items: brandsManager.brands,
        onFilter: (Brand brand, searchTerm) {
          return brand.brand
              .toString()
              .trim()
              .toLowerCase()
              .contains(searchTerm);
        },
        builder: (Brand brand, index) {
          return Container(
            color: ((index + 1) % 2 == 0) ? Colors.white : Colors.grey[200],
            padding: EdgeInsets.all(20.0),
            child: Text("${brand.brand}"),
          );
        },
      ),
    );
    if (brand != null) {
      onBrandChanged(brand);
    }
  }

  void onModeChange(mode) {
    this.mode = mode;
    notifyChanges();
  }

  void takePhoto() async {
    var pickedImage = await ImagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = await compressImageFile(pickedImage);
      notifyChanges();
    }
  }

  void onLocationChanged(location) {
    this.location = location;
    notifyChanges();
  }

  void onCategoryChanged(location) {
    this.category = location;
    notifyChanges();
  }

  void onBrandChanged(brand) {
    this.brand = brand;
    notifyChanges();
  }

  void saveFeedback() async {
    if (category == null) {
      alert("Select category",
          "You have to select feedback category to in order to save.");
      return;
    }

    if (notesCtrl.text.trim() == "") {
      alert(
          "Enter notes", "You have to enter feedback notes in order to save.");
      return;
    }

    if (!await confirm(
        "Save feedback?", "Are you sure you want to save this feedback."))
      return;

    var currentLocation = await locationManager.currentLocation();
    await recordsManager.saveFeedback(
      Feedback(
        photo: image?.path,
        entryTime: DateTime.now(),
        notes: notesCtrl.text,
        category: category.feedbackCategory,
        quantity: int.parse(
            "${quantityCtrl.text.trim() != "" ? quantityCtrl.text.trim() : 0}"),
        repId: authManager.user.id,
        productId: brand?.id,
        brand: brand?.brand,
        outletId: customer != null ? customer.id : null,
        batchnumber: batchNumberCtrl.text,
        lat: "${currentLocation.latitude}",
        lon: "${currentLocation.longitude}",
      ),
    );
    alert("Feedback saved", "Your feedback has been saved.", onOk: () {
      pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
  }
}
