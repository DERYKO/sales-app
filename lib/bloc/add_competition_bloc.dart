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
import 'package:solutech_sat/data/models/user_location.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/brands_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/competitor_activities_manager.dart';
import 'package:solutech_sat/helpers/csku_manager.dart';
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

class AddCompetitionBloc extends Bloc {
  Customer customer;
  Brand brand;
  Csku csku;
  String category;
  AppData mechanism;
  TextEditingController notesCtrl = TextEditingController();
  TextEditingController batchNumberCtrl = TextEditingController();
  TextEditingController beforeCtrl = TextEditingController();
  TextEditingController afterCtrl = TextEditingController();
  List<DateTime> pickedDates = [
    DateTime.now(),
    DateTime.now(),
  ];
  TextEditingController leavePeriodCtrl = TextEditingController();
  UserLocation location;
  File image;

  AddCompetitionBloc({
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

  void selectCsku() async {
    var csku = await navigate(
      screen: SearchScreen(
        title: "Select csku",
        items: cskusManager
            .getCskusByCategory(category)
            .where((csku) => csku.categoryName == category)
            .toList(),
        onFilter: (Csku item, searchTerm) {
          return item.cskuName
              .toString()
              .trim()
              .toLowerCase()
              .contains(searchTerm);
        },
        builder: (Csku csku, index) {
          return Container(
            color: ((index + 1) % 2 == 0) ? Colors.white : Colors.grey[200],
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text("${csku.cskuName}"),
                ),
              ],
            ),
          );
        },
      ),
    );
    if (csku != null) {
      onCskuChanged(csku);
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
    beforeCtrl.clear();
    afterCtrl.clear();
    notifyChanges();
  }

  void onCskuChanged(value) {
    csku = value;
    beforeCtrl.clear();
    afterCtrl.clear();
    notifyChanges();
  }

  void onMechanismChanged(value) {
    mechanism = value;
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

  void onCategoryChanged(value) {
    this.category = value;
    if (value != null) {
      brand = null;
    }
    notifyChanges();
  }

  void saveDamage() async {
    if (category == null) {
      alert("Select category", "You have to select brand category.");
      return;
    }

    if (brand == null) {
      alert("Select brand", "You have to select a brand.");
      return;
    }

    if (beforeCtrl.text.trim() == "") {
      alert("Enter before value",
          "You have to enter the before value of competitor activity.");
      return;
    }

    if (mechanism == null) {
      alert("Select mechanism", "You have to select competition mechanism.");
      return;
    }

    if (afterCtrl.text.trim() == "") {
      alert("Enter after value",
          "You have to enter the after value of competitor activity.");
      return;
    }

    if (beforeCtrl.text.trim() == afterCtrl.text.trim()) {
      alert("Before and after are same",
          "You have to have different before and after values.");
      return;
    }

    if (image == null) {
      alert("Take a photo",
          "You have to take a photo of the product to continue.");
      return;
    }

    if (!await confirm(
        "Save competitor activity?", "This will save the competitor activity."))
      return;

    var currentLocation = await locationManager.currentLocation();

    await competitorActivitiesManager.saveCompetitorActivity(
      CompetitorActivity(
        visitId: sessionManager.session.sessionId,
        latitude: "${currentLocation.latitude ?? 0}",
        longitude: "${currentLocation.longitude ?? 0}",
        photo: image?.path,
        afterValue: afterCtrl.text,
        beforeValue: beforeCtrl.text,
        companyId: brand.companyId,
        shopId: customer.id,
        salerId: authManager.user.id,
        notes: notesCtrl.text,
        mechanism: mechanism.data,
        csku: csku?.id ?? null,
        productName: brand.brand,
        competitor: brand.company,
        entryTime: DateTime.now(),
      ),
    );
    alert(
        "Competitor activity saved", "Your competitor activity has been saved.",
        onOk: () {
      pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
  }
}
