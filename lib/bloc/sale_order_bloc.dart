import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/packaging_option.dart';
import 'package:solutech_sat/data/models/virtual_stock.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/promotions_manager.dart';
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
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solutech_sat/ui/screen/inventory_screen.dart';
import 'package:solutech_sat/ui/screen/recent_activity_screen.dart';
import 'package:solutech_sat/ui/screen/search_screen.dart';
import 'package:solutech_sat/utils/format_utils.dart';
import 'package:solutech_sat/utils/image_utils.dart';

class SaleOrderBloc extends Bloc {
  RoutePlan routePlan;
  Customer customer;
  int currentScreen = 0;
  String mode = "Sale";
  String orderChannel = "Physical Visit";
  bool posterAvailable = false;
  bool duAvailable = false;
  DateTime nextPaymentDate;
  String batchNumber;
  DateTime deliveryDate;
  DateTime maturityDate;
  MpesaPayment mpesaPayment;
  bool showCreditNote = false;
  File image;
  List<List<int>> incentivesRecords = [];
  List<List<int>> promotionRecords = [];
  ScrollController scrollController = ScrollController();
  bool saving = false;
  TextEditingController totalPriceCtrl = TextEditingController(text: "0");
  TextEditingController nextPaymentDateCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController quantityCtrl = TextEditingController();
  TextEditingController notesCtrl = TextEditingController();
  TextEditingController creditNoteCtrl = TextEditingController(text: "0");
  TextEditingController referenceCtrl = TextEditingController();
  TextEditingController deliveryDateCtrl = TextEditingController();
  TextEditingController lpoNumberCtrl = TextEditingController();
  TextEditingController maturityDateCtrl = TextEditingController();

  SaleOrderBloc({this.routePlan, this.customer, this.mode});
  PaymentMode paymentMode;
  var productCategories = [];
  var productCategory;
  PackagingOption packagingOption;
  List<Product> products = [];
  Product product;
  VirtualStock virtualStock;
  List<OrderItem> orderList = [];

  void onModeChange(value) {
    mode = value;
    notifyChanges();
  }

  void onDuAvailabilityChange(bool value) {
    duAvailable = value;
    notifyChanges();
  }

  void toggleReference() {
    if (paymentsManager.mpesaPayments.length > 0) {
      mpesaPayment = null;
      paymentsManager.mpesaPayments = [];
      paymentsManager.notifyChanges();
    } else {
      mpesaPayment = null;
      paymentsManager.loadMpesaPayments();
    }
  }

  void onPosterAvailabilityChange(bool value) {
    posterAvailable = value;
    notifyChanges();
  }

  void toggleCreditNote() {
    showCreditNote = !showCreditNote;
    notifyChanges();
  }

  void onUnitChange(value) {
    packagingOption = value;
    setSellingPrice();
    notifyChanges();
  }

  Future<bool> onWillPop() async {
    if (orderList.length > 0)
      return confirm("Confirm exit", "Are you sure you want to exit?");
    else
      return true;
  }

  void pickDeliveryDate() async {
    deliveryDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(hours: 2)),
      lastDate: DateTime.now().add(
        Duration(days: 50),
      ),
    );
    if (deliveryDate != null) {
      deliveryDateCtrl.text = "${formatDate(deliveryDate, "MMM d, yyyy")}";
    }
  }

  void pickNextPaymentDate() async {
    nextPaymentDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(hours: 2)),
      lastDate: DateTime.now().add(
        Duration(days: 50),
      ),
    );
    if (nextPaymentDate != null) {
      nextPaymentDateCtrl.text =
          "${formatDate(nextPaymentDate, "MMM d, yyyy")}";
    }
  }

  void pickMaturityDate() async {
    maturityDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(hours: 2)),
      lastDate: DateTime.now().add(
        Duration(days: 50),
      ),
    );
    if (maturityDate != null) {
      maturityDateCtrl.text = "${formatDate(maturityDate, "MMM d, yyyy")}";
    }
  }

  void pickMpesaPayment() async {
    var mpesaPayment = await navigate(
      screen: SearchScreen(
        title: "Select payment",
        items: paymentsManager.mpesaPayments.toList(),
        onFilter: (MpesaPayment item, searchTerm) {
          return item.customername
              .toString()
              .trim()
              .toLowerCase()
              .contains(searchTerm);
        },
        builder: (MpesaPayment payment, index) {
          return Container(
            color: ((index + 1) % 2 == 0) ? Colors.white : Colors.grey[200],
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "${payment.transactionreference}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Text(
                      "${payment.amount}",
                    ),
                  ],
                ),
                Divider(
                  color: Colors.transparent,
                  height: 2.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "${payment.customername}",
                      ),
                    ),
                    Text(
                      "${timeago.format(payment.transactionTime)}",
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
    if (mpesaPayment != null) {
      onMpesaPaymentChanged(mpesaPayment);
    }
  }

  void onMpesaPaymentChanged(MpesaPayment payment) {
    mpesaPayment = payment;
    referenceCtrl.text = "${payment.transactionreference}";
    totalPriceCtrl.text = "${payment.amount}";
    notifyChanges();
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
    return orderList.length > 0;
  }

  void prevScreen(pos) {
    currentScreen = pos;
    notifyChanges();
  }

  void saveOrder() async {
    if (creditNoteCtrl.text.trim() == "") {
      creditNoteCtrl.text = "0";
    }
    if (referenceCtrl.text.trim() == "" &&
        paymentMode?.slug != "cash" &&
        paymentMode?.slug != "credit") {
      alert("Enter reference", "Payment reference is required");
      return;
    }

    if (paymentMode?.slug == "cheque" && image == null) {
      alert("Take cheque photo",
          "You have to take a photo of the cheque for confirmation.");
      return;
    }

    if (paymentMode?.slug == "cheque" && maturityDateCtrl.text.trim() == "") {
      alert("Enter maturity date",
          "You have to enter the maturity date of the cheque.");
      return;
    }

    if (totalPriceCtrl.text.trim() == "" ||
        (double.parse("${totalPriceCtrl.text}") == 0 &&
            paymentMode?.slug != "credit")) {
      alert("Enter amount paid",
          "You have to enter the amount this customer has paid.");
      return;
    }

    if ((double.parse(
                "${totalPriceCtrl.text.trim() != "" ? totalPriceCtrl.text : 0}") <
            double.parse("${stockListTotal()}")) &&
        nextPaymentDate == null) {
      alert("Enter next payment date",
          "You have to enter the next payment date if the amount paid is less.");
      return;
    }
    if (showCreditNote && double.parse("${creditNoteCtrl.text.trim()}") == 0) {
      alert("Enter credit note", "You have to enter the credit note.");
      return;
    }

    if (!await confirm(
      "Save $mode?",
      "This will save the $mode that you have made.",
    )) return;
    if (saving) return;
    saving = true;
    var currentLocation = await locationManager.currentLocation();
    var shouldShowRecent =
        recordsManager.ordersByShopId(customer.id).length == 0;
    recordsManager.saveOrder(
      order: Order(
        entryType: mode,
        synced: false,
        totalCost: double.parse("${stockListTotal()}"),
        sellingTotalCost: double.parse("${stockListTotal()}"),
        newShop: 0,
        lponumber: lpoNumberCtrl.text,
        callStatus: "successful",
        shopId: customer.id,
        paymentAmount: (paymentMode?.slug == "mpesa" && mpesaPayment != null)
            ? double.parse("${mpesaPayment?.amount ?? 0}")
            : double.parse(
                "${totalPriceCtrl.text.trim() != "" ? totalPriceCtrl.text : 0}"),
        paymentStatus: double.parse(
                    "${(paymentMode?.slug == "mpesa" && mpesaPayment != null) ? mpesaPayment.amount : double.parse(totalPriceCtrl.text)}") >=
                double.parse("${stockListTotal()}")
            ? "Fully paid"
            : "Not fully paid",
        salerId: authManager.user.id,
        paymentMethod: paymentMode?.slug,
        paymentReference: referenceCtrl.text,
        expectedDelivery: deliveryDate,
        notes: notesCtrl.text,
        orderTime: DateTime.now(),
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
        chequePhoto: image?.path ?? null,
        nextPayment: nextPaymentDate,
        channel: orderChannel,
        creditNote: creditNoteCtrl.text,
        maturityDate: maturityDate,
        paymentId: (paymentMode.slug == "mpesa") ? "${mpesaPayment?.id}" : null,
        lpoPhoto: image?.path ?? null,
        orderType: mode,
        fromServer: false,
      ),
      orderItems: orderList,
    );
    if (shouldShowRecent) {
      popAndNavigate(
        screen: RecentActivityScreen(
          customer: customer,
          routePlan: routePlan,
          mode: mode,
        ),
      );
    } else {
      pop();
    }
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

  void onDeleteItem(index) async {
    bool dismiss = await confirm(
        "Delete product", "Confirm you want to delete the product");
    if (dismiss) {
      orderList.removeAt(index);
      incentivesRecords.removeWhere((incentive) => incentive[0] == index);
      promotionRecords = [];
      notifyChanges();
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

  int availableInStock(VirtualStock stock) {
    var product = commonsManager.productById(stock.productId);
    var quantityInList = orderList
        .where((orderItem) =>
            orderItem.productId == product.productId &&
            orderItem.batchnumber == stock.batchnumber)
        .map<int>(
          (item) => (item.productPackaging == "ctns")
              ? (item.quantity * product.crtQnty)
              : item.quantity,
        )
        .fold(0, (prev, curr) => prev + curr);
    var virtualStockLevel = inventoryManager.virtualStockLevel(
        product.productId, stock.batchnumber);
    return virtualStockLevel - quantityInList;
  }

  Future<bool> validVirtualStockLevel() async {
    var virtualStockLevel = inventoryManager.virtualStockLevel(
        product.productId, virtualStock.batchnumber);
    var quantityInList = orderList
        .where((orderItem) =>
            orderItem.productId == product.productId &&
            orderItem.batchnumber == virtualStock.batchnumber)
        .map<int>(
          (item) => (item.productPackaging == "ctns")
              ? (item.quantity * product.crtQnty)
              : item.quantity,
        )
        .fold(0, (prev, curr) => prev + curr);

    var additionalQuantity = (packagingOption.packageKey == "ctns")
        ? int.parse("${quantityCtrl.text}") * product.crtQnty
        : int.parse("${quantityCtrl.text}");
    if ((quantityInList + additionalQuantity) > virtualStockLevel) {
      alert(
        "Insufficient stock",
        "You have ${virtualStockLevel - quantityInList} pcs of  ${product.productDesc} left in stock",
      );
      return false;
    }
    return true;
  }

  void addOrUpdateProduct() async {
    if (validateFields()) {
      if (mode == "Sale" && !await validVirtualStockLevel()) return;
      if (hasProductInList(product)) {
        int index = productIndex(product);
        orderList[index].quantity += int.parse("${quantityCtrl.text}");
        var orderIndex = index;
        if (roleManager.hasRole(Roles.INITIATIVES) &&
            product != null &&
            mode == "Sale" &&
            promotionsManager.promotionFor(product.productId) != null &&
            quantityCtrl.text != "" &&
            int.parse("${quantityCtrl.text}") >=
                promotionsManager
                    .promotionFor(product.productId)
                    ?.qualifyQuantity &&
            ((int.parse("${quantityCtrl.text}") ~/
                        promotionsManager
                            .promotionFor(product.productId)
                            ?.qualifyQuantity) *
                    promotionsManager
                        .promotionFor(product.productId)
                        ?.freeQuantity) >
                0) {
          incentivesRecords.add([
            orderIndex,
            null,
            (int.parse("${quantityCtrl.text}") ~/
                    promotionsManager
                        .promotionFor(product.productId)
                        ?.qualifyQuantity) *
                promotionsManager.promotionFor(product.productId)?.freeQuantity
          ]);
        } else {
          print("PromoV $promotionRecords");
          if (roleManager.hasRole(Roles.INITIATIVES) &&
              product != null &&
              mode == "Sale" &&
              promotionsManager.promotionFor(product.productId) != null &&
              quantityCtrl.text != "") {
            if (promotionRecords.firstWhere(
                    (promotion) =>
                        promotion[0] ==
                        promotionsManager.promotionFor(product.productId).id,
                    orElse: () => null) !=
                null) {
              var index = promotionRecords.indexWhere((promotion) =>
                  promotion[0] ==
                  promotionsManager.promotionFor(product.productId).id);
              promotionRecords[index][1] += int.parse("${quantityCtrl.text}");
            } else {
              promotionRecords.add([
                promotionsManager.promotionFor(product.productId).id,
                int.parse("${quantityCtrl.text}")
              ]);
            }

            print("PromoX $promotionRecords");

            var promo = promotionRecords.firstWhere(
                (promotion) =>
                    promotion[1] >=
                    promotionsManager
                        .promotionById(promotion[0])
                        .qualifyQuantity,
                orElse: () => null);
            if (promo != null) {
              incentivesRecords.add([
                orderIndex,
                null,
                (promo[1] ~/
                        promotionsManager
                            .promotionById(promo[0])
                            .qualifyQuantity) *
                    promotionsManager.promotionById(promo[0]).freeQuantity
              ]);
            }
          }
        }
        product = null;
        quantityCtrl.clear();
        FocusScope.of(context).requestFocus(new FocusNode());
        scrollController.animateTo(
          0.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      } else {
        orderList.add(
          OrderItem(
            productId: product.productId,
            productPackaging: packagingOption.packageKey,
            quantity: int.parse("${quantityCtrl.text}"),
            sellingPrice: "${priceCtrl.text}",
            cartonQuantity: product.crtQnty,
            batchnumber: (mode == "Sale") ? virtualStock?.batchnumber : null,
          ),
        );
        var orderIndex = orderList.length - 1;
        if (roleManager.hasRole(Roles.INITIATIVES) &&
            product != null &&
            mode == "Sale" &&
            promotionsManager.promotionFor(product.productId) != null &&
            quantityCtrl.text != "" &&
            int.parse("${quantityCtrl.text}") >=
                promotionsManager
                    .promotionFor(product.productId)
                    ?.qualifyQuantity &&
            ((int.parse("${quantityCtrl.text}") ~/
                        promotionsManager
                            .promotionFor(product.productId)
                            ?.qualifyQuantity) *
                    promotionsManager
                        .promotionFor(product.productId)
                        ?.freeQuantity) >
                0) {
          incentivesRecords.add([
            orderIndex,
            null,
            (int.parse("${quantityCtrl.text}") ~/
                    promotionsManager
                        .promotionFor(product.productId)
                        ?.qualifyQuantity) *
                promotionsManager.promotionFor(product.productId)?.freeQuantity
          ]);
        } else {
          print("PromoV $promotionRecords");
          if (roleManager.hasRole(Roles.INITIATIVES) &&
              product != null &&
              mode == "Sale" &&
              promotionsManager.promotionFor(product.productId) != null &&
              quantityCtrl.text != "") {
            if (promotionRecords.firstWhere(
                    (promotion) =>
                        promotion[0] ==
                        promotionsManager.promotionFor(product.productId).id,
                    orElse: () => null) !=
                null) {
              var index = promotionRecords.indexWhere((promotion) =>
                  promotion[0] ==
                  promotionsManager.promotionFor(product.productId).id);
              promotionRecords[index][1] += int.parse("${quantityCtrl.text}");
            } else {
              promotionRecords.add([
                promotionsManager.promotionFor(product.productId).id,
                int.parse("${quantityCtrl.text}")
              ]);
            }

            print("PromoX $promotionRecords");

            var promo = promotionRecords.firstWhere(
                (promotion) =>
                    promotion[1] >=
                    promotionsManager
                        .promotionById(promotion[0])
                        .qualifyQuantity,
                orElse: () => null);
            if (promo != null) {
              incentivesRecords.add([
                orderIndex,
                null,
                (promo[1] ~/
                        promotionsManager
                            .promotionById(promo[0])
                            .qualifyQuantity) *
                    promotionsManager.promotionById(promo[0]).freeQuantity
              ]);
            }
          }
        }
      }
      product = null;
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

  void addIncentive() async {
    if (validateFields()) {
      if (mode == "Sale" && !await validVirtualStockLevel()) return;
      if (currentIncentive() != null) {
        if (int.parse("${quantityCtrl.text}") > currentIncentive()[2]) {
          alert("Excess incentive",
              "You cannnot add execess incentive. You can only add ${currentIncentive().last} extra");
          return;
        }
        if (!promotionsManager
            .freeInitiativesFor(promotionsManager
                .promotionFor(orderList[currentIncentive()[0]].productId)
                .id)
            .map((freeItem) => freeItem.freeProduct)
            .toList()
            .contains(product?.productId)) {
          alert("Select the correct product",
              "You are supposed to select ${promotionsManager.freeInitiativesFor(promotionsManager.promotionFor(orderList[currentIncentive()[0]].productId)?.id).map((freeItem) => commonsManager.productById(freeItem.freeProduct)?.productDesc).join(" or ")}");
          return;
        }
        int currentIndex = currentIncentiveIndex;
        orderList.add(
          OrderItem(
            productId: product.productId,
            productPackaging: packagingOption.packageKey,
            quantity: int.parse("${quantityCtrl.text}"),
            sellingPrice: "0",
            cartonQuantity: product.crtQnty,
            batchnumber: (mode == "Sale") ? virtualStock?.batchnumber : null,
          ),
        );
        //incentivesRecords[currentIndex][1] = orderList.length - 1;
        incentivesRecords[currentIncentiveIndex][2] =
            currentIncentive()[2] - int.parse("${quantityCtrl.text}");

        product = null;
        quantityCtrl.clear();
      }
    }
    notifyChanges();
  }

  bool hasProductInList(Product product) {
    return productIndex(product) == -1 ? false : true;
  }

  int productIndex(Product product) {
    return orderList.indexWhere(
      (stockItem) =>
          stockItem.productId == product.productId &&
          stockItem.productPackaging == packagingOption.packageKey &&
          stockItem.batchnumber == virtualStock.batchnumber,
    );
  }

  String stockListTotal() {
    var total = orderList.fold(
        0, (a, b) => a + (b.quantity * double.parse("${b.sellingPrice}")));
    return double.parse("${total ?? 0}").round().toString();
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
    orderList.removeAt(index);
    notifyChanges();
  }

  void selectProductInStock() async {
    var virtualStock = await navigate(
        screen: SearchScreen(
            title: "Select product",
            items: inventoryManager.virtualStock
                .where((stock) =>
                    commonsManager
                        .productById(stock.productId)
                        .productCategory ==
                    productCategory)
                .toList(),
            onFilter: (VirtualStock item, searchTerm) {
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("${product.productDesc}"),
                          if (product.batchnumber != "" &&
                              product.batchnumber != null)
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "Batch:",
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(text: " "),
                                TextSpan(
                                  text: "${product.batchnumber}",
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                  ),
                                ),
                              ]),
                            ),
                        ],
                      ),
                    ),
                    if (mode == "Sale")
                      Container(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "${availableInStock(product)}",
                        ),
                      ),
                  ],
                ),
              );
            }));
    if (virtualStock != null) {
      this.virtualStock = virtualStock;
      notifyChanges();
      var product = commonsManager.productById(virtualStock.productId);
      if (product != null) {
        onProductChanged(product);
      }
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
                    if (mode == "Sale")
                      Container(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "${availableInStock(product)}",
                        ),
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
          items: ((mode == "Sale")
              ? inventoryManager.virtualStockCategories
              : commonsManager.productCategories),
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

  String get addButtonText =>
      currentIncentive() != null ? "ADD INCENTIVE" : "ADD TO LIST";

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

    if (quantityCtrl.text.trim() == "" ||
        int.parse("${quantityCtrl.text.trim() ?? 0}") == 0 && mode == "Sale") {
      alert("Quantity", "Please check your quantity");
      return false;
    }

    if (mode == "Order" && deliveryDateCtrl.text.trim() == "") {
      alert("Select order date",
          "Please select a date for delivery of the order");
      return false;
    }

    if (packagingOption == null) {
      alert("Select packaging", "Please a unit of packaging");
      return false;
    }

    if (priceCtrl.text.trim() == "" ||
        double.parse("${priceCtrl.text.trim() ?? 0}") == 0) {
      alert("Selling price", "Please check your selling price");
      return false;
    }
    return true;
  }

  void clearFields() {
    product = null;
    quantityCtrl.clear();
    priceCtrl.clear();
  }

  List<int> currentIncentive() {
    return incentivesRecords.firstWhere(
      (incentiveRecord) => incentiveRecord.last > 0,
      orElse: () => null,
    );
  }

  int get currentIncentiveIndex =>
      incentivesRecords.indexOf(currentIncentive());

  void setSellingPrice() {
    var groupPriceList =
        priceListsManager.priceListForCustomer(customer.id, product?.productId);
    if (groupPriceList != null &&
        !roleManager.hasRole(Roles.USE_DEFAULT_PRICE_LIST)) {
      if (packagingOption.packageKey == "pcs" && product != null) {
        priceCtrl.text = "${groupPriceList.pricePkts ?? 0}";
      } else if (packagingOption.packageKey == "ctns" && product != null) {
        priceCtrl.text = "${groupPriceList.priceCrtns ?? 0}";
      } else {
        priceCtrl.text = "";
      }
    } else {
      if (packagingOption.packageKey == "pcs" && product != null) {
        priceCtrl.text = "${product.pricePkts ?? 0}";
      } else if (packagingOption.packageKey == "ctns" && product != null) {
        priceCtrl.text = "${product.priceCrtns ?? 0}";
      } else {
        priceCtrl.text = "";
      }
    }
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

  void onChannelChanged(value) {
    orderChannel = value;
    notifyChanges();
  }

  void onProductChanged(value) {
    product = value;
    quantityCtrl.clear();
    setSellingPrice();
    notifyChanges();
  }

  void onPaymentModeChanged(value) {
    paymentMode = value;
    if (paymentMode.slug == "mpesa") {
      paymentsManager.loadMpesaPayments();
    } else if (paymentMode.slug == "credit") {
      mpesaPayment = null;
      totalPriceCtrl.text = "0";
    } else {
      mpesaPayment = null;
      totalPriceCtrl.text = "";
    }
    notifyChanges();
  }

  void loadPayments() {
    if (connectionManager.isConnected) {
      mpesaPayment = null;
      paymentsManager.loadMpesaPayments();
    } else {
      alert(
        "No internet",
        "Make sure you are connected to the internet to continue",
      );
    }
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
    if (!sessionManager.inSession) {
      orderChannel = "Call";
    }
    totalPriceCtrl.addListener(() {
      notifyChanges();
    });
    quantityCtrl.addListener(() {
      notifyChanges();
    });
  }
}
