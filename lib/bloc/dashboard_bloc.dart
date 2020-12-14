import 'dart:async';

import 'package:dio/dio.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/refresh_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/screen/checkins_screen.dart';
import 'package:solutech_sat/ui/screen/close_day_screen.dart';
import 'package:solutech_sat/ui/screen/customer_screen.dart';
import 'package:solutech_sat/ui/screen/open_day_screen.dart';
import 'package:solutech_sat/ui/screen/performance_reports_screen.dart';
import 'package:solutech_sat/ui/screen/refresh_screen.dart';
import 'package:solutech_sat/ui/screen/sales_reports_screen.dart';

class DashboardBloc extends Bloc {
  showNotifications() {}

  openPerformanceReport() {
    navigate(
      screen: PerformanceReportsScreen(),
    );
  }

  void navigateToCustomer() {
    if (sessionManager.inSession) {
      Customer customer =
          routePlansManager.getCustomerById(sessionManager.session.customerId);
      sessionManager.referred = true;
      navigate(
          screen: CustomerScreen(
        customer: customer,
        routePlan: routePlansManager.routePlanById(customer.routeId),
      ));
    }
  }

  void navigateToCheckins(int initialIndex) {
    navigate(
        screen: CheckinsScreen(
      initialIndex: initialIndex,
    ));
  }

  onCloseDay() async {
    if (sessionManager.inSession) {
      bool shouldNavigate = await confirm("You are still checked in",
          "Please checkout from ${routePlansManager.getCustomerById(sessionManager.session.customerId).shopName} first before you continue.");
      if (shouldNavigate) {
        Customer customer = routePlansManager
            .getCustomerById(sessionManager.session.customerId);
        sessionManager.referred = true;
        navigate(
            screen: CustomerScreen(
          customer: customer,
          routePlan: routePlansManager.routePlanById(customer.routeId),
        ));
      }
    } else {
      navigate(
        screen: CloseDayScreen(),
      );
    }
  }

  onOpenDay() {
    navigate(
      screen: OpenDayScreen(),
    );
  }

  void refreshData() async {
    if (syncManager.syncing) return;
    if (connectionManager.isConnected) {
      if (await syncManager.shouldSync) {
        progressDialog.message = "Syncing data...";
        progressDialog.show();
        syncManager.sync().then((data) async {
          progressDialog.hide();
          if (!await syncManager.shouldSync) {
            refreshData();
          } else {
            alert("Sync failed", "Data could not be synced.");
          }
        });
      } else {
        if (!syncManager.syncing) {
          popAndNavigate(
            screen: RefreshScreen(),
          );
        }
      }
    } else {
      alert(
        "No connection",
        "Please make sure you are connected and have data before syncing.",
      );
    }
  }

  @override
  void initState() {
    super.initState();
    sessionManager.resumeSession();
  }
}
