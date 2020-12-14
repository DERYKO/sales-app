import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/route_plan.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/screen/customer_screen.dart';
import 'package:solutech_sat/ui/screen/route_plan_details_screen.dart';
import 'package:solutech_sat/ui/screen/route_plans_screen.dart';

class RoutePlansBloc extends Bloc {
  RoutePlan routePlan;

  void onRoutePlanTap(RoutePlan routePlan) {
    print("Route plan ${routePlan.toMap()}");
    navigate(
      screen: RoutePlanDetailsScreen(
        routePlan,
      ),
    );
  }

  void refresh() async {
    if (syncManager.syncing) return;
    if (connectionManager.isConnected) {
      if (await syncManager.shouldSync) {
        progressDialog.message = "Syncing data...";
        progressDialog.show();
        syncManager.sync().then((data) async {
          progressDialog.hide();
          if (!await syncManager.shouldSync) {
            refresh();
          } else {
            alert("Sync failed", "Data could not be synced.");
          }
        });
      } else {
        if (!syncManager.syncing) {
          routePlansManager.loadRoutePlans().then((done) {
            notifyChanges();
          });
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
  }
}
