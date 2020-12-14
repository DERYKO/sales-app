import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart' hide Feedback;
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/brand.dart';
import 'package:solutech_sat/data/models/csku.dart';
import 'package:solutech_sat/data/models/feedback.dart';
import 'package:solutech_sat/data/models/general_photo.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/product_update.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/user_location.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/brands_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/competitor_activities_manager.dart';
import 'package:solutech_sat/helpers/csku_manager.dart';
import 'package:solutech_sat/helpers/general_photos_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/product_updates_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solutech_sat/ui/screen/search_screen.dart';
import 'package:solutech_sat/utils/image_utils.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

import '../data/models/competitor_activity.dart';
import '../helpers/session_manager.dart';

class AddPhotoBloc extends Bloc {
  Customer customer;
  AppData category;
  String productCategory;
  AppData activity;
  TextEditingController notesCtrl = TextEditingController();
  List<DateTime> pickedDates = [
    DateTime.now(),
    DateTime.now(),
  ];
  File image;

  AddPhotoBloc({
    this.customer,
  });

  void selectProductCategory() async {
    var category = await navigate(
      screen: SearchScreen(
        title: "Select category",
        items: commonsManager.productCategories,
        onFilter: (String item, searchTerm) {
          return item.toString().trim().toLowerCase().contains(searchTerm);
        },
        builder: (String category, index) {
          return Container(
            color: ((index + 1) % 2 == 0) ? Colors.white : Colors.grey[200],
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text("$category"),
                ),
              ],
            ),
          );
        },
      ),
    );
    if (category != null) {
      onProductCategoryChanged(category);
    }
  }

  void onActivityChanged(value) {
    activity = value;
    notifyChanges();
  }

  void onProductCategoryChanged(value) {
    productCategory = value;
    notifyChanges();
  }

  void takePhoto() async {
    var pickedImage = await ImagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = await compressImageFile(pickedImage);
      notifyChanges();
    }
  }

  void onCategoryChanged(value) {
    this.category = value;
    if (value != null) {
      activity = null;
    }
    notifyChanges();
  }

  void saveDamage() async {
    if (category == null) {
      alert("Select category", "You have to select brand category.");
      return;
    }

    if (image == null) {
      alert("Take photo", "You have to take a photo of the activity.");
      return;
    }

    if (activity == null) {
      alert("Select activity", "You have to select a photo activity.");
      return;
    }

    if (!await confirm("Save general photo?",
        "This will save the general photo added activity.")) return;

    var currentLocation = await locationManager.currentLocation();

    await generalPhotosManager.saveGeneralPhoto(GeneralPhoto(
      visitid: sessionManager.session.sessionId,
      latitude: "${currentLocation.latitude ?? 0}",
      longitude: "${currentLocation.longitude ?? 0}",
      imagePhoto: image?.path,
      shopId: customer.id,
      productCategory: productCategory,
      salerId: authManager.user.id,
      imageNotes: notesCtrl.text,
      activityId: activity.appdataId,
      imageCategory: category.data,
      imageTime: DateTime.now(),
    ));
    alert("General photo saved",
        "Your general photo has been saved successfully.", onOk: () {
      pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
  }
}
