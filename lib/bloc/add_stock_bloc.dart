import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/packaging_option.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/stock.dart';
import 'package:solutech_sat/data/models/stock_item.dart';
import 'package:solutech_sat/data/models/stockpoint.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/stockpoints_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solutech_sat/ui/screen/inventory_screen.dart';
import 'package:solutech_sat/ui/screen/search_screen.dart';
import 'package:solutech_sat/utils/image_utils.dart';

class AddStockBloc extends Bloc {
  int currentScreen = 0;
  String mode = "Requisition";
  bool isUpdate = false;
  File image;
  bool saving = false;
  ScrollController scrollController = ScrollController();
  TextEditingController totalPriceCtrl = TextEditingController();
  TextEditingController batchnumberCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController quantityCtrl = TextEditingController();
  TextEditingController commentCtrl = TextEditingController();
  TextEditingController referenceCtrl = TextEditingController();

  List<String> paymentMethods = ["Cash", "M-pesa", "Cheque"];
  String paymentMethod = "Cash";
  Stockpoint stockpoint;
  var productCategories = [];
  var productCategory;
  PackagingOption packagingOption;
  List<Product> products = [];
  Product product;
  List<StockItem> stockList = [];

  void onModeChange(value) {
    mode = value;
    notifyChanges();
  }

  void onStockpointChanged(value) {
    stockpoint = value;
    productCategory = null;
    product = null;
    notifyChanges();
  }

  void onUnitChange(value) {
    packagingOption = value;
    setSellingPrice();
    notifyChanges();
  }

  void nextScreen(pos) {
    if (listHasItems()) {
      totalPriceCtrl.text = "${stockListTotal()}";
      currentScreen = pos;
      print("Print next screen");
      notifyChanges();
    } else {
      alert("Add items", "You have to add items to the list");
    }
  }

  bool listHasItems() {
    return stockList.length > 0;
  }

  void prevScreen(pos) {
    currentScreen = pos;
    notifyChanges();
  }

  void saveStockItems() async {
    if (image == null) {
      alert("Take receipt photo",
          "You have to take a photo of the receipt to continue");
      return;
    }
    if (!await confirm(
      "Save stock?",
      "Are you sure you want to save the stock?",
    )) return;
    if (saving) return;
    saving = true;
    var currentLocation = await locationManager.currentLocation();
    await inventoryManager.saveStock(
      stock: Stock(
        entryType: mode,
        synced: false,
        totalCost: stockListTotal().toString(),
        supplierId: stockpoint.id,
        salerId: authManager.user.id,
        comment: commentCtrl.text,
        paymentMethod: paymentMethod,
        reference: referenceCtrl.text,
        entryTime:
            "${DateTime.now().toLocal().toIso8601String().split(".")[0]}",
        latitude: "${currentLocation.latitude}",
        longitude: "${currentLocation.longitude}",
        photo: image?.path,
      ),
      stockItems: stockList,
    );
    pop();
  }

  void onInventorySaved(response) {
    if (response.data["status"] == 1) {
      progressDialog.hide();
      saving = false;
      alert("Success", "${response.data["message"]}", onOk: () {
        pop();
      });
    } else {
      saving = false;
      progressDialog.hide();
      alert("Failed",
          "${response.data["message"] ?? "Failed to add the records. Please try again."}");
    }
  }

  List buildStockItems() {
    return stockList.map((stockItem) {
      return {
        "product_id": stockItem.productId,
        "quantity": (stockItem.unit == "ctns")
            ? stockItem.quantity * stockItem.crtQnty
            : stockItem.quantity,
        "buying_price": stockItem.price,
        "batchnumber": stockItem.batchnumber,
        "totalcost": (stockItem.unit == "ctns")
            ? stockItem.price * (stockItem.quantity * stockItem.crtQnty)
            : stockItem.price * stockItem.quantity,
        "store_id": stockpoint.id,
      };
    }).toList();
  }

  void onDeleteItem(index) async {
    bool dismiss = await confirm(
        "Delete product", "Confirm you want to delete the product");
    if (dismiss) {
      stockList.removeAt(index);
      notifyChanges();
    }
  }

  void takePhoto() async {
    var pickedImage = await ImagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = await compressImageFile(pickedImage);
      notifyChanges();
    }
  }

  Future<bool> validStockpointLevel() async {
    if (!roleManager.hasRole(Roles.VIRTUAL_WITH_STOCKPOINT)) return true;
    var stockPointLevel =
        inventoryManager.stockPointStockLevel(product.productId);

    var quantityInList = stockList
        .where((item) => item.productId == product.productId)
        .map<int>((item) => (item.unit == "ctns")
            ? (item.quantity * product.crtQnty)
            : item.quantity)
        .fold(
          0,
          (prev, curr) => prev + curr,
        );
    var additionalQuantity = (packagingOption.packageKey == "ctns")
        ? int.parse("${quantityCtrl.text}") * product.crtQnty
        : int.parse("${quantityCtrl.text}");
    print("Total is $additionalQuantity");
    debugPrint("Has product, L:$stockPointLevel , Q: $additionalQuantity");
    if ((additionalQuantity + quantityInList) > stockPointLevel) {
      alert(
        "Insufficient stock",
        "There are ${stockPointLevel - quantityInList} pcs of ${product.productDesc} left at the stockpoint",
        //"You are trying to add ${int.parse("${quantityCtrl.text}")} ${unit.alias} of  to the $quantity pcs already in the list  while there are $level pcs left in stock",
      );
      return false;
    }
    return true;
  }

  void addOrUpdateProduct() async {
    if (validateFields()) {
      if (!await validStockpointLevel()) return;
      if (hasProduct(product)) {
        int index = productIndex(product);
        stockList[index].quantity += int.parse("${quantityCtrl.text}");
        quantityCtrl.clear();
      } else {
        stockList.add(
          StockItem(
            productId: product.productId,
            productName: product.productName,
            productDesc: product.productDesc,
            unit: packagingOption.packageKey,
            quantity: int.parse("${quantityCtrl.text}"),
            price: double.parse("${priceCtrl.text}"),
            batchnumber: batchnumberCtrl.text,
            crtQnty: product.crtQnty,
          ),
        );
        quantityCtrl.clear();
      }
    }
    notifyChanges();
  }

  bool hasProduct(Product product) {
    return productIndex(product) == -1 ? false : true;
  }

  int productIndex(Product product) {
    return stockList.indexWhere(
      (stockItem) =>
          stockItem.productId == product.productId &&
          stockItem.unit == packagingOption.packageKey &&
          stockItem.batchnumber == batchnumberCtrl.text,
    );
  }

  stockListTotal() {
    var total = stockList.fold(0, (a, b) => a + (b.quantity * b.price));
    return double.parse("${total ?? 0}").toStringAsFixed(2);
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
    stockList.removeAt(index);
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
                    if (roleManager.hasRole(Roles.VIRTUAL_WITH_STOCKPOINT))
                      Container(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                            "${inventoryManager.stockPointStockLevel(product.productId)}"),
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
    var category = await navigate(
      screen: SearchScreen(
          title: "Select category",
          items: (roleManager.hasRole(Roles.VIRTUAL_WITH_STOCKPOINT))
              ? inventoryManager.stockPointStockCategories(stockpoint?.id ?? 0)
              : commonsManager.productCategories,
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

  String get addButtonText => isUpdate ? "UPDATE" : "ADD TO LIST";

  bool validateFields() {
    if (stockpoint == null) {
      alert("Select a stockpoint", "Please select a stockpoint to continue");
      return false;
    }

    if (productCategory == null) {
      alert("Select product category",
          "Please select a product category to continue");
      return false;
    }

    if (product == null) {
      alert("Select a product", "Please select a product to continue");
      return false;
    }

    if (quantityCtrl.text.trim() == "" ||
        int.parse("${quantityCtrl.text.trim() ?? 0}") == 0) {
      alert("Quantity", "Please check your quantity");
      return false;
    }
    if (packagingOption == null) {
      alert("Select packaging", "Please a unit of packaging");
      return false;
    }

    if (priceCtrl.text.trim() == "" ||
        double.parse("${priceCtrl.text.trim() ?? 0}") == 0) {
      alert("Buying price", "Please check your buying price");
      return false;
    }
    return true;
  }

  void clearFields() {
    product = null;
    quantityCtrl.clear();
    priceCtrl.clear();
  }

  void setSellingPrice() {
    if (packagingOption.packageKey == "pcs" && product != null) {
      priceCtrl.text = "${product.pricePkts ?? 0}";
    } else if (packagingOption.packageKey == "ctns" && product != null) {
      priceCtrl.text = "${product.priceCrtns ?? 0}";
    } else {
      priceCtrl.text = "";
    }
  }

  void onCategoryChanged(value) {
    clearFields();
    productCategory = value;
    if (value != null) {
      product = null;
      if (roleManager.hasRole(Roles.VIRTUAL_WITH_STOCKPOINT)) {
        products = commonsManager.products
            .where((product) =>
                product.productCategory == value &&
                inventoryManager.stockPointStockLevel(product.productId) > 0)
            .toList();
      } else {
        products = commonsManager.products
            .where((product) => product.productCategory == value)
            .toList();
      }
    }
    notifyChanges();
  }

  void onProductChanged(value) {
    product = value;
    quantityCtrl.clear();
    setSellingPrice();
    notifyChanges();
  }

  void onPaymentMethodChanged(value) {
    paymentMethod = value;
    notifyChanges();
  }

  void preSelectDefaultMode() {
    if (!roleManager.hasRole(Roles.REQUISITION_STOCK)) {
      if (roleManager.hasRole(Roles.ALLOW_UPLIFTS)) {
        mode = "New Stock";
      } else if (roleManager.hasRole(Roles.RETURNS)) {
        mode = "Return Stock";
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (stockPointsManager.stockPoints.length > 0) {
      onStockpointChanged(stockPointsManager.stockPoints.first);
    }
    if (commonsManager.packagingOptions.length > 0) {
      onUnitChange(commonsManager.packagingOptions.first);
    }
    preSelectDefaultMode();
  }
}
