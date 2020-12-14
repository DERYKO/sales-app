import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:solutech_sat/data/models/route_plan.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/helpers/availability_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/competitor_activities_manager.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/general_photos_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/payments_manager.dart';
import 'package:solutech_sat/helpers/posm_manager.dart';
import 'package:solutech_sat/helpers/product_availability_manager.dart';
import 'package:solutech_sat/helpers/product_updates_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/helpers/sod_manager.dart';
import 'package:solutech_sat/helpers/sos_manager.dart';
import 'package:solutech_sat/helpers/surveys_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/screen/add_competition_screen.dart';
import 'package:solutech_sat/ui/screen/add_edit_customer_screen.dart';
import 'package:solutech_sat/ui/screen/add_feedback_screen.dart';
import 'package:solutech_sat/ui/screen/add_photo_screen.dart';
import 'package:solutech_sat/ui/screen/add_product_update_screen.dart';
import 'package:solutech_sat/ui/screen/add_sod_screen.dart';
import 'package:solutech_sat/ui/screen/add_sos_screen.dart';
import 'package:solutech_sat/ui/screen/audit_osa_screen.dart';
import 'package:solutech_sat/ui/screen/brand_audit_screen.dart';
import 'package:solutech_sat/ui/screen/checkins_screen.dart';
import 'package:solutech_sat/ui/screen/open_day_screen.dart';
import 'package:solutech_sat/ui/screen/customer_balances_screen.dart';
import 'package:solutech_sat/ui/screen/photo_checkin_screen.dart';
import 'package:solutech_sat/ui/screen/posm_audit_screen.dart';
import 'package:solutech_sat/ui/screen/recent_activity_screen.dart';
import 'package:solutech_sat/ui/screen/records_screen.dart';
import 'package:solutech_sat/ui/screen/sale_order_screen.dart';
import 'package:solutech_sat/ui/screen/skip_customer_screen.dart';
import 'package:solutech_sat/ui/screen/stock_taking_screen.dart';
import 'package:solutech_sat/ui/screen/survey_screen.dart';
import 'package:solutech_sat/utils/image_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerBloc extends Bloc {
  Customer customer;
  RoutePlan routePlan;
  CustomerBloc({this.customer, this.routePlan});

  void makeASale() async {
    if (await canPerformActivity()) {
      if (recordsManager.ordersByShopId(customer.id, "Sale").length > 0) {
        navigate(
          screen: RecentActivityScreen(
            customer: customer,
            routePlan: routePlan,
            mode: "Sale",
          ),
        );
      } else {
        navigate(
          screen: SaleOrderScreen(
            customer: customer,
            routePlan: routePlan,
            mode: "Sale",
          ),
        );
      }
    }
  }

  Future<File> takePhoto() async {
    File image;
    var pickedImage = await ImagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = await compressImageFile(pickedImage);
    }
    return image;
  }

  bool auditsAreDone() {
    if (roleManager.hasRole(Roles.POSM_AUDIT) &&
        roleManager.hasRole(Roles.MANDATORY_POSM)) {
      return posmManager.hasTodaysRecord(customer.id);
    } else if (roleManager.hasRole(Roles.BRAND_AVAILABILITY) &&
        roleManager.hasRole(Roles.MANDATORY_BRANDAUDIT)) {
      return availabilityManager.hasTodaysRecord(customer.id);
    } else {
      return true;
    }
  }

  void addFeedback() async {
    if (await canPerformActivity()) {
      navigate(screen: AddFeedbackScreen(customer: customer));
    }
  }

  void onAuditOSA() {
    navigate(
      screen: AuditOSAScreen(
        customer: customer,
      ),
    );
  }

  void onStockTaking() {
    navigate(
      screen: StockTakingScreen(
        customer: customer,
        routePlan: routePlan,
      ),
    );
  }

  void onDamages() async {
    if (await canPerformActivity()) {
      navigate(
          screen:
              AddProductUpdateScreen(customer: customer, updateType: "Damage"));
    }
  }

  void onExpiry() async {
    if (await canPerformActivity()) {
      navigate(
          screen:
              AddProductUpdateScreen(customer: customer, updateType: "Expiry"));
    }
  }

  void onCompetition() async {
    if (await canPerformActivity()) {
      navigate(screen: AddCompetitionScreen(customer: customer));
    }
  }

  void onShareOfShelf() async {
    if (await canPerformActivity()) {
      navigate(screen: AddSosScreen(customer: customer));
    }
  }

  void onSurvey() async {
    if (await canPerformActivity()) {
      navigate(screen: SurveyScreen(customer: customer));
    }
  }

  void onShareOfDisplay() async {
    if (await canPerformActivity()) {
      navigate(
        screen: AddSodScreen(customer: customer),
      );
    }
  }

  void onPhoto() async {
    if (await canPerformActivity()) {
      navigate(screen: AddPhotoScreen(customer: customer));
    }
  }

  void checkOut() async {
    double meters = await locationManager.distanceInMeters(
      customer.slatitude,
      customer.slongitude,
    );
    if (meters >
            double.parse("${settingsManager.updateProfile.geofenceradius}") &&
        roleManager.hasRole(Roles.GEOFENCE) &&
        !(double.parse("${customer.slatitude ?? 0}") ==
            double.parse("${customer.slongitude ?? 0}"))) {
      alert("Get near the customer",
          "This customer is ${meters.toStringAsFixed(0)} M away. Get closer to the customer to be able to check out.");
      return;
    }

    if (!performedActivity()) {
      alert("Perform an activity",
          "You have to perform an activity before you check out.");
      return;
    }
    if (productAvailabilityManager.hasTodaysRecord(customer.id) ||
        !roleManager.hasRole(Roles.CHECK_IN) ||
        !roleManager.hasRole(Roles.MANDATORY_ON_SHELF)) {
      bool end = await confirm(
        "Check out?",
        "This will end the visit to ${customer.shopName}",
      );

      if (end) {
        sessionManager.endSession();
        if (sessionManager.referred) {
          sessionManager.referred = false;
          popAndNavigate(
            screen: roleManager.hasRole(Roles.CHECK_IN)
                ? CheckinsScreen()
                : RecordsScreen(),
          );
        } else {
          pop();
          pop();
        }
      }
    } else {
      alert(
        "On Shelf Availability is mandatory",
        "You have to perform an onshelf availability audit of products for you to check out.",
      );
    }
  }

  bool performedActivity() {
    return posmManager.hasTodaysRecord(
          customer.id,
        ) ||
        availabilityManager.hasTodaysRecord(
          customer.id,
        ) ||
        recordsManager.hasTodaysRecord(
          customer.id,
        ) ||
        recordsManager.hasTodaysRecord(customer.id, "Order") ||
        sosManager.hasTodaysRecord(
          customer.id,
        ) ||
        recordsManager.hasTodaysRecord(
          customer.id,
          "Skip",
        ) ||
        recordsManager.hasTodaysRecord(customer.id, "Feedback") ||
        productAvailabilityManager.hasTodaysRecord(customer.id) ||
        productUpdatesManager.hasTodaysRecord(
          customer.id,
          "Damage",
        ) ||
        productUpdatesManager.hasTodaysRecord(
          customer.id,
          "Expiry",
        ) ||
        competitorActivitiesManager.hasTodaysRecord(
          customer.id,
          "Competitor Activities",
        ) ||
        paymentsManager.hasTodaysRecord(
          customer.id,
        ) ||
        sodManager.hasTodaysRecord(
          customer.id,
        ) ||
        surveysManager.hasTodaysRecord(
          customer.id,
        ) ||
        generalPhotosManager.hasTodaysRecord(
          customer.id,
        );
  }

  Future<bool> canPerformActivity() async {
    double meters = await locationManager.distanceInMeters(
      customer.slatitude,
      customer.slongitude,
    );

    if (meters >
            double.parse("${settingsManager.updateProfile.geofenceradius}") &&
        roleManager.hasRole(Roles.GEOFENCE) &&
        !(double.parse("${customer.slatitude ?? 0}") ==
            double.parse("${customer.slongitude ?? 0}"))) {
      alert("Get near the customer",
          "This customer is ${meters.toStringAsFixed(0)} M away. Get closer to the customer to be able to perform an activity.");
      return false;
    } else {
      return true;
    }
  }

  void onPosmAudit() {
    if (posmManager.hasTodaysRecord(customer.id)) {
      navigate(
        screen: RecentActivityScreen(
          customer: customer,
          routePlan: routePlan,
          mode: "Posm",
        ),
      );
    } else {
      navigate(
        screen: PosmAuditScreen(
          customer: customer,
        ),
      );
    }
  }

  void onBrandAudit() {
    if (availabilityManager.hasTodaysRecord(customer.id)) {
      navigate(
        screen: RecentActivityScreen(
          customer: customer,
          routePlan: routePlan,
          mode: "Brand",
        ),
      );
    } else {
      navigate(
        screen: BrandAuditScreen(
          customer: customer,
        ),
      );
    }
  }

  void showDirection() {
    launch(
      "https://www.google.com/maps?saddr=My+Location&daddr=${customer.slatitude},${customer.slongitude}",
    );
  }

  void checkIn() async {
    if (dayManager.openedDay && !dayManager.closedDay) {
      print(customer.toMap());
      double meters = await locationManager.distanceInMeters(
        customer.slatitude,
        customer.slongitude,
      );

      if (meters >
              double.parse("${settingsManager.updateProfile.geofenceradius}") &&
          roleManager.hasRole(Roles.GEOFENCE) &&
          !(double.parse("${customer.slatitude ?? 0}") ==
              double.parse("${customer.slongitude ?? 0}"))) {
        alert("Get near the customer",
            "This customer is ${meters.toStringAsFixed(0)} M away. Get closer to the customer to be able to start visit.");
      } else {
        if (roleManager.hasRole(Roles.CHECK_IN)) {
          if (sessionManager.sessions
                  .map((session) => session.customerId)
                  .toList()
                  .contains(customer.id) &&
              !roleManager.hasRole(Roles.ALLOW_MULTIPLE_CHECKIN)) {
            alert(
              "You have already checked in to this outlet",
              "Checkin to another outlet.",
            );
            return;
          }

          File image = await takePhoto();
          if (image == null) {
            return;
          }
          bool start = await confirm(
            "Check in?",
            "This will start the visit to ${customer.shopName}",
          );

          if (start) {
            sessionManager.startSession(customer.id, image);
          }
        } else {
          bool start = await confirm(
            "Check in?",
            "This will start the visit to ${customer.shopName}",
          );
          if (start) {
            sessionManager.startSession(customer.id);
          }
        }
      }
    } else {
      navigate(screen: OpenDayScreen());
    }
  }

  void onPayments() async {
    if (await canPerformActivity()) {
      if (paymentsManager.getCustomerBalancesFor(customer.id).fold<double>(
              0.0,
              (a, b) =>
                  a +
                  (double.parse("${b.amount ?? 0}") -
                      double.parse("${b.amountpaid ?? 0}"))) >
          0) {
        navigate(
            screen: CustomerBalancesScreen(
          customer: customer,
        ));
      } else {
        alert(
          "No balances",
          "This customer does not have any balance for collection.",
        );
      }
    }
  }

  void skipOutlet() async {
    if (await canPerformActivity()) {
      if (recordsManager.skipByShopId(customer.id).length > 0) {
        navigate(
          screen: RecentActivityScreen(
            customer: customer,
            routePlan: routePlan,
            mode: "Skip",
          ),
        );
      } else {
        navigate(
          screen: SkipCustomerScreen(
            customer: customer,
          ),
        );
      }
    }
  }

  void makeAnOrder() {
    if (dayManager.openedDay && !dayManager.closedDay) {
      if (recordsManager.hasTodaysRecord(customer.id, "Order")) {
        navigate(
          screen: RecentActivityScreen(
            customer: customer,
            routePlan: routePlan,
            mode: "Order",
          ),
        );
      } else {
        navigate(
          screen: SaleOrderScreen(
            customer: customer,
            routePlan: routePlan,
            mode: "Order",
          ),
        );
      }
    } else {
      navigate(
        screen: OpenDayScreen(),
      );
    }
  }

  void editCustomer() {
    navigate(
      screen: AddEditCustomerScreen(
        customer: customer,
        mode: "edit",
        routePlan: routePlan,
      ),
    );
  }

  void startSession() {
    commonsManager.setStartTime(DateTime.now());
  }

  Future<bool> onWillPop() async {
    if (sessionManager.inSession) {
      bool endSession = await confirm(
          "Checkout?", "This will end your visit to the customer");
      if (endSession) sessionManager.endSession();
      return endSession;
    }
    return true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    sessionManager.resumeSession();
  }
}
