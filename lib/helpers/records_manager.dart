import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/availability.dart';
import 'package:solutech_sat/data/models/customer_balance.dart';
import 'package:solutech_sat/data/models/feedback.dart';
import 'package:solutech_sat/data/models/feedback_comment.dart';
import 'package:solutech_sat/data/models/order.dart';
import 'package:solutech_sat/data/models/order_item.dart';
import 'package:solutech_sat/data/models/printed_etr.dart';
import 'package:solutech_sat/data/models/skip_record.dart';
import 'package:solutech_sat/data/models/status_update.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/payments_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/stats_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/manager.dart';
import 'package:solutech_sat/utils/device_utils.dart';
import 'package:solutech_sat/utils/format_utils.dart';
import 'package:solutech_sat/utils/image_utils.dart';

class RecordsManager extends Manager {
  static RecordsManager instance;
  factory RecordsManager() => instance ??= RecordsManager._instance();
  RecordsManager._instance();
  bool _loadingOrders = false;
  bool _loadingSkipRecords = false;
  bool _loadingStatusUpdates = false;
  bool _loadingFeedbacks = false;
  bool _loadingFeedbackComments = false;
  List<Order> orders = [];
  List comments = [];
  List<SkipRecord> skipRecords = [];
  List<OrderItem> orderItems = [];
  List<StatusUpdate> statusUpdates = [];
  List<Feedback> feedbacks = [];

  Future getDBData() async {
    orders = await db.orderBean.getAll();
    orderItems = await db.orderItemBean.getAll();
    statusUpdates = await db.statusUpdateBean.getAll();
    skipRecords = await db.skipRecordBean.getAll();
    feedbacks = await db.feedbackBean.getAll();
    notifyChanges();
  }

  bool get loadingOrders => _loadingOrders;

  set loadingOrders(bool show) {
    _loadingOrders = show;
    notifyChanges();
  }

  bool get loadingSkipRecords => _loadingSkipRecords;

  bool get loadingStatusUpdates => _loadingStatusUpdates;

  set loadingStatusUpdates(bool show) {
    _loadingStatusUpdates = show;
    notifyChanges();
  }

  bool get loadingFeedbacks => _loadingFeedbacks;
  bool get loadingFeedbackComments => _loadingFeedbackComments;
  set loadingFeedbacks(bool show) {
    _loadingFeedbacks = show;
    notifyChanges();
  }

  set loadingFeedbackComments(bool show) {
    _loadingFeedbackComments = show;
    notifyChanges();
  }

  set loadingSkipRecords(bool show) {
    _loadingSkipRecords = show;
    notifyChanges();
  }

  bool hasTodaysRecord(int customerId, [type = "Sale"]) {
    var now = DateTime.now();
    if (type == "Skip") {
      return skipRecords
              .where((skipRecord) =>
                  skipRecord.shopId == customerId &&
                  DateTime(
                          DateTime.parse(skipRecord.orderTime).year,
                          DateTime.parse(skipRecord.orderTime).month,
                          DateTime.parse(skipRecord.orderTime).day) ==
                      DateTime(now.year, now.month, now.day))
              .toList()
              .length >
          0;
    }

    if (type == "Feedback") {
      return feedbacks
              .where((feedback) =>
                  feedback.outletId == customerId &&
                  DateTime(feedback.entryTime.year, feedback.entryTime.month,
                          feedback.entryTime.day) ==
                      DateTime(now.year, now.month, now.day))
              .toList()
              .length >
          0;
    }
    return orders
            .where((order) =>
                order.shopId == customerId &&
                order.entryType == type &&
                DateTime(order.orderTime.year, order.orderTime.month,
                        order.orderTime.day) ==
                    DateTime(now.year, now.month, now.day))
            .toList()
            .length >
        0;
  }

  List<Order> ordersByShopId(int shopId, [String type]) {
    if (type == null) {
      return orders.where((order) => order.shopId == shopId).toList();
    } else {
      return orders
          .where((order) => order.shopId == shopId && order.entryType == type)
          .toList();
    }
  }

  List<SkipRecord> skipByShopId(int shopId) {
    return skipRecords
        .where((skipRecord) => skipRecord.shopId == shopId)
        .toList();
  }

  List<Feedback> get pendingFeedbacks {
    return feedbacks
        .where((feedback) =>
            feedback.status == "Pending" || feedback.status == null)
        .toList();
  }

  List<Feedback> get resolvedFeedbacks {
    return feedbacks
        .where((feedback) => feedback.status == "Resolved")
        .toList();
  }

  List<StatusUpdate> get pendingStatusUpdates {
    return statusUpdates
        .where((statusUpdate) =>
            statusUpdate.status == "Pending" || statusUpdate.status == null)
        .toList();
  }

  List<StatusUpdate> get approvedStatusUpdates {
    return statusUpdates
        .where((statusUpdate) => statusUpdate.status == "Approved")
        .toList();
  }

  List<StatusUpdate> get rejectedStatusUpdates {
    return statusUpdates
        .where((statusUpdate) => statusUpdate.status == "Rejected")
        .toList();
  }

  Order orderFromId(int orderId) {
    return orders.firstWhere((order) => order.orderId == orderId,
        orElse: () => null);
  }

  Future saveOrder({Order order, List<OrderItem> orderItems}) async {
    statsManager.addSale(order.totalCost, order.shopId);
    int result = await db.orderBean.insert(
      order
        ..visitId = sessionManager.session?.sessionId ?? ""
        ..synced = false
        ..fromServer = false,
    );
    for (var item in orderItems) {
      var totalCost = double.parse("${item.sellingPrice}") * item.quantity;
      await db.orderItemBean.insert(item
        ..orderId = result
        ..sellingTotalcost = "$totalCost");
      if (order.entryType == "Sale") {
        await inventoryManager.subtractVirtualStockForOrder(item);
      }
    }
    double creditNote = double.parse("${order.creditNote ?? 0}");
    if (creditNote > 0) {
      if ((order.paymentAmount + creditNote) < order.sellingTotalCost) {
        await paymentsManager.saveCustomerBalance(
          CustomerBalance(
            shopId: order.shopId,
            synced: false,
            orderId: result,
            shopName: routePlansManager
                .getCustomerById(order.shopId)
                ?.shopName
                ?.toUpperCase(),
            amount: "${order.sellingTotalCost}",
            amountpaid: "${(order.paymentAmount + creditNote)}",
          ),
        );
      }
    } else {
      if (order.paymentAmount < order.sellingTotalCost) {
        await paymentsManager.saveCustomerBalance(
          CustomerBalance(
            shopId: order.shopId,
            synced: false,
            orderId: result,
            shopName: routePlansManager
                .getCustomerById(order.shopId)
                ?.shopName
                ?.toUpperCase(),
            amount: "${order.sellingTotalCost}",
            amountpaid: "${order.paymentAmount}",
          ),
        );
      }
    }
    print("Order inserted");
    await getDBData();
    syncManager.sync();
  }

  Future saveUpdateStatus(StatusUpdate statusUpdate) async {
    int result = await db.statusUpdateBean.insert(statusUpdate
      ..fromServer = false
      ..synced = false);
    print("Status update inserted");
    await getDBData();
    syncManager.sync();
  }

  Future<DateTime> printedEtrDate(orderId) async {
    var printedEtr = await db.printedEtrBean.find(orderId);
    var order = await db.orderBean.find(orderId);
    return printedEtr?.printedAt ?? order?.printedAt;
  }

  Future savePrintedEtr(PrintedEtr printedEtr) async {
    int result = await db.printedEtrBean.insert(printedEtr..synced = false);
    print("Printed etr inserted");
    await getDBData();
    syncManager.sync();
  }

  Future saveFeedback(Feedback feedback) async {
    int result = await db.feedbackBean.insert(feedback
      ..visitId = sessionManager.session?.sessionId ?? ""
      ..fromServer = false
      ..synced = false);
    print("Feedback inserted");
    await getDBData();
    syncManager.sync();
  }

  Future saveSkip(SkipRecord skipRecord) async {
    int result = await db.skipRecordBean.insert(
      skipRecord
        ..visitId = sessionManager.session.sessionId
        ..fromServer = false
        ..synced = false,
    );
    statsManager.addActual();
    print("Skip saved");
    await getDBData();
    syncManager.sync();
  }

  List<OrderItem> orderItemsFromOrderId(int orderId) {
    return orderItems
        .where((orderItem) => orderItem.orderId == orderId)
        .toList();
  }

  Future<List<OrderItem>> orderItemsFromOrderIdDB(int orderId) async {
    return (await db.orderItemBean.getAll())
        .where((orderItem) => orderItem.orderId == orderId)
        .toList();
  }

  Future loadOrders([List<DateTime> pickedDates]) {
    loadingOrders = true;
    var filterDates = filterDatesFrom(pickedDates);
    return api.getOrders(filterDates).then((response) async {
      if (response.data["status"] == 1 || response.data["status"] == 0) {
        var payload = response.data["payload"];
        await _saveOrdersLocally(payload);
        loadingOrders = false;
        return response;
      } else {
        loadingOrders = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future loadStatusUpdates([List<DateTime> pickedDates]) {
    loadingStatusUpdates = true;
    var filterDates = filterDatesFrom(pickedDates);
    return api.getStatusUpdates(filterDates).then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveStatusUpdatesLocally(payload);
        loadingStatusUpdates = false;
        return response;
      } else {
        loadingStatusUpdates = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future loadFeedbacks([List<DateTime> pickedDates]) {
    loadingFeedbacks = true;
    var filterDates = filterDatesFrom(pickedDates);
    return api.getFeedbacks(filterDates).then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveFeedbacksLocally(payload);
        loadingFeedbacks = false;
        return response;
      } else {
        loadingFeedbacks = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future<List<FeedbackComment>> getFeedbackComments(int feedbackId) async {
    List<FeedbackComment> comments = [];
    var response = await api.getFeedbackId(feedbackId);
    if (response.data["status"] == 1) {
      for (var item in response.data["payload"]) {
        comments.add(FeedbackComment.fromMap(item));
      }
    }
    return comments;
  }

  Future loadSkipRecords([List<DateTime> pickedDates]) {
    loadingSkipRecords = true;
    var filterDates = filterDatesFrom(pickedDates);
    return api.getSkipRecords(filterDates).then((response) async {
      if (response.data["status"] == 1 || response.data["status"] == 0) {
        var payload = response.data["payload"];
        await _saveSkipRecordsLocally(payload);
        loadingSkipRecords = false;
        return response;
      } else {
        loadingSkipRecords = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future _saveOrdersLocally(payload) async {
    await db.orderBean.removeAll();
    await db.orderItemBean.removeAll();
    for (var item in payload) {
      await db.orderBean.insert(Order.fromMap(item)
        ..id = item["order_id"]
        ..synced = true
        ..fromServer = true);

      for (var orderItem in item["order_details"]) {
        await db.orderItemBean.insert(OrderItem.fromMap(orderItem));
      }
    }
    print("Orders and sales saved");
    await getDBData();
  }

  Future _saveStatusUpdatesLocally(payload) async {
    await db.statusUpdateBean.removeAll();
    for (var item in payload) {
      await db.statusUpdateBean.insert(StatusUpdate.fromMap(item)
        ..fromServer = true
        ..synced = true);
    }
    await getDBData();
  }

  Future _saveFeedbacksLocally(payload) async {
    await db.feedbackBean.removeAll();
    for (var item in payload) {
      await db.feedbackBean.insert(Feedback.fromMap(item)
        ..fromServer = true
        ..synced = true);
    }
    print("Feedbacks saved");
    await getDBData();
  }

  Future updateRecordsCustomerId(int oldId, int newId) async {
    List<SkipRecord> skipRecords = await db.skipRecordBean.findWhere(db
        .skipRecordBean.shopId
        .iss(oldId)
        .and(db.skipRecordBean.synced.iss(false)));
    List<Order> orders = await db.orderBean.findWhere(
        db.orderBean.shopId.iss(oldId).and(db.orderBean.synced.iss(false)));
    List<Feedback> feedbacks = await db.feedbackBean.findWhere(db
        .feedbackBean.outletId
        .iss(oldId)
        .and(db.feedbackBean.synced.iss(false)));
    for (var i = 0; i < skipRecords.length; i++) {
      skipRecords[i].shopId = newId;
    }
    for (var i = 0; i < orders.length; i++) {
      orders[i].shopId = newId;
    }

    for (var i = 0; i < feedbacks.length; i++) {
      feedbacks[i].outletId = newId;
    }

    await db.skipRecordBean.updateMany(skipRecords);
    await db.orderBean.updateMany(orders);
    await db.feedbackBean.updateMany(feedbacks);
    getDBData();
    syncManager.sync();
  }

  Future _saveSkipRecordsLocally(payload) async {
    await db.skipRecordBean.removeAll();
    for (var item in payload) {
      await db.skipRecordBean.insert(
        SkipRecord.fromMap(item)
          ..fromServer = true
          ..synced = true,
      );
    }
    print("Skip records saved");
    await getDBData();
  }

  _onStatusSyncResponse(data, StatusUpdate statusUpdate) {
    db.statusUpdateBean.update(statusUpdate..synced = true);
    getDBData();
  }

  _onFeedbackSyncResponse(data, Feedback feedback) {
    db.feedbackBean.update(feedback..synced = true);
    getDBData();
  }

  _onSkipRecordSyncResponse(data, SkipRecord skipRecord) {
    db.skipRecordBean.update(skipRecord..synced = true);
    getDBData();
  }

  _onOrderResponse(data, Order order) {
    db.orderBean.update(order
      ..synced = true
      ..orderId = data["record_id"]);
    getDBData();
  }

  _onSyncPrintedEtrResponse(data, PrintedEtr printedEtr) {
    db.printedEtrBean.update(printedEtr..synced = true);
    getDBData();
  }

  _onSyncError(error) {
    print("Error $error");
  }

  Future syncStatusUpdates() async {
    List<StatusUpdate> unsyncedStatusUpdates = statusUpdates
        .where((StatusUpdate statusUpdate) => statusUpdate.synced == false)
        .toList();
    for (StatusUpdate statusUpdate in unsyncedStatusUpdates) {
      try {
        var response = await api.saveStatusUpdate({
          "status_notes": statusUpdate.statusNotes,
          "status_time": formatDate(statusUpdate.statusTime?.toString(), "xt"),
          "status_type": statusUpdate.statusType,
          "start": formatDate(statusUpdate.startDate),
          "end": formatDate(statusUpdate.endDate),
          "latitude": statusUpdate.latitude,
          "longitude": statusUpdate.longitude,
          "status_category": statusUpdate.statusCategory,
          "saler_id": statusUpdate.salerId,
          "status_photo": (statusUpdate.statusPhoto != null &&
                  statusUpdate.statusPhoto.trim() != "")
              ? await base64FromFile(File(statusUpdate.statusPhoto))
              : null,
        });

        if (response.data["status"] == 1) {
          _onStatusSyncResponse(
            response.data,
            statusUpdate,
          );
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

  Future syncFeedbacks() async {
    List<Feedback> unsyncedFeedbacks = feedbacks
        .where((Feedback feedback) => feedback.synced == false)
        .toList();
    for (Feedback feedback in unsyncedFeedbacks) {
      if (feedback.outletId == null ||
          (feedback.outletId != null &&
              routePlansManager.getCustomerById(feedback.outletId).synced)) {
        try {
          var response = await api.saveFeedback({
            "notes": feedback.notes,
            "brand": feedback.brand,
            "visitid": feedback.visitId,
            if (feedback.outletId != null)
              "outlet_id":
                  routePlansManager.getCustomerById(feedback.outletId).shopId,
            "quantity": feedback.quantity,
            "category": feedback.category,
            "product_id": 0, //feedback.productId,
            "batchnumber": feedback.batchnumber,
            "entry_time": formatDate(feedback.entryTime?.toString(), "xt"),
            "latitude": feedback.lat,
            "longitude": feedback.lon,
            "rep_id": feedback.repId,
            "photo": (feedback.photo != null && feedback.photo.trim() != "")
                ? await base64FromFile(File(feedback.photo))
                : null,
          });
          if (response.data["status"] == 1) {
            _onFeedbackSyncResponse(response.data, feedback);
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

  Future syncSkipRecords() async {
    List<SkipRecord> unsyncedSkipRecords = (await db.skipRecordBean.getAll())
        .where((SkipRecord skipRecord) => skipRecord.synced == false)
        .toList();
    for (SkipRecord skipRecord in unsyncedSkipRecords) {
      if (routePlansManager.getCustomerById(skipRecord.shopId).synced) {
        try {
          var response = await api.saveSkipRecord({
            "skip_reason": skipRecord.skipReason,
            "latitude": skipRecord.latitude,
            "visitid": skipRecord.visitId,
            "next_visit_date":
                formatDate(skipRecord.nextVisitDate?.toString(), "xt"),
            "call_status": skipRecord.callStatus,
            "route_id": skipRecord.routeId,
            "longitude": skipRecord.longitude,
            "skip_notes": skipRecord.skipNotes,
            "order_time": skipRecord.orderTime,
            "route_type": skipRecord.routeType,
            "Battery": skipRecord.battery,
            "new_shop": skipRecord.newShop,
            "saler_id": skipRecord.salerId,
            "shop_id": int.parse(
                "${routePlansManager.getCustomerById(skipRecord.shopId).shopId}"),
          });
          if (response.data["status"] == 1) {
            _onSkipRecordSyncResponse(response.data, skipRecord);
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

  Future<List<Map<String, dynamic>>> _buildOrderItems(int orderId) async {
    var items = await orderItemsFromOrderIdDB(orderId);
    return items.toList().map((orderItem) {
      var totalCost =
          double.parse("${orderItem.sellingPrice}") * orderItem.quantity;
      return {
        "product_id": orderItem.productId,
        "quantity": orderItem.quantity,
        "selling_price": orderItem.sellingPrice,
        "batchnumber": orderItem.batchnumber,
        "selling_totalcost": orderItem.sellingTotalcost ?? totalCost,
        "product_packaging":
            (orderItem.productPackaging == "ctns") ? "crt" : "pcs",
        "carton_quantity": orderItem.cartonQuantity,
        "totalcost": orderItem.sellingTotalcost ?? totalCost,
        "item_totalcost": orderItem.sellingTotalcost ?? totalCost,
      };
    }).toList();
  }

  Future syncPrintedEtrs() async {
    List<PrintedEtr> unsyncedPrintedEtrs = (await db.printedEtrBean.getAll())
        .where((PrintedEtr printedEtr) => printedEtr.synced == false)
        .toList();
    for (PrintedEtr printedEtr in unsyncedPrintedEtrs) {
      try {
        var response = await api.savePrintedEtr({
          "printed_at": formatDate(printedEtr.printedAt?.toString(), "xt"),
          "order_id": printedEtr.orderId,
          "printed_by": printedEtr.printedBy,
        });

        if (response.data["status"] == 1) {
          _onSyncPrintedEtrResponse(response.data, printedEtr);
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

  Future syncOrders() async {
    List<Order> unsyncedOrders = (await db.orderBean.getAll())
        .where((Order order) => order.synced == false)
        .toList();
    for (Order order in unsyncedOrders) {
      if (routePlansManager.getCustomerById(order.shopId).synced &&
          (await _buildOrderItems(order.id)).length > 0) {
        try {
          var response = await api.saveOrder({
            "selling_total_cost": order.sellingTotalCost,
            "saler_id": order.salerId,
            "visitid": order.visitId,
            "shop_id": routePlansManager.getCustomerById(order.shopId).shopId,
            "new_shop": 0,
            "entry_type": order.entryType,
            "App_Version": config.appVersion,
            "lpo_photo": (order.lpoPhoto != null && order.lpoPhoto.trim() != "")
                ? await base64FromFile(File(order.lpoPhoto))
                : null,
            "cheque_photo":
                (order.chequePhoto != null && order.chequePhoto.trim() != "")
                    ? await base64FromFile(File(order.chequePhoto))
                    : null,
            "payment_amount": order.paymentAmount,
            "payment_method": order.paymentMethod,
            "payment_status": order.paymentStatus,
            "credit_note": order.creditNote,
            "total_cost": order.totalCost,
            if (order.entryType == "Order")
              "expected_delivery":
                  formatDate(order.expectedDelivery?.toString(), "xt"),
            "phone_number":
                routePlansManager.getCustomerById(order.shopId)?.shopPhoneno,
            "route_id":
                routePlansManager.getCustomerById(order.shopId)?.routeId,
            "shop_route_id":
                routePlansManager.getCustomerById(order.shopId)?.routeId,
            "orderitems": json.encode(await _buildOrderItems(order.id)),
            "call_status": order.callStatus,
            "channel": order.channel,
            "region_id":
                routePlansManager.getCustomerById(order.shopId)?.regionId,
            "skipped": 0,
            "order_type": order.orderType,
            "route_type": routePlansManager.routeType(
                routePlansManager.getCustomerById(order.shopId)?.routeId),
            "Battery": await battery.batteryLevel,
            "payment_id": order.paymentId,
            "payment_reference": order.paymentReference,
            "notes": order.notes,
            "maturity_date": formatDate(order.maturityDate?.toString(), "xt"),
            "next_payment": formatDate(order.nextPayment?.toString(), "xt"),
            "order_time": formatDate(order.orderTime?.toIso8601String(), "xt"),
            "latitude": order.latitude,
            "longitude": order.longitude,
          });

          if (response.data["status"] == 1) {
            var payload = response.data["payload"];
            _onOrderResponse(payload, order);
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

  @override
  Future init() async {
    super.init();
    await getDBData();
  }
}

var recordsManager = RecordsManager();
