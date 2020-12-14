import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/permission_manager.dart';
import 'package:solutech_sat/helpers/setup_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/screen/login_screen.dart';

class IntroBloc extends Bloc {
  void onDonePress() async {
    if (!permissionManager.shouldAskPermissions()) {
      await locationManager.init();
      setupManager.setIsFirstTime(false);
      popAndNavigate(
        screen: LoginScreen(),
      );
    } else {
      print("SHOULD_ASK_PERMISSION");
    }
  }

  void grantPermissions() {
    permissionManager.grantPermissions();
  }

  @override
  void initState() {
    permissionManager.checkPermissions();
  }
}
