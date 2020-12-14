import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/collection_item.dart';
import 'package:solutech_sat/data/models/customer_balance.dart';
import 'package:solutech_sat/data/models/packaging_option.dart';
import 'package:solutech_sat/data/models/payment_collection.dart';
import 'package:solutech_sat/utils/device_utils.dart';
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

class CollectPaymentBloc extends Bloc {
  Customer customer;
  int currentScreen = 0;
  String orderChannel = "Physical Visit";
  bool posterAvailable = false;
  bool duAvailable = false;
  DateTime nextPaymentDate;
  DateTime deliveryDate;
  DateTime maturityDate;
  MpesaPayment mpesaPayment;
  File image;
  ScrollController scrollController = ScrollController();
  TextEditingController nextPaymentDateCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController notesCtrl = TextEditingController();
  TextEditingController referenceCtrl = TextEditingController();
  TextEditingController deliveryDateCtrl = TextEditingController();
  TextEditingController maturityDateCtrl = TextEditingController();

  CollectPaymentBloc({
    this.customer,
  });
  PaymentMode paymentMode;
  var productCategories = [];
  var productCategory;
  List<PackagingOption> units = [
    PackagingOption(
      packageName: "Pieces",
      packageKey: "pcs",
    ),
    if (roleManager.hasRole(Roles.ALLOW_CARTONS))
      PackagingOption(
        packageName: "Cartons",
        packageKey: "ctns",
      ),
  ];
  PackagingOption unit;
  List<Product> products = [];
  Product product;
  List<OrderItem> orderList = [];

  void onDuAvailabilityChange(bool value) {
    duAvailable = value;
    notifyChanges();
  }

  void onPosterAvailabilityChange(bool value) {
    posterAvailable = value;
    notifyChanges();
  }

  void onUnitChange(value) {
    unit = value;
    setSellingPrice();
    notifyChanges();
  }

  Future<bool> onWillPop() async {
    if (orderList.length > 0)
      return confirm("Confirm exit", "Are you sure you want to exit?");
    else
      return true;
  }

  void nextScreen(position) {
    if (position == 1) {
      if (canProceed) {
        calculateTotals();
        currentScreen = position;
        notifyChanges();
      } else {
        alert("Enter amounts",
            "You can't proceed without entering the collected amount");
      }
    }
  }

  void prevScreen(position) {
    if (position == 0) {
      currentScreen = position;
      notifyChanges();
    }
  }

  void calculateTotals() {
    double totalFacings = 0;
    /*audits.forEach((item) {
      totalFacings += int.parse(
          "${item[0].text.toString().trim() != "" ? item[0].text : 0}");
      totalLength += int.parse(
          "${item[1].text.toString().trim() != "" ? item[1].text : 0}");
    });
    totalFacingsCtrl.text = "$totalFacings";*/
    notifyChanges();
  }

  List<TextEditingController> amountControllers = [];

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

  List<CollectionItem> _collectionItems() {
    /*double totalAmount = double.parse("${totalPriceCtrl.text ?? 0}");
    List<CollectionItem> collectionItems = [];
    List<CustomerBalance> customerBalances = paymentsManager.customerBalances
        .where((customerBalance) => (paymentsManager
                .getCustomerBalancesFor(customerBalance.shopId)
                .fold<double>(
                    0.0,
                    (a, b) =>
                        a +
                        (double.parse("${b.amount ?? 0}") -
                            double.parse("${b.amountpaid ?? 0}"))) >
            0))
        .toList();
    for (var item in customerBalances) {
      double balance = (double.parse("${item.amount ?? 0}") -
          double.parse("${item.amountpaid ?? 0}"));
      if (totalAmount == 0) {
        break;
      } else if (totalAmount > balance) {
        collectionItems.add(CollectionItem(
          amount: balance,
          invoiceId: item.orderId,
          collectionId: item.id,
        ));
        totalAmount -= balance;
      } else {
        collectionItems.add(CollectionItem(
          amount: totalAmount,
          invoiceId: item.orderId,
          collectionId: item.id,
        ));
        totalAmount -= totalAmount;
        break;
      }
    }*/
    List<CollectionItem> collectionItems = [];
    amountControllers.asMap().forEach((index, controller) {
      if (controller.text != "" && double.parse("${controller.text}") > 0) {
        var customerBalance =
            paymentsManager.getCustomerBalancesFor(customer.id)[index];
        collectionItems.add(CollectionItem(
          amount: double.parse("${controller.text}"),
          invoiceId: customerBalance.orderId,
          collectionId: customerBalance.id,
        ));
      }
    });
    return collectionItems;
  }

  bool get canProceed =>
      amountControllers.firstWhere(
          (controller) =>
              controller.text != "" && double.parse("${controller.text}") > 0,
          orElse: () => null) !=
      null;

  void savePayment() async {
    if (referenceCtrl.text.trim() == "" && paymentMode?.slug != "cash") {
      alert("Enter reference", "Payment reference is required");
      return;
    }

    if (paymentMode?.slug == "cheque" && image == null) {
      alert("Take cheque photo",
          "You have to take a photo of the cheque for confirmation.");
      return;
    }

    if ((double.parse("${collectedAmountTotal()}") <
            double.parse("${balanceTotal()}")) &&
        nextPaymentDate == null) {
      alert("Enter next payment date",
          "You have to enter the next payment date if the amount paid is less.");
      return;
    }

    if (double.parse("${collectedAmountTotal()}") >
        paymentsManager.getCustomerBalancesFor(customer.id).fold<double>(
            0.0,
            (a, b) =>
                a +
                (double.parse("${b.amount ?? 0}") -
                    double.parse("${b.amountpaid ?? 0}")))) {
      alert(
        "Collection is more than balance",
        "You cannot collect an amount that is more than the balance.",
      );
      return;
    }

    if (!await confirm(
      "Save payment collection?",
      "This will save the payment collection that you have made.",
    )) return;
    var currentLocation = await locationManager.currentLocation();
    await paymentsManager.savePaymentCollection(
      paymentCollection: PaymentCollection(
        synced: false,
        battery: "${await battery.batteryLevel}",
        appVersion: config.appVersion,
        shopId: customer.id,
        paymentAmount: (paymentMode?.slug == "mpesa" && mpesaPayment != null)
            ? double.parse("${mpesaPayment?.amount ?? 0}")
            : double.parse("${collectedAmountTotal()}"),
        paymentStatus: double.parse(
                    "${(paymentMode?.slug == "mpesa" && mpesaPayment != null) ? mpesaPayment.amount : double.parse("${collectedAmountTotal()}")}") >=
                double.parse("${balanceTotal()}")
            ? "Fully paid"
            : "Not fully paid",
        salerId: authManager.user.id,
        paymentMethod: paymentMode?.slug,
        paymentReference: referenceCtrl.text,
        notes: notesCtrl.text,
        paymentTime: DateTime.now(),
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
        nextPayment: nextPaymentDate,
        maturityDate: maturityDate,
        paymentId: (paymentMode.slug == "mpesa") ? "${mpesaPayment?.id}" : null,
        chequePhoto: image?.path ?? null,
        fromServer: false,
      ),
      collectionItems: _collectionItems(),
    );
    alert("Successful", "Saved collection payment.", onOk: () {
      pop();
    });
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
                      "${authManager.user.country?.currencyCode} ${payment.amount}",
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
    notifyChanges();
  }

  bool listHasItems() {
    return orderList.length > 0;
  }

  Future<bool> onItemSwiped(DismissDirection direction) async {
    bool dismiss = false;
    if (direction == DismissDirection.startToEnd) {
    } else {
      dismiss = await confirm(
          "Delete product", "Confirm you want to delete the product");
    }
    return dismiss;
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

  void addOrUpdateProduct() async {
    notifyChanges();
  }

  bool hasProductInList(Product product) {
    return productIndex(product) == -1 ? false : true;
  }

  int productIndex(Product product) {
    return orderList.indexWhere(
      (stockItem) =>
          stockItem.productId == product.productId &&
          stockItem.productPackaging == unit.packageKey,
    );
  }

  String balanceTotal() {
    return paymentsManager
        .getCustomerBalancesFor(customer.id)
        .fold<double>(
            0.0,
            (a, b) =>
                a +
                (double.parse("${b.amount ?? 0}") -
                    double.parse("${b.amountpaid ?? 0}")))
        .toStringAsFixed(2);
  }

  String collectedAmountTotal() {
    return amountControllers
        .where((controller) =>
            (controller.text != "" && double.parse("${controller.text}") > 0))
        .fold<double>(0.0, (a, b) => a + double.parse("${b.text ?? 0}"))
        .toStringAsFixed(2);
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

  void clearFields() {
    product = null;
    priceCtrl.clear();
  }

  void setSellingPrice() {
    var groupPriceList =
        priceListsManager.priceListForCustomer(customer.id, product?.productId);
    if (groupPriceList != null &&
        !roleManager.hasRole(Roles.USE_DEFAULT_PRICE_LIST)) {
      if (unit.packageKey == "pcs" && product != null) {
        priceCtrl.text = "${groupPriceList.pricePkts ?? 0}";
      } else if (unit.packageKey == "ctns" && product != null) {
        priceCtrl.text = "${groupPriceList.priceCrtns ?? 0}";
      } else {
        priceCtrl.text = "";
      }
    } else {
      if (unit.packageKey == "pcs" && product != null) {
        priceCtrl.text = "${product.pricePkts ?? 0}";
      } else if (unit.packageKey == "ctns" && product != null) {
        priceCtrl.text = "${product.priceCrtns ?? 0}";
      } else {
        priceCtrl.text = "";
      }
    }
  }

  void onChannelChanged(value) {
    orderChannel = value;
    notifyChanges();
  }

  void onPaymentModeChanged(value) {
    paymentMode = value;
    if (paymentMode.slug == "mpesa") {
      paymentsManager.loadMpesaPayments();
    } else {
      mpesaPayment = null;
      paymentsManager.mpesaPayments = [];
      paymentsManager.notifyChanges();
    }
    notifyChanges();
  }

  void loadPayments() {
    mpesaPayment = null;
    paymentsManager.loadMpesaPayments();
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

  @override
  void initState() {
    super.initState();
    amountControllers = paymentsManager
        .getCustomerBalancesFor(customer.id)
        .map((customerBalance) => TextEditingController(
              text: "0",
            ))
        .toList();
    paymentMode = commonsManager.paymentModes.firstWhere(
        (paymentMode) => paymentMode.slug == "cash",
        orElse: () => null);
    onUnitChange(units.first);
    if (!sessionManager.inSession) {
      orderChannel = "Call";
    }
  }
}
