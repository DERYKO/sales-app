import 'dart:async';

import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/helpers/availability_manager.dart';
import 'package:solutech_sat/helpers/banking_manager.dart';
import 'package:solutech_sat/helpers/competitor_activities_manager.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/deliveries_manager.dart';
import 'package:solutech_sat/helpers/general_photos_manager.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/payments_manager.dart';
import 'package:solutech_sat/helpers/posm_manager.dart';
import 'package:solutech_sat/helpers/product_availability_manager.dart';
import 'package:solutech_sat/helpers/product_updates_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/sod_manager.dart';
import 'package:solutech_sat/helpers/sos_manager.dart';
import 'package:solutech_sat/helpers/stock_takes_manager.dart';
import 'package:solutech_sat/helpers/surveys_manager.dart';
import 'package:solutech_sat/tools/manager.dart';

class SyncManager extends Manager {
  static SyncManager instance;
  factory SyncManager() => instance ??= SyncManager._instance();
  SyncManager._instance();
  bool _syncing = false;
  Timer _timer;
  Future<bool> get shouldSync async {
    List<bool> completedSyncs = [
      ...(await db.customerBean.getAll())
          .map<bool>((shop) => shop.synced)
          .toList(),
      ...(await db.customerBean.getAll())
          .map<bool>((shop) => (shop.updated != null) ? !shop.updated : true)
          .toList(),
      ...(await db.stockBean.getAll())
          .map<bool>((stock) => stock.synced)
          .toList(),
      ...(await db.statusUpdateBean.getAll())
          .map<bool>((statusUpdate) => statusUpdate.synced)
          .toList(),
      ...(await db.orderBean.getAll())
          .map<bool>((order) => order.synced)
          .toList(),
      ...(await db.skipRecordBean.getAll())
          .map<bool>((skip) => skip.synced)
          .toList(),
      ...(await db.feedbackBean.getAll())
          .map<bool>((feedback) => feedback.synced)
          .toList(),
      ...(await db.printedEtrBean.getAll())
          .map<bool>((printedEtr) => printedEtr.synced)
          .toList(),
      ...(await db.availabilityBean.getAll())
          .map<bool>((availability) => availability.synced)
          .toList(),
      ...(await db.posmBean.getAll()).map<bool>((posm) => posm.synced).toList(),
      ...(await db.productAvailabilityBean.getAll())
          .map<bool>((productUpdate) => productUpdate.synced)
          .toList(),
      ...(await db.productUpdateBean.getAll())
          .map<bool>((productUpdate) => productUpdate.synced)
          .toList(),
      ...(await db.competitorActivityBean.getAll())
          .map<bool>((competitorActivity) => competitorActivity.synced)
          .toList(),
      ...(await db.sosBean.getAll()).map<bool>((sos) => sos.synced).toList(),
      ...(await db.sodBean.getAll()).map<bool>((sod) => sod.synced).toList(),
      ...(await db.generalPhotoBean.getAll())
          .map<bool>((generalPhoto) => generalPhoto.synced)
          .toList(),
      ...(await db.deliveryBean.getAll())
          .map<bool>((delivery) => delivery.synced)
          .toList(),
      ...(await db.paymentCollectionBean.getAll())
          .map<bool>((paymentCollection) => paymentCollection.synced)
          .toList(),
      ...(await db.scheduledDeliveryBean.getAll())
          .map<bool>((session) => session.syncedStart)
          .toList(),
      ...(await db.surveyAnswerBean.getAll())
          .map<bool>((surveyAnswer) => surveyAnswer.synced)
          .toList(),
      ...(await db.scheduledDeliveryBean.getAll())
          .map<bool>((session) =>
              ((!session.syncedEnd && session.returnTime == null) ||
                  session.syncedEnd))
          .toList(),
      ...(await db.stockTakeBean.getAll())
          .map<bool>((stockTake) => stockTake.synced)
          .toList(),
      ...(await db.bankingBean.getAll())
          .map<bool>((banking) => banking.synced)
          .toList(),
      ...(await db.sessionBean.getAll())
          .map<bool>((session) => session.syncedStart)
          .toList(),
      ...(await db.sessionBean.getAll())
          .where((session) => session.endTime != null && session.syncedStart)
          .map<bool>((session) => session.syncedEnd)
          .toList(),
    ];
    return completedSyncs.contains(false);
  }

  void schedulePeriodicSync() {
    _timer = Timer.periodic(Duration(minutes: 1), (Timer timer) {
      sync();
    });
  }

  void cancelPeriodicSync() {
    _timer?.cancel();
  }

  bool get syncing {
    return _syncing;
  }

  set syncing(bool syncing) {
    _syncing = syncing;
    notifyChanges();
  }

  Future sync() async {
    if (await shouldSync && connectionManager.isConnected) {
      syncing = true;
      await routePlansManager.syncCustomers();
      await routePlansManager.syncUpdatedCustomers();
      await inventoryManager.syncStocks();
      await recordsManager.syncOrders();
      await recordsManager.syncSkipRecords();
      await recordsManager.syncStatusUpdates();
      await recordsManager.syncFeedbacks(); //Nashinki
      await recordsManager.syncPrintedEtrs();
      await availabilityManager.syncAvailability();
      await posmManager.syncPosm();
      await productAvailabilityManager.syncProductAvailability();
      await productUpdatesManager.syncProductUpdate();
      await competitorActivitiesManager.syncCompetitorActivities();
      await sosManager.syncSos();
      await sodManager.syncSod();
      await generalPhotosManager.syncGeneralPhotos();
      await deliveriesManager.syncDeliveries();
      await surveysManager.syncSurveyAnswers();
      await paymentsManager.syncPaymentCollection();
      await deliveriesManager.syncScheduledDeliveries();
      await stockTakesManager.syncStockTakes();
      await bankingManager.syncBanking();
      await sessionManager.syncStartSessions();
      await sessionManager.syncEndSessions();
      syncing = false;
    }
  }

  @override
  void init() {
    super.init();
  }
}

var syncManager = SyncManager();
