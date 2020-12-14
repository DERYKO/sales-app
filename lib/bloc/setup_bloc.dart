import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/helpers/setup_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/screen/intro_screen.dart';
import 'package:solutech_sat/ui/screen/login_screen.dart';

class SetupBloc extends Bloc {
  navigateToLogin() async {
    popAndNavigate(screen: LoginScreen());
  }

  navigateToIntroScreen() async {
    popAndNavigate(screen: IntroScreen());
  }

  void changeClient(String clientCode) async {
    var success = await config.setVariant(clientCode);
    if (!success) {
      showToast("No client exists for the code $clientCode");
    } else {
      if (setupManager.isFirstTime) {
        navigateToIntroScreen();
      } else {
        navigateToLogin();
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }
}
