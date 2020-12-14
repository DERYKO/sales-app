import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/refresh_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/screen/dashboard_screen.dart';
import 'package:solutech_sat/ui/screen/login_screen.dart';
import 'package:solutech_sat/ui/screen/old_version_screen.dart';

class RefreshBloc extends Bloc {
  _navigateToDashboard() {
    popAndNavigate(screen: DashboardScreen());
  }

  void onDeactivated() {
    popAndNavigate(screen: LoginScreen());
    alert(
      "Account deactivated",
      "Your account has been activated. Contact your supervisor for assistance.",
    );
  }

  void onOldVersion() {
    popAndNavigate(screen: OldVersionScreen());
  }

  void onLogout() {
    authManager.logout();
    popAndNavigate(screen: LoginScreen());
  }

  @override
  void initState() {
    super.initState();
    locationManager.init();
    refreshManager.onDeactivated = onDeactivated;
    refreshManager.onOldVersion = onOldVersion;
    refreshManager.start();
    refreshManager.stream.listen((data) {
      if (refreshManager.step == 3) {
        _navigateToDashboard();
      }
    });
  }
}
