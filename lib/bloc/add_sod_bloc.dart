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
import 'package:solutech_sat/data/models/sod.dart';
import 'package:solutech_sat/data/models/user_location.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/brands_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/competitor_activities_manager.dart';
import 'package:solutech_sat/helpers/csku_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/product_updates_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/sod_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solutech_sat/ui/screen/search_screen.dart';
import 'package:solutech_sat/utils/image_utils.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

import '../data/models/competitor_activity.dart';
import '../helpers/session_manager.dart';

class AddSodBloc extends Bloc {
  Customer customer;
  Brand brand;
  String category;
  List<String> imageUrls = [];
  AppData displayType;
  TextEditingController notesCtrl = TextEditingController();
  TextEditingController batchNumberCtrl = TextEditingController();
  TextEditingController quantityCtrl = TextEditingController();
  List<DateTime> pickedDates = [
    DateTime.now(),
    DateTime.now(),
  ];
  TextEditingController leavePeriodCtrl = TextEditingController();
  UserLocation location;

  AddSodBloc({
    this.customer,
  });

  void selectBrandCategory() async {
    var category = await navigate(
      screen: SearchScreen(
          title: "Select category",
          items: brandsManager.categories,
          onFilter: (category, searchTerm) {
            return category
                .toString()
                .trim()
                .toLowerCase()
                .contains(searchTerm);
          },
          builder: (category, index) {
            return Container(
              color: ((index + 1) % 2 == 0) ? Colors.white : Colors.grey[200],
              padding: EdgeInsets.all(20.0),
              child: Text("$category"),
            );
          }),
    );
    if (category != null) {
      onCategoryChanged(category);
    }
  }

  void selectDisplayType() async {
    var displayType = await navigate(
      screen: SearchScreen(
        title: "Select display type",
        items: commonsManager.displayTypes.toList(),
        onFilter: (AppData item, searchTerm) {
          return item.data.toString().trim().toLowerCase().contains(searchTerm);
        },
        builder: (AppData displayType, index) {
          return Container(
            color: ((index + 1) % 2 == 0) ? Colors.white : Colors.grey[200],
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text("${displayType.data}"),
                ),
              ],
            ),
          );
        },
      ),
    );
    if (displayType != null) {
      onDisplayTypeChanged(displayType);
    }
  }

  void selectBrand() async {
    var product = await navigate(
      screen: SearchScreen(
        title: "Select brand",
        items: brandsManager.brands
            .where((brand) => brand.category == category)
            .toList(),
        onFilter: (Brand item, searchTerm) {
          return item.brand
              .toString()
              .trim()
              .toLowerCase()
              .contains(searchTerm);
        },
        builder: (Brand brand, index) {
          return Container(
            color: ((index + 1) % 2 == 0) ? Colors.white : Colors.grey[200],
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text("${brand.brand}"),
                ),
              ],
            ),
          );
        },
      ),
    );
    if (product != null) {
      onBrandChanged(product);
    }
  }

  void onBrandChanged(value) {
    brand = value;
    quantityCtrl.clear();
    notifyChanges();
  }

  void onDisplayTypeChanged(value) {
    displayType = value;
    notifyChanges();
  }

  void takePhoto() async {
    var pickedImage = await ImagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      File image = await compressImageFile(pickedImage);
      if (image != null) {
        imageUrls.add(image.path);
      }
      notifyChanges();
    }
  }

  void onLocationChanged(location) {
    this.location = location;
    notifyChanges();
  }

  void onCategoryChanged(value) {
    this.category = value;
    if (value != null) {
      brand = null;
    }
    notifyChanges();
  }

  void saveSod() async {
    if (category == null) {
      alert("Select category", "You have to select brand category.");
      return;
    }

    if (brand == null) {
      alert("Select brand", "You have to select a brand.");
      return;
    }

    if (displayType == null) {
      alert("Select display type", "You have to select a display type.");
      return;
    }

    if (quantityCtrl.text.trim() == "") {
      alert("Enter display quantity",
          "You have to enter the quantity of displays.");
      return;
    }

    if (imageUrls.length == 0) {
      alert("Take a photo", "You have to take at least one photo to continue.");
      return;
    }

    if (!await confirm("Save share of display?",
        "This will save the share of display activity.")) return;

    var currentLocation = await locationManager.currentLocation();

    await sodManager.saveSod(
        Sod(
          visitid: sessionManager.session.sessionId,
          latitude: "${currentLocation.latitude ?? 0}",
          longitude: "${currentLocation.longitude ?? 0}",
          shopId: customer.id,
          repId: authManager.user.id,
          notes: notesCtrl.text,
          competitor: brand.company,
          displayType: displayType.data,
          brand: brand.brand,
          quantity: int.parse("${quantityCtrl.text.toString().trim()}"),
          entryTime: DateTime.now(),
        ),
        imageUrls);
    alert("Share of display saved", "Your SOD has been saved successfully.",
        onOk: () {
      pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
  }
}
