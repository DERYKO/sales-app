import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart' hide Feedback;
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/brand.dart';
import 'package:solutech_sat/data/models/feedback.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/product_update.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/user_location.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/brands_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/product_updates_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solutech_sat/ui/screen/search_screen.dart';
import 'package:solutech_sat/utils/format_utils.dart';
import 'package:solutech_sat/utils/image_utils.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class AddProductUpdateBloc extends Bloc {
  Customer customer;
  final String updateType;
  DateTime pickedDate;
  Product product;
  TextEditingController notesCtrl = TextEditingController();
  TextEditingController expiryDateCtrl = TextEditingController();
  TextEditingController quantityCtrl = TextEditingController();
  List<Product> products = [];
  List<DateTime> pickedDates = [
    DateTime.now(),
    DateTime.now(),
  ];
  TextEditingController leavePeriodCtrl = TextEditingController();
  UserLocation location;
  File image;
  var productCategory;

  AddProductUpdateBloc({
    this.customer,
    this.updateType,
  });

  void selectProductCategory() async {
    var category = await navigate(
      screen: SearchScreen(
          title: "Select category",
          items: commonsManager.productCategories,
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

  void pickDate() async {
    pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 1)),
      lastDate: DateTime.now().add(Duration(days: 365 * 5)),
    );
    if (pickedDate != null) {
      expiryDateCtrl.text = "${formatDate(pickedDate, "MMM d, yyyy")}";
    }
  }

  void selectProduct() async {
    var product = await navigate(
        screen: SearchScreen(
            title: "Select product",
            items: products,
            onFilter: (Product item, searchTerm) {
              return item.productDesc
                  .toString()
                  .trim()
                  .toLowerCase()
                  .contains(searchTerm);
            },
            builder: (product, index) {
              return Container(
                color: ((index + 1) % 2 == 0) ? Colors.white : Colors.grey[200],
                padding: EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("${product.productDesc}"),
                    ),
                  ],
                ),
              );
            }));
    if (product != null) {
      onProductChanged(product);
    }
  }

  void onProductChanged(value) {
    product = value;
    quantityCtrl.clear();
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
    this.productCategory = value;
    if (value != null) {
      product = null;
      products = commonsManager.products
          .where((product) => product.productCategory == value)
          .toList();
    }
    notifyChanges();
  }

  void saveDamage() async {
    if (productCategory == null) {
      alert("Select category", "You have to select product category.");
      return;
    }

    if (product == null) {
      alert("Select product", "You have to select a product.");
      return;
    }

    if (quantityCtrl.text.trim() == "") {
      alert("Enter quantity",
          "You have to enter the quantity of products damaged.");
      return;
    }

    if (expiryDateCtrl.text.trim() == "" && updateType == "Expiry") {
      alert("Enter expiry date",
          "You have to enter the short expiry date of the product.");
      return;
    }

    if (image == null) {
      alert(
          "Take photo", "You have to take a photo of the product to continue.");
      return;
    }

    if (!await confirm("Save ${updateType?.toLowerCase()}?",
        "Are you sure you want to save this damage record.")) return;

    var currentLocation = await locationManager.currentLocation();

    await productUpdatesManager.saveProductUpdate(
      ProductUpdate(
        longitude: "${currentLocation.longitude ?? 0}",
        latitude: "${currentLocation.latitude ?? 0}",
        repId: authManager.user.id,
        productId: product.productId,
        updateType: "$updateType",
        quantity: int.parse("${quantityCtrl.text}"),
        notes: "${notesCtrl.text}",
        photo: image?.path,
        shopId: customer.id,
        visitId: sessionManager.session.sessionId,
        entryTime: DateTime.now(),
        expiryDate: (updateType == "Expiry") ? pickedDate : null,
      ),
    );
    alert("$updateType record saved",
        "Your ${updateType?.toLowerCase()} record has been saved.", onOk: () {
      pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
  }
}
