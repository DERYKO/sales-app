import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/collection_item.dart';
import 'package:solutech_sat/data/models/commons.dart';
import 'package:solutech_sat/data/models/customer_balance.dart';
import 'package:solutech_sat/data/models/date_week.dart';
import 'package:solutech_sat/data/models/mpesa_payment.dart';
import 'package:solutech_sat/data/models/order_item.dart';
import 'package:solutech_sat/data/models/payment.dart';
import 'package:solutech_sat/data/models/payment_collection.dart';
import 'package:solutech_sat/data/models/payment_document.dart';
import 'package:solutech_sat/data/models/payment_mode.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/shop_category.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/manager.dart';
import 'package:solutech_sat/utils/format_utils.dart';
import 'package:solutech_sat/utils/image_utils.dart';

class PaymentsManager extends Manager {
  static PaymentsManager instance;
  factory PaymentsManager() => instance ??= PaymentsManager._instance();
  PaymentsManager._instance();
  List<Payment> payments = [];
  List<PaymentDocument> paymentDocuments = [];
  List<MpesaPayment> mpesaPayments = [];
  List<CustomerBalance> customerBalances = [];
  List<PaymentCollection> paymentCollections = [];
  List<CollectionItem> collectionItems = [];
  bool _loadingMpesaPayments = false;
  bool _loadingCustomerBalances = false;
  bool _loadingPayments = false;

  set loadingPayments(bool show) {
    _loadingPayments = show;
    notifyChanges();
  }

  set loadingMpesaPayments(bool loading) {
    _loadingMpesaPayments = loading;
    notifyChanges();
  }

  set loadingCustomerBalances(bool loading) {
    _loadingCustomerBalances = loading;
    notifyChanges();
  }

  bool get loadingPayments => _loadingPayments;

  get loadingMpesaPayments => _loadingMpesaPayments;

  get loadingCustomerBalances => _loadingCustomerBalances;

  Future loadMpesaPayments() {
    loadingMpesaPayments = true;
    return api.getMpesaPayments().then((response) async {
      if (response.data["status"] == 1) {
        loadingMpesaPayments = false;
        var payload = response.data["payload"];
        await _saveMpesaPaymentsLocally(payload);
        return response;
      } else {
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future loadPayments([List<DateTime> pickedDates]) {
    loadingPayments = true;
    var filterDates = filterDatesFrom(pickedDates);
    return api.getPayments(filterDates).then((response) async {
      if (response.data["status"] == 1) {
        loadingPayments = false;
        var payload = response.data["payload"];
        await _savePaymentsLocally(payload);
        return response;
      } else {
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future saveCustomerBalance(CustomerBalance customerBalance) async {
    await db.customerBalanceBean.insert(
      customerBalance,
    );
    print("Payment balance inserted");
    await getDBData();
  }

  List<int> get customerIdsFromBalances => Set<int>.from(customerBalances
          .where((customerBalance) =>
              (getCustomerBalancesFor(customerBalance.shopId).fold<double>(
                      0.0,
                      (a, b) =>
                          a +
                          (double.parse("${b.amount ?? 0}") -
                              double.parse("${b.amountpaid ?? 0}"))) >
                  0))
          .map<int>((customerBalance) => customerBalance.shopId)
          .toList())
      .toList();

  List<CustomerBalance> getCustomerBalancesFor(customerId) {
    return customerBalances
        .where((customerBalance) =>
            customerBalance.shopId == customerId /*&& !customerBalance.synced*/)
        .toList();
  }

  double getBalanceFor(customerId) {
    return double.parse(
        "${customerBalances.where((customerBalance) => customerBalance.shopId == customerId).toList().fold(0.0, (a, b) => a + (double.parse("${b.amount ?? 0}") - double.parse("${b.amountpaid ?? 0}"))).toStringAsFixed(2)}");
  }

  Future loadCustomerBalances() {
    loadingCustomerBalances = true;
    return api.getCustomerBalances().then((response) async {
      if (response.data["status"] == 1) {
        loadingCustomerBalances = false;
        var payload = response.data["payload"];
        await _saveCustomerBalancesLocally(payload);
        return response;
      } else {
        loadingCustomerBalances = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future _saveMpesaPaymentsLocally(payload) async {
    mpesaPayments = [];
    for (var item in payload) {
      mpesaPayments.add(MpesaPayment.fromMap(item));
    }
  }

  Future _savePaymentsLocally(payload) async {
    await db.paymentBean.removeAll();
    await db.paymentDocumentBean.removeAll();
    for (var item in payload) {
      await db.paymentBean.insert(Payment.fromMap(item));
      for (var temp in item["documents"]) {
        await db.paymentDocumentBean.insert(PaymentDocument.fromMap(temp));
      }
    }
    await getDBData();
  }

  Future _saveCustomerBalancesLocally(payload) async {
    await db.customerBalanceBean.removeAll();
    for (var item in payload) {
      await db.customerBalanceBean
          .insert(CustomerBalance.fromMap(item)..synced = false);
    }
    await getDBData();
  }

  Future getDBData() async {
    customerBalances = await db.customerBalanceBean.getAll();
    paymentCollections = await db.paymentCollectionBean.getAll();
    collectionItems = await db.collectionItemBean.getAll();
    payments = await db.paymentBean.getAll();
    paymentDocuments = await db.paymentDocumentBean.getAll();
    notifyChanges();
  }

  Future savePaymentCollection(
      {PaymentCollection paymentCollection,
      List<CollectionItem> collectionItems}) async {
    int result = await db.paymentCollectionBean.insert(
      paymentCollection
        ..synced = false
        ..fromServer = false,
    );
    for (var item in collectionItems) {
      await db.collectionItemBean.insert(item..collectionId = result);
      var customerBalance = customerBalances.firstWhere(
          (customerBalance) => customerBalance.orderId == item.invoiceId,
          orElse: () => null);
      if (customerBalance != null) {
        await db.customerBalanceBean.upsert(
          customerBalance
            ..amountpaid =
                "${double.parse("${customerBalance.amountpaid ?? 0}") + item.amount}",
        );
      }
    }

    await getDBData();
    syncManager.sync();
  }

  List<Map<String, dynamic>> _buildCollectionItems(int paymentCollectionId) {
    return collectionItems
        .where((collectionItem) =>
            collectionItem.collectionId == paymentCollectionId)
        .map((item) => {"invoice_id": item.invoiceId, "amount": item.amount})
        .toList();
  }

  Future syncPaymentCollection() async {
    List<PaymentCollection> unsyncedPaymentCollections = paymentCollections
        .where((PaymentCollection paymentCollection) =>
            paymentCollection.synced == false)
        .toList();
    for (PaymentCollection paymentCollection in unsyncedPaymentCollections) {
      if (routePlansManager.getCustomerById(paymentCollection.shopId).synced) {
        try {
          var response = await api.savePaymentCollection({
            "shop_id": paymentCollection.shopId,
            "saler_id": paymentCollection.salerId,
            "payment_amount": paymentCollection.paymentAmount,
            "App_Version": paymentCollection.appVersion,
            "Battery": paymentCollection.battery,
            "payment_method": paymentCollection.paymentMethod,
            "payment_status": paymentCollection.paymentStatus,
            "payment_id": paymentCollection.paymentId,
            "payment_reference": paymentCollection.paymentReference,
            "notes": paymentCollection.notes,
            "maturity_date":
                formatDate(paymentCollection.maturityDate?.toString(), "xt"),
            "next_payment":
                formatDate(paymentCollection.nextPayment?.toString(), "xt"),
            "payment_time": formatDate(
                paymentCollection.paymentTime?.toIso8601String(), "xt"),
            "latitude": paymentCollection.latitude,
            "longitude": paymentCollection.longitude,
            "items": json.encode(_buildCollectionItems(paymentCollection.id)),
            "cheque_photo": (paymentCollection.chequePhoto != null &&
                    paymentCollection.chequePhoto.trim() != "")
                ? await base64FromFile(File(paymentCollection.chequePhoto))
                : null,
          });

          if (response.data["status"] == 1) {
            _onPaymentCollectionResponse(response.data, paymentCollection);
          } else {
            throw DioError(
              response: response,
            );
          }
        } catch (error) {
          _onSyncError(error);
        }
      }
    }
  }

  bool hasTodaysRecord(
    int customerId,
  ) {
    var now = DateTime.now();
    return paymentCollections
            .where((PaymentCollection paymentCollection) =>
                int.parse("${paymentCollection.paymentId ?? 0}") ==
                    customerId &&
                DateTime(
                        paymentCollection.paymentTime.year,
                        paymentCollection.paymentTime.month,
                        paymentCollection.paymentTime.day) ==
                    DateTime(now.year, now.month, now.day))
            .toList()
            .length >
        0;
  }

  _onPaymentCollectionResponse(data, PaymentCollection paymentCollection) {
    db.paymentCollectionBean.update(paymentCollection..synced = true);
    getDBData();
  }

  _onSyncError(error) {
    print("Error $error");
  }

  @override
  Future init() async {
    super.init();
    await getDBData();
  }
}

var paymentsManager = PaymentsManager();
