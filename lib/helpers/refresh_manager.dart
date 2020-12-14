import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/availability_manager.dart';
import 'package:solutech_sat/helpers/banking_manager.dart';
import 'package:solutech_sat/helpers/brands_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/competitor_activities_manager.dart';
import 'package:solutech_sat/helpers/csku_manager.dart';
import 'package:solutech_sat/helpers/customer_group_manager.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/deliveries_manager.dart';
import 'package:solutech_sat/helpers/general_photos_manager.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/payments_manager.dart';
import 'package:solutech_sat/helpers/posm_manager.dart';
import 'package:solutech_sat/helpers/pricelist_manager.dart';
import 'package:solutech_sat/helpers/product_availability_manager.dart';
import 'package:solutech_sat/helpers/product_updates_manager.dart';
import 'package:solutech_sat/helpers/promotions_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/helpers/setup_manager.dart';
import 'package:solutech_sat/helpers/sod_manager.dart';
import 'package:solutech_sat/helpers/sos_manager.dart';
import 'package:solutech_sat/helpers/stats_manager.dart';
import 'package:solutech_sat/helpers/stockpoints_manager.dart';
import 'package:solutech_sat/helpers/surveys_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/helpers/timesheet_manager.dart';
import 'package:solutech_sat/tools/manager.dart';

class RefreshManager extends Manager {
  static RefreshManager instance;
  factory RefreshManager() => instance ??= RefreshManager._instance();
  RefreshManager._instance();
  List<_RefreshTask> tasks = [];
  Box _box;
  bool erred = false;
  int currentIndex = 0;
  String progressText = "Preparing...";
  double progress = 0.0;
  String errorText = "";
  Function onDeactivated;
  Function onOldVersion;

  int get step => _box.get("step", defaultValue: 1);

  Future setStep(int step) async {
    await _box.put("step", step);
  }

  void setProgressText(String text) {
    progressText = "$text";
    notifyChanges();
  }

  void _onError(error, stack) {
    erred = true;
    if (error is DioError) {
      print("API Error: ${error.request?.path}  ${error.type}");
      if (error.type == DioErrorType.DEFAULT) {
        if (error.response?.data is Map) {
          print("Error: MAIN");
          errorText = error.response.data["message"];
        } else {
          print("Error: N/A");
          if (error.response != null) {
            errorText = "Something went wrong";
          } else {
            errorText = error.message.contains("SocketException")
                ? "No internet connection"
                : "Connection failed";
          }
        }
      }

      if (error.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorText = "Request time out";
      }

      if (error.type == DioErrorType.CONNECT_TIMEOUT) {
        errorText = "Connection time out";
      }

      if (error.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorText = "Response time out";
      }

      if (error.type == DioErrorType.CANCEL) {
        errorText = "Connection time out";
      }

      if (error.type == DioErrorType.RESPONSE) {
        errorText =
            "${(error.response.data != null) ? error.response.data["message"] : "Something went wrong"}";
      }
    } else {
      errorText = "Refresh failed. \nPlease contact support";
      print("FatalError $error, \n$stack");
    }
    notifyChanges();
  }

  void _performInitialSetup() async {
    if (await syncManager.shouldSync) {
      _syncAllRecords().catchError(_onError);
    } else {
      if (!syncManager.syncing) {
        db.clearData();
        dayManager.clear();
        _getUpdateProfile().catchError(_onError);
      }
    }
  }

  Future _getUpdateProfile() {
    setProgressText("Fetching updates");
    return settingsManager.refreshUpdateProfile().then((response) {
      if (settingsManager.isCorrectVersion) {
        if (settingsManager.updateProfile.userdata.status == "Active") {
          _getUserRoles().catchError(_onError);
        } else {
          if (onDeactivated != null) {
            authManager.logout();
            onDeactivated();
          }
        }
      } else {
        if (onOldVersion != null) {
          onOldVersion();
        }
      }
    });
  }

  Future _getUserRoles() {
    setProgressText("Loading roles");
    return roleManager.getRoles().then((response) {
      _addTasksAndRefresh();
    });
  }

  Future _syncAllRecords() {
    setProgressText("Syncing records");
    return syncManager.sync().then((done) {
      db.clearData();
      dayManager.clear();
      _getUpdateProfile();
    });
  }

  Future _getCommons() {
    return Future.wait([
      roleManager.loadModuleNames(),
      commonsManager.loadCommons(),
      commonsManager.loadMustHaveSkus(),
      commonsManager.loadPaymentModes(),
      commonsManager.loadFeedbackCategories(),
      commonsManager.loadPackagingOptions(),
      if (roleManager.hasRole(Roles.INITIATIVES))
        promotionsManager.loadPromotions(),
      brandsManager.loadBrands(),
      cskusManager.loadCskus(),
      dayManager.loadOpenDay(),
      customerGroupsManager.loadCustomerGroups(),
      bankingManager.loadBanks(),
      bankingManager.loadCashToBank(),
      bankingManager.loadCheques(),
      bankingManager.loadBankings(),
      if (!roleManager.hasRole(Roles.USE_DEFAULT_PRICE_LIST))
        priceListsManager.loadPriceLists(),
    ]).then((response) {
      next();
    }).catchError(_onError);
  }

  Future _getStockPoints() {
    return stockPointsManager.loadStockpoints().then((response) {
      next();
    }).catchError(_onError);
  }

  Future _loadSalesSummary() {
    return statsManager.loadSalesSummary().then((response) {
      next();
    }).catchError(_onError);
  }

  Future _loadRoutePlans() {
    return routePlansManager.loadRoutePlans().then((response) {
      next();
    }).catchError(_onError);
  }

  Future _loadInventory() {
    return Future.wait([
      inventoryManager.loadStock(),
      inventoryManager.loadVirtualStock(),
      if (roleManager.hasRole(Roles.VIRTUAL_WITH_STOCKPOINT))
        inventoryManager.loadStockPointStock(),
    ]).then((response) {
      next();
    }).catchError(_onError);
  }

  Future _loadRecords() {
    return Future.wait([
      recordsManager.loadOrders(),
      recordsManager.loadSkipRecords(),
      locationManager.loadUserLocations(),
      recordsManager.loadStatusUpdates(),
      recordsManager.loadFeedbacks(),
      if (roleManager.hasRole(Roles.POSM_AUDIT))
        posmManager.loadPosmMaterials(),
      if (roleManager.hasRole(Roles.POSM_AUDIT)) posmManager.loadPosm(),
      if (roleManager.hasRole(Roles.BRAND_AVAILABILITY))
        availabilityManager.loadAvailability(),
      if (roleManager.hasRole(Roles.AVAILABILITY))
        productAvailabilityManager.loadAvailability(),
      timesheetManager.loadTimesheets(),
      if (roleManager.hasRole(Roles.DAMAGES) ||
          roleManager.hasRole(Roles.EXPIRIES))
        productUpdatesManager.loadProductUpdates(),
      if (roleManager.hasRole(Roles.COMPETITOR))
        competitorActivitiesManager.loadCompetitorActivities(),
      if (roleManager.hasRole(Roles.SHELF_SHARE)) sosManager.loadSos(),
      if (roleManager.hasRole(Roles.SHARE_OF_DISPLAY)) sodManager.loadSods(),
      if (roleManager.hasRole(Roles.IMAGES))
        generalPhotosManager.loadGeneralPhotos(),
      if (roleManager.hasRole(Roles.DELIVERY))
        deliveriesManager.loadDeliveries(),
      if (roleManager.hasRole(Roles.PAYMENTS))
        paymentsManager.loadCustomerBalances(),
      if (roleManager.hasRole(Roles.PAYMENTS)) paymentsManager.loadPayments(),
      if (roleManager.hasRole(Roles.SURVEY)) surveysManager.loadSurveyAnswers(),
      if (roleManager.hasRole(Roles.SURVEY)) surveysManager.loadSurveys(),
    ]).then((response) {
      next();
    }).catchError(_onError);
  }

  void _addTasksAndRefresh() async {
    await setStep(2);
    progress = 0.21;
    tasks = [];
    tasks.add(
      _RefreshTask(
        title: "Commons",
        task: _getCommons,
        progress: 0.44,
      ),
    );
    tasks.add(
      _RefreshTask(
        title: "Route plans",
        task: _loadRoutePlans,
        progress: 0.52,
      ),
    );
    tasks.add(
      _RefreshTask(
        title: "Stockpoints",
        task: _getStockPoints,
        progress: 0.68,
      ),
    );

    tasks.add(
      _RefreshTask(
        title: "Records",
        progress: 0.81,
        task: _loadRecords,
      ),
    );
    tasks.add(
      _RefreshTask(
        title: "Inventory",
        task: _loadInventory,
        progress: 0.88,
      ),
    );
    tasks.add(
      _RefreshTask(
        title: "Sales summary",
        task: _loadSalesSummary,
        progress: 0.98,
      ),
    );

    tasks[currentIndex].task();
    notifyChanges();
  }

  Future next() async {
    if (currentIndex + 1 < tasks.length) {
      progress = tasks[currentIndex].progress;
      currentIndex += 1;
      tasks[currentIndex].task();
      print("P1... $progressText, $currentIndex");
      notifyChanges();
    } else {
      finishUp();
    }
    print("Saved... $progressText");
  }

  void reload() async {
    erred = false;
    notifyChanges();
    if (step == 1 || errorText == "A Fatal error occured!") {
      start();
    } else if (step == 3) {
      finishUp();
    } else {
      tasks[currentIndex].task();
    }
  }

  void finishUp() async {
    progress = tasks[currentIndex].progress;
    setProgressText("Finishing up");
    await setStep(3);
    setupManager.setLastRefreshed(DateTime.now());
    notifyChanges();
  }

  void start() async {
    reset();
    _performInitialSetup();
  }

  void _clearError() {
    erred = false;
    notifyChanges();
  }

  void reset() async {
    await setStep(1);
    currentIndex = 0;
    erred = false;
    progressText = "Preparing...";
    progress = 0.0;
    tasks.clear();
    notifyChanges();
  }

  @override
  void init() async {
    super.init();
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    _box = await Hive.openBox('refreshBox');
    _clearError();
  }
}

class _RefreshTask {
  String title;
  Future<dynamic> Function() task;
  double progress;
  _RefreshTask({
    this.title,
    this.task,
    this.progress,
  });
}

var refreshManager = RefreshManager();
