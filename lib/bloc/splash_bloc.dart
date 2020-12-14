import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/availability_manager.dart';
import 'package:solutech_sat/helpers/banking_manager.dart';
import 'package:solutech_sat/helpers/bluetooth_manager.dart';
import 'package:solutech_sat/helpers/brands_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/csku_manager.dart';
import 'package:solutech_sat/helpers/customer_group_manager.dart';
import 'package:solutech_sat/helpers/deliveries_manager.dart';
import 'package:solutech_sat/helpers/general_photos_manager.dart';
import 'package:solutech_sat/helpers/payments_manager.dart';
import 'package:solutech_sat/helpers/pricelist_manager.dart';
import 'package:solutech_sat/helpers/product_updates_manager.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/posm_manager.dart';
import 'package:solutech_sat/helpers/product_availability_manager.dart';
import 'package:solutech_sat/helpers/promotions_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/refresh_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/helpers/setup_manager.dart';
import 'package:solutech_sat/helpers/sod_manager.dart';
import 'package:solutech_sat/helpers/sos_manager.dart';
import 'package:solutech_sat/helpers/stats_manager.dart';
import 'package:solutech_sat/helpers/stockpoints_manager.dart';
import 'package:solutech_sat/helpers/surveys_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/helpers/timesheet_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/screen/dashboard_screen.dart';
import 'package:solutech_sat/ui/screen/intro_screen.dart';
import 'package:solutech_sat/ui/screen/login_screen.dart';
import 'package:solutech_sat/ui/screen/old_version_screen.dart';
import 'package:solutech_sat/ui/screen/refresh_screen.dart';
import 'package:solutech_sat/ui/screen/setup_screen.dart';

class SplashBloc extends Bloc {
  void navigateToDashboard() async {
    popAndNavigate(screen: DashboardScreen());
  }

  void navigateToLogin() async {
    popAndNavigate(
      screen: LoginScreen(),
    );
  }

  void navigateToSetup() async {
    popAndNavigate(
      screen: SetupScreen(),
    );
  }

  void navigateByLoginStatus() async {
    if (authManager.isLoggedIn) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      if (setupManager.lastRefreshed != null) {
        var aDate = setupManager.lastRefreshed;
        final refreshDate = DateTime(aDate.year, aDate.month, aDate.day);
        if (refreshDate == today && refreshManager.step == 3) {
          navigateToDashboard();
        } else {
          navigateToRefresh();
        }
      } else {
        navigateToRefresh();
      }
    } else {
      navigateToLogin();
    }
  }

  void navigateToRefresh() {
    popAndNavigate(screen: RefreshScreen());
  }

  void navigateToIntro() {
    popAndNavigate(screen: IntroScreen());
  }

  void navigateToOldVersion() {
    popAndNavigate(screen: OldVersionScreen());
  }

  Future setupVariantCode() async {
    if (setupManager.variantCode != null) {
      await config.setVariant(setupManager.variantCode);
      api = Api(config.apiUrl);
      if (settingsManager.isCorrectVersion) {
        if (setupManager.isFirstTime) {
          navigateToIntro();
        } else {
          navigateByLoginStatus();
        }
      } else {
        navigateToOldVersion();
      }
    } else {
      navigateToSetup();
    }
  }

  void runSetup() async {
    // Initialize database
    await db.init(createDbTables: true);

    await refreshManager.init();
    // For management of authentication
    await authManager.init();

    // For managing settings
    await settingsManager.init();

    await sessionManager.init();

    // For checking offline and online states
    await connectionManager.init();

    // Location
    if (!setupManager.isFirstTime) {
      await locationManager.init();
    } else {
      print("IS_FIRST_TIME");
    }

    await bluetoothManager.init();

    // For management of user roles
    await roleManager.init();

    // Dashboard stats for rep
    await statsManager.init();

    await promotionsManager.init();

    // For routeplan management
    await routePlansManager.init();

    // Load records
    await recordsManager.init();

    // For managing common account data like products, appdata
    await commonsManager.init();

    await paymentsManager.init();

    // For handling checkin records
    await timesheetManager.init();

    // For brands
    await brandsManager.init();
    // For Posm
    await posmManager.init();
    // For brand availability
    await availabilityManager.init();

    // Managing stockpoints
    await stockPointsManager.init();
    // Csku
    await cskusManager.init();

    await bankingManager.init();

    await sosManager.init();

    await sodManager.init();

    await surveysManager.init();

    await generalPhotosManager.init();

    // For loading stock
    await inventoryManager.init();

    // Deliveries
    await deliveriesManager.init();

    // Availability of products
    await productAvailabilityManager.init();

    await productUpdatesManager.init();

    // Managing customer groups
    await customerGroupsManager.init();

    // Managing price list
    await priceListsManager.init();

    //Day manager
    await dayManager.init();

    if (authManager.isLoggedIn) {
      syncManager.sync();
      syncManager.schedulePeriodicSync();
    }

    // Setup the variant code
    await setupVariantCode();
  }

  @override
  void initState() {
    runSetup();
    notifyChanges();
  }
}
