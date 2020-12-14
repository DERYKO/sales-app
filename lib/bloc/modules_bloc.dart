import 'package:flutter/material.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/role.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/screen/banking_screen.dart';
import 'package:solutech_sat/ui/screen/bankings_screen.dart';
import 'package:solutech_sat/ui/screen/brand_availability_screen.dart';
import 'package:solutech_sat/ui/screen/checkins_screen.dart';
import 'package:solutech_sat/ui/screen/competitor_activities_screen.dart';
import 'package:solutech_sat/ui/screen/customer_screen.dart';
import 'package:solutech_sat/ui/screen/customers_screen.dart';
import 'package:solutech_sat/ui/screen/deliveries_screen.dart';
import 'package:solutech_sat/ui/screen/feedbacks_screen.dart';
import 'package:solutech_sat/ui/screen/inventory_screen.dart';
import 'package:solutech_sat/ui/screen/payments_collection_screen.dart';
import 'package:solutech_sat/ui/screen/payments_screen.dart';
import 'package:solutech_sat/ui/screen/performance_screen.dart';
import 'package:solutech_sat/ui/screen/photos_screen.dart';
import 'package:solutech_sat/ui/screen/posm_screen.dart';
import 'package:solutech_sat/ui/screen/product_availability_screen.dart';
import 'package:solutech_sat/ui/screen/product_updates_screen.dart';
import 'package:solutech_sat/ui/screen/records_screen.dart';
import 'package:solutech_sat/ui/screen/route_plans_screen.dart';
import 'package:solutech_sat/ui/screen/sales_reports_screen.dart';
import 'package:solutech_sat/ui/screen/open_day_screen.dart';
import 'package:solutech_sat/ui/screen/sod_screen.dart';
import 'package:solutech_sat/ui/screen/sos_screen.dart';
import 'package:solutech_sat/ui/screen/status_update_screen.dart';
import 'package:solutech_sat/ui/screen/stock_takes_screen.dart';
import 'package:solutech_sat/ui/screen/surveys_screen.dart';

class ModulesBloc extends Bloc {
  List<Role> roles = [];

  void onComingSoon() async {
    if (dayManager.openedDay) {
      navigate(
        screen: PosmScreen(),
      );
    } else {
      bool opened = await navigate(
        screen: OpenDayScreen(),
      );
      if (opened != null && opened) {
        navigate(
          screen: PosmScreen(),
        );
      }
    }
  }

  void onDeliveries() {
    navigate(
      screen: DeliveriesScreen(),
    );
  }

  void onNavigateToCustomer() async {
    if (sessionManager.inSession) {
      Customer customer =
          routePlansManager.getCustomerById(sessionManager.session.customerId);
      sessionManager.referred = true;
      if (customer != null) {
        navigate(
            screen: CustomerScreen(
          customer: customer,
          routePlan: routePlansManager.routePlanById(customer.routeId),
        ));
      } else {
        alert("Check out?",
            "You are currently checked in to a customer not assigned to you. Checkout to continue",
            onOk: () {
          sessionManager.endSession();
        });
      }
    }
  }

  void onPaymentCollection() {
    navigate(
      screen: PaymentsScreen(),
    );
  }

  void onCompetitorActivities() {
    navigate(
      screen: CompetitorActivitiesScreen(),
    );
  }

  void onPhotos() {
    navigate(
      screen: PhotosScreen(),
    );
  }

  void listPosm() async {
    navigate(
      screen: PosmScreen(),
    );
  }

  void listStockTakes() async {
    navigate(screen: StockTakesScreen());
  }

  void onProductUpdates() {
    navigate(
      screen: ProductUpdatesScreen(),
    );
  }

  void onShareOfDisplay() {
    navigate(
      screen: SodScreen(),
    );
  }

  void listAvailability() async {
    navigate(
      screen: BrandAvailabilityScreen(),
    );
  }

  void onRoutePlan() async {
    navigate(
      screen: RoutePlansScreen(),
    );
  }

  void onSalesReport() {
    navigate(
      screen: SalesReportsScreen(),
    );
  }

  void onPerformance() {
    navigate(
      screen: PerformanceScreen(),
    );
  }

  void onSurveys() async {
    if (dayManager.openedDay) {
      navigate(
        screen: SurveysScreen(),
      );
    } else {
      bool opened = await navigate(
        screen: OpenDayScreen(),
      );
      if (opened != null && opened) {
        navigate(
          screen: SurveysScreen(),
        );
      }
    }
  }

  void onBanking() async {
    navigate(
      screen: BankingsScreen(),
    );
  }

  void onFeedbacks() async {
    if (dayManager.openedDay) {
      navigate(
        screen: FeedbacksScreen(),
      );
    } else {
      bool opened = await navigate(
        screen: OpenDayScreen(),
      );
      if (opened != null && opened) {
        navigate(
          screen: FeedbacksScreen(),
        );
      }
    }
  }

  void onSalesAndOrders() async {
    navigate(
      screen: RecordsScreen(),
    );
  }

  void onCheckins() {
    navigate(
      screen: CheckinsScreen(),
    );
  }

  void onStatusUpdate() {
    navigate(
      screen: StatusUpdatesScreen(),
    );
  }

  void openInventory() async {
    navigate(
      screen: InventoryScreen(),
    );
  }

  void onCustomers() async {
    navigate(
      screen: CustomersScreen(),
    );
  }

  void onShelfAvailability() async {
    navigate(
      screen: ProductAvailabilityScreen(),
    );
  }

  void onShareOfShelf() async {
    navigate(
      screen: SosScreen(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Was disposed");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}
