import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/refresh_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/screen/dashboard_screen.dart';
import 'package:solutech_sat/ui/screen/login_screen.dart';
import 'package:solutech_sat/ui/screen/old_version_screen.dart';
import 'package:solutech_sat/ui/screen/refresh_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class OldVersionBloc extends Bloc {
  void refreshApp() {
    popAndNavigate(screen: RefreshScreen());
  }

  void updateApp() {
    launch(
        "https://play.google.com/store/apps/details?id=com.solutech.sat.solutech_sat");
  }

  @override
  void initState() {
    super.initState();
  }
}
