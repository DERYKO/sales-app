import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solutech_sat/data/models/route_plan.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/shop_category.dart';
import 'package:solutech_sat/data/models/user_location.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/screen/search_screen.dart';
import 'package:solutech_sat/utils/image_utils.dart';
import 'package:solutech_sat/utils/validators.dart';

class AddEditCustomerBloc extends Bloc {
  TextEditingController customerNameCtrl;
  TextEditingController kraPinCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController phoneNumberCtrl;
  TextEditingController contactPersonCtrl;

  RoutePlan routePlan;
  UserLocation location;
  Customer customer;
  File image;
  ShopCategory customerCategory;
  int currentScreen = 0;
  String mode = "add";
  AddEditCustomerBloc({
    this.customer,
    this.mode,
    this.routePlan,
  });

  void selectUserLocation() async {
    var location = await navigate(
      screen: SearchScreen(
          title: "Select location",
          items: locationManager.userLocations,
          onFilter: (UserLocation location, searchTerm) {
            return location.locationName
                .toString()
                .trim()
                .toLowerCase()
                .contains(searchTerm);
          },
          builder: (UserLocation location, index) {
            return Container(
              color: ((index + 1) % 2 == 0) ? Colors.white : Colors.grey[200],
              padding: EdgeInsets.all(20.0),
              child: Text("${location.locationName}"),
            );
          }),
    );
    if (location != null) {
      onLocationChanged(location);
    }
  }

  void saveCustomer() async {
    var currentLocation = await locationManager.currentLocation();
    if (validFields()) {
      if (!await confirm(
          "Save customer?",
          mode == "add"
              ? "Are you sure you want to save the customer to your list of customers"
              : "Are you sure you want to save changes made to ${customer.shopName}?"))
        return;
      if (mode == "add") {
        customer = Customer(
          addedBy: authManager.user.id,
          location: location.locationName,
          locationId: location.id,
          photo: image?.path ?? null,
          regionId: location.regionId,
          shopName: customerNameCtrl.text.trim(),
          contactPerson: contactPersonCtrl.text.trim(),
          shopPhoneno: phoneNumberCtrl.text.trim(),
          shopCatId: customerCategory.shopcatId,
          customerType: customerCategory.shopCatName,
          visitTime: DateTime.now().toIso8601String(),
          slatitude: "${currentLocation.latitude}",
          slongitude: "${currentLocation.longitude}",
          kraPin: kraPinCtrl.text.toUpperCase(),
          address: addressCtrl.text,
          verified: "Pending",
          routeId: routePlan.id,
        );
        await routePlansManager.saveCustomer(customer);

        alert("Customer saved",
            "The customer was added to your list of customers.", onOk: () {
          pop();
        });
      } else {
        customer
          ..location = location.locationName
          ..locationId = location.id
          ..photo = image?.path ?? customer.photo ?? null
          ..regionId = location.regionId
          ..shopName = customerNameCtrl.text.trim()
          ..contactPerson = contactPersonCtrl.text.trim()
          ..shopPhoneno = phoneNumberCtrl.text.trim()
          ..shopCatId = customerCategory.shopcatId
          ..customerType = customerCategory.shopCatName
          ..updatedTime = DateTime.now().toIso8601String()
          ..routeId = routePlan.id;
        await routePlansManager.saveUpdatedCustomer(customer);

        alert("Customer updated", "The customer was updated successfuly.",
            onOk: () {
          if (sessionManager.referred) {
            pop();
          } else {
            pop();
            pop();
            sessionManager.referred = false;
          }
        });
      }
    }
  }

  bool validFields() {
    if (customerNameCtrl.text.toString().trim() == "") {
      alert("Enter customer name", "Customer name cannot be left empty");
      return false;
    }

    if (location == null) {
      alert("Select location", "Location name cannot be left empty");
      return false;
    }

    if (customerCategory == null) {
      alert("Select customer category", "Customer category is required");
      return false;
    }

    if (phoneNumberCtrl.text.trim() != "") {
      if (!validPhoneNumber(phoneNumberCtrl.text.trim())) {
        alert("Invalid phone number", "Please enter a valid phone number");
        return false;
      }

      if (routePlansManager.shops
              .map((shop) => shop.shopPhoneno)
              .toList()
              .contains(phoneNumberCtrl.text.trim()) &&
          customer?.shopPhoneno != phoneNumberCtrl.text.trim()) {
        alert(
          "Phone number taken",
          "Another outlet already has the phone number you are trying to add.",
        );
        return false;
      }
    }
    return true;
  }

  void onLocationChanged(location) {
    this.location = location;
    notifyChanges();
  }

  void onShopCategoryChanged(location) {
    this.customerCategory = location;
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
    super.initState();
    customerNameCtrl = TextEditingController(text: customer?.shopName ?? "");
    phoneNumberCtrl = TextEditingController(text: customer?.shopPhoneno ?? "");
    contactPersonCtrl =
        TextEditingController(text: customer?.contactPerson ?? "");
    if (mode != "add" && customer != null) {
      location = locationManager.userLocations.firstWhere(
        (location) => location.id == customer.locationId,
        orElse: () => null,
      );
    }

    if (mode != "add" && customer != null) {
      customerCategory = commonsManager.shopCategories.firstWhere(
          (category) => category.shopcatId == customer.shopCatId,
          orElse: () => null);
    }
  }
}
