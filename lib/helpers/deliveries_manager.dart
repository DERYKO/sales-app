import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/availability.dart';
import 'package:solutech_sat/data/models/delivery.dart';
import 'package:solutech_sat/data/models/delivery_order_detail.dart';
import 'package:solutech_sat/data/models/posm.dart';
import 'package:solutech_sat/data/models/posm_material.dart';
import 'package:solutech_sat/data/models/scheduled_delivery.dart';
import 'package:solutech_sat/data/models/session.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/manager.dart';
import 'package:solutech_sat/utils/device_utils.dart';
import 'package:solutech_sat/utils/format_utils.dart';
import 'package:solutech_sat/utils/image_utils.dart';

class DeliveriesManager extends Manager {
  static DeliveriesManager instance;
  factory DeliveriesManager() => instance ??= DeliveriesManager._instance();
  DeliveriesManager._instance();
  List<ScheduledDelivery> scheduledDeliveries = [];
  List<Delivery> deliveries = [];
  List<DeliveryOrderDetail> deliveryOrderDetails = [];
  bool _loadingDeliveries = false;

  Future getDBData() async {
    deliveries = await db.deliveryBean.getAll();
    scheduledDeliveries = await db.scheduledDeliveryBean.getAll();
    deliveryOrderDetails = await db.deliveryOrderDetailBean.getAll();
    notifyChanges();
  }

  bool get loadingDeliveries => _loadingDeliveries;

  set loadingDeliveries(bool show) {
    _loadingDeliveries = show;
    notifyChanges();
  }

  Future loadDeliveries() async {
    loadingDeliveries = true;
    await db.posmMaterialBean.removeAll();
    return api.getDeliveries().then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveDeliveriesLocally(payload);
        loadingDeliveries = false;
        return response;
      } else {
        loadingDeliveries = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  List<DeliveryOrderDetail> deliveryOrderDetailsById(int orderId) {
    return deliveryOrderDetails
        .where((orderDetail) => orderDetail.orderId == orderId)
        .toList();
  }

  List<Delivery> deliveriesByScheduleId(int scheduleId) {
    return deliveries
        .where((delivery) => delivery.scheduledDeliveryId == scheduleId)
        .toList();
  }

  Future startTrip(int sheduledId) async {
    var currentLocation = await locationManager.currentLocation();
    ScheduledDelivery scheduledDelivery = scheduledDeliveries.firstWhere(
        (scheduledDelivery) => scheduledDelivery.id == sheduledId,
        orElse: () => null);
    if (scheduledDelivery != null) {
      int result = await db.scheduledDeliveryBean.upsert(scheduledDelivery
        ..dispatchTime = DateTime.now()
        ..dispatchLat = "${currentLocation.latitude}"
        ..dispatchLon = "${currentLocation.longitude}");
      await getDBData();
      syncManager.sync();
    }
  }

  Future endTrip(int sheduledId) async {
    var currentLocation = await locationManager.currentLocation();
    ScheduledDelivery scheduledDelivery = scheduledDeliveries.firstWhere(
        (scheduledDelivery) => scheduledDelivery.id == sheduledId,
        orElse: () => null);
    if (scheduledDelivery != null) {
      int result = await db.scheduledDeliveryBean.upsert(scheduledDelivery
        ..returnTime = DateTime.now()
        ..returnLat = "${currentLocation.latitude}"
        ..returnLon = "${currentLocation.longitude}");
      await getDBData();
      syncManager.sync();
    }
  }

  bool delivered(int deliveryId) {
    return (deliveries
            .firstWhere((delivery) => delivery.id == deliveryId,
                orElse: () => Delivery())
            .deliveryTime !=
        null);
  }

  saveDelivery(Delivery delivery) async {
    int result = await db.deliveryBean.upsert(delivery
      ..synced = false
      ..fromServer = false);
    await getDBData();
    syncManager.sync();
  }

  Future _saveDeliveriesLocally(payload) async {
    await db.scheduledDeliveryBean.removeAll();
    await db.deliveryBean.removeAll();
    await db.deliveryOrderDetailBean.removeAll();
    for (var item in payload) {
      var scheduledDelivery = ScheduledDelivery.fromMap(item)
        ..syncedStart = ScheduledDelivery.fromMap(item).dispatchTime != null
        ..syncedEnd = ScheduledDelivery.fromMap(item).returnTime != null;
      await db.scheduledDeliveryBean.insert(scheduledDelivery);
      for (var delivery in item["deliveries"]) {
        await db.deliveryBean.insert(Delivery.fromMap(delivery)
          ..fromServer = true
          ..synced = true
          ..scheduledDeliveryId = scheduledDelivery.id);
        for (var orderDetail in delivery["order_details"]) {
          await db.deliveryOrderDetailBean
              .insert(DeliveryOrderDetail.fromMap(orderDetail));
        }
      }
    }
    print("Scheduled deliveries saved");
    await getDBData();
  }

  Future syncDeliveries() async {
    List<Delivery> unsyncedDeliveries = deliveries
        .where((Delivery delivery) => delivery.synced == false)
        .toList();
    for (Delivery delivery in unsyncedDeliveries) {
      try {
        var response = await api.saveDelivery({
          "rep_id": authManager.user.id,
          "user_id": authManager.user.id,
          'shop_id': delivery.shopId,
          'notes': delivery.deliveryNotes,
          "order_id": delivery.orderId,
          'delivery_time': formatDate(delivery.deliveryTime?.toString(), "xt"),
          "lon": delivery.shopLon,
          "lat": delivery.shopLat,
          'photo': (delivery.photo != null && delivery.photo.trim() != "")
              ? await base64FromFile(File(delivery.photo))
              : null,
          "signature": (delivery.receivedsignature != null &&
                  delivery.receivedsignature.trim() != "")
              ? await base64FromFile(File(delivery.receivedsignature))
              : null,
        });

        if (response.data["status"] == 1) {
          _onDeliverySyncResponse(response.data, delivery);
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

  syncScheduledDeliveries() async {
    List<ScheduledDelivery> unsyncedScheduledDelivery =
        (await db.scheduledDeliveryBean.getAll())
            .where((ScheduledDelivery scheduledDelivery) =>
                scheduledDelivery.syncedStart != true)
            .toList();
    for (ScheduledDelivery scheduledDelivery in unsyncedScheduledDelivery) {
      try {
        var response = await api.saveUpdatedSchedule({
          "entry_type": "dispatch",
          "schedule_id": scheduledDelivery.id,
          "saler_id": authManager.user.id,
          "battery": await battery.batteryLevel,
          "lat": scheduledDelivery.dispatchLat,
          "lon": scheduledDelivery.dispatchLon,
          "entry_time":
              formatDate(scheduledDelivery.dispatchTime?.toString(), "xt"),
        });

        if (response.data["status"] == 1) {
          _onScheduleStartSyncResponse(scheduledDelivery);
        } else {
          throw DioError(
            response: response,
          );
        }
      } catch (error) {
        _onSyncError(error);
      }
    }

    List<ScheduledDelivery> syncedScheduledDelivery =
        (await db.scheduledDeliveryBean.getAll())
            .where((ScheduledDelivery scheduledDelivery) =>
                scheduledDelivery.syncedEnd != true &&
                scheduledDelivery.returnTime != null)
            .toList();
    for (ScheduledDelivery scheduledDelivery in syncedScheduledDelivery) {
      try {
        var response = await api.saveUpdatedSchedule({
          "entry_type": "return",
          "schedule_id": scheduledDelivery.id,
          "saler_id": authManager.user.id,
          "battery": await battery.batteryLevel,
          "lat": scheduledDelivery.returnLat,
          "lon": scheduledDelivery.returnLon,
          "entry_time":
              formatDate(scheduledDelivery.returnTime?.toString(), "xt"),
        });

        if (response.data["status"] == 1) {
          _onScheduleEndSyncResponse(scheduledDelivery);
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

  _onScheduleStartSyncResponse(ScheduledDelivery scheduledDelivery) async {
    await db.scheduledDeliveryBean
        .update(scheduledDelivery..syncedStart = true);
    await getDBData();
  }

  _onScheduleEndSyncResponse(ScheduledDelivery scheduledDelivery) async {
    await db.scheduledDeliveryBean.update(scheduledDelivery..syncedEnd = true);
    await getDBData();
  }

  _onDeliverySyncResponse(data, Delivery delivery) async {
    await db.deliveryBean.update(delivery..synced = true);
    await getDBData();
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

var deliveriesManager = DeliveriesManager();
