import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/packaging_option.dart';
import 'package:solutech_sat/data/models/stock_take.dart';
import 'package:solutech_sat/data/models/stock_take_item.dart';
import 'package:solutech_sat/data/models/virtual_stock.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:solutech_sat/data/models/mpesa_payment.dart';
import 'package:solutech_sat/data/models/order.dart';
import 'package:solutech_sat/data/models/order_item.dart';
import 'package:solutech_sat/data/models/payment_mode.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/route_plan.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/stock.dart';
import 'package:solutech_sat/data/models/stock_item.dart';
import 'package:solutech_sat/data/models/stockpoint.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/payments_manager.dart';
import 'package:solutech_sat/helpers/pricelist_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/stock_takes_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solutech_sat/ui/screen/inventory_screen.dart';
import 'package:solutech_sat/ui/screen/recent_activity_screen.dart';
import 'package:solutech_sat/ui/screen/search_screen.dart';
import 'package:solutech_sat/utils/format_utils.dart';
import 'package:solutech_sat/utils/image_utils.dart';

class StockTakingBloc extends Bloc {
  RoutePlan routePlan;
  Customer customer;
  int currentScreen = 0;
  File image;
  ScrollController scrollController = ScrollController();

  StockTakingBloc({this.routePlan, this.customer});
  PaymentMode paymentMode;
  var productCategories = [];
  var productCategory;
  PackagingOption packagingOption;
  List<Product> products = [];
  Product product;
  VirtualStock virtualStock;
  List<StockTakeItem> stockTakeItems = [];

  TextEditingController quantityCtrl = TextEditingController();

  void toggleReference() {
    if (paymentsManager.mpesaPayments.length > 0) {
      paymentsManager.mpesaPayments = [];
      paymentsManager.notifyChanges();
    } else {
      paymentsManager.loadMpesaPayments();
    }
  }

  void onUnitChange(value) {
    packagingOption = value;
    notifyChanges();
  }

  Future<bool> onWillPop() async {
    if (stockTakeItems.length > 0)
      return confirm("Confirm exit", "Are you sure you want to exit?");
    else
      return true;
  }

  void nextScreen(pos) {
    if (listHasItems()) {
      currentScreen = pos;
      print("Print next screen");
      notifyChanges();
    } else {
      alert(
        "Add items to list",
        "You have to add the items you are selling to this customer to the list.",
      );
    }
  }

  bool listHasItems() {
    return stockTakeItems.length > 0;
  }

  void prevScreen(pos) {
    currentScreen = pos;
    notifyChanges();
  }

  void saveStockTake() async {
    await takePhoto();
    if (image == null) return;
    if (!await confirm(
      "Save stock take?",
      "This will save the stock take that you have made.",
    )) return;
    var currentLocation = await locationManager.currentLocation();
    stockTakesManager.saveStockTake(
      order: StockTake(
        synced: false,
        salerId: authManager.user.id,
        entryTime: DateTime.now(),
        outletId: customer.id,
        stockphoto: image?.path,
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
        fromServer: false,
      ),
      stockTakeItems: stockTakeItems,
    );
    alert("Stock take saved", "Your stock take items where saved successfuly",
        onOk: () {
      pop();
    });
  }

  void onDeleteItem(index) async {
    bool dismiss = await confirm(
        "Delete product", "Confirm you want to delete the product");
    if (dismiss) {
      stockTakeItems.removeAt(index);
      notifyChanges();
    }
  }

  Future<File> takePhoto() async {
    var selection = 1;
    /*await showDialog<int>(
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
        });*/
    if (selection != null) {
      File pickedImage = await ImagePicker.pickImage(
        source: (selection == 1) ? ImageSource.camera : ImageSource.gallery,
      );
      if (pickedImage != null) {
        image = await compressImageFile(pickedImage);
        notifyChanges();
      }
    }
    return image;
  }

  void addOrUpdateProduct() async {
    if (validateFields()) {
      if (hasProductInList(product)) {
        int index = productIndex(product);
        stockTakeItems[index].quantity += int.parse("${quantityCtrl.text}");
        quantityCtrl.clear();
        FocusScope.of(context).requestFocus(new FocusNode());
        scrollController.animateTo(
          0.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      } else {
        stockTakeItems.add(
          StockTakeItem(
            productId: product.productId,
            packaging: packagingOption.packageKey,
            quantity: int.parse("${quantityCtrl.text}"),
          ),
        );
      }
      quantityCtrl.clear();
      FocusScope.of(context).requestFocus(new FocusNode());
      scrollController.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
      print("Scrolled");
    }
    notifyChanges();
  }

  bool hasProductInList(Product product) {
    return productIndex(product) == -1 ? false : true;
  }

  int productIndex(Product product) {
    return stockTakeItems.indexWhere((stockItem) =>
        stockItem.productId == product.productId &&
        stockItem.packaging == packagingOption.packageKey);
  }

  String numberValidator(String value) {
    if (value == null) {
      return null;
    }
    final n = num.tryParse(value);
    if (n == null) {
      return '"$value" is not a valid number';
    }
    return null;
  }

  void onItemDismissed(direction, index) {
    stockTakeItems.removeAt(index);
    notifyChanges();
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

  void selectProductCategory() async {
    print("Categories ${inventoryManager.virtualStockCategories}");
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

  String get addButtonText => /*isUpdate ? "UPDATE" : */ "ADD TO LIST";

  bool validateFields() {
    if (productCategory == null) {
      alert("Select product category",
          "Please select a product category to continue");
      return false;
    }

    if (product == null) {
      alert("Select a product", "Please select a product to continue");
      return false;
    }

    if (quantityCtrl.text.trim() == "") {
      alert("Quantity", "Please check your quantity");
      return false;
    }

    if (packagingOption == null) {
      alert("Select packaging", "Please a unit of packaging");
      return false;
    }
    return true;
  }

  void clearFields() {
    product = null;
    quantityCtrl.clear();
  }

  void onCategoryChanged(value) {
    clearFields();
    productCategory = value;
    if (value != null) {
      product = null;
      products = commonsManager.products
          .where((product) => product.productCategory == value)
          .toList();
    }
    notifyChanges();
  }

  void onProductChanged(value) {
    product = value;
    quantityCtrl.clear();
    notifyChanges();
  }

  @override
  void initState() {
    super.initState();
    paymentMode = commonsManager.paymentModes.firstWhere(
        (paymentMode) => paymentMode.slug == "cash",
        orElse: () => null);
    if (commonsManager.packagingOptions.length > 0) {
      onUnitChange(commonsManager.packagingOptions.first);
    }
  }
}
