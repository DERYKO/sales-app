import 'package:dio/dio.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/screen/customer_screen.dart';
import 'package:solutech_sat/ui/screen/etr_printer_screen.dart';
import 'package:solutech_sat/ui/screen/login_screen.dart';
import 'package:solutech_sat/ui/screen/pricelists_screen.dart';
import 'package:solutech_sat/ui/screen/refresh_screen.dart';
import 'package:solutech_sat/ui/screen/setup_screen.dart';

class SatDrawerBloc extends Bloc {
  logout() async {
    if (!await confirm("Logout?", "This will log you out of the app.")) {
      return;
    }
    if (connectionManager.isConnected) {
      if (await syncManager.shouldSync) {
        progressDialog.message = "Syncing data...";
        progressDialog.show();
        syncManager.sync().then((data) async {
          progressDialog.hide();
          pop();
          if (!await syncManager.shouldSync) {
            logout();
          }
        });
      } else {
        bool isLoggedOut = await authManager.logout();
        if (isLoggedOut) {
          pop();
          popAndNavigate(
            screen: LoginScreen(),
          );
        }
      }
    } else {
      alert(
        "No connection",
        "Please make sure you are connected and have data before syncing.",
      );
    }
    //}
  }

  void sendLiveLocation() async {
    if (connectionManager.isConnected) {
      progressDialog.message = "Sending location";
      progressDialog.show();
      locationManager.sendLiveLocation().then((response) {
        progressDialog.hide();
        if (response.data["status"] == 1) {
          alert("Successfully sent", "${response.data["message"]}",
              onOk: () => pop());
        } else {
          alert("Unsuccessful", "${response.data["message"]}",
              onOk: () => pop());
        }
      }).catchError((error) {
        progressDialog.hide();
        print(error);
        alert("Unsuccessful", "Something went wrong");
      });
    } else {
      alert("You are offline", "Make sure you enable data then tap on refresh");
    }
  }

  void etrPrinter() {
    navigate(screen: EtrPrinterScreen());
  }

  void priceLists() {
    navigate(screen: PricelistsScreen());
  }

  @override
  void initState() {
    super.initState();
  }
}
