import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:solutech_sat/bloc/intro_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/helpers/permission_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';

class IntroScreen extends StatelessWidget {
  final bloc = IntroBloc();
  Widget _buildPermissionButton() {
    return StreamBuilder(
        stream: permissionManager.stream,
        builder: (context, snapshot) {
          return (permissionManager.shouldAskPermissions())
              ? RaisedButton(
                  color: Color(0xFF01579B),
                  onPressed: bloc.grantPermissions,
                  child: Text(
                    "GRANT PERMISSIONS",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Text(
                  "PERMISSIONS GRANTED",
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
          stream: permissionManager.stream,
          builder: (context, snapshot) {
            return IntroductionScreen(
              pages: [
                PageViewModel(
                  title: "Welcome to SAT",
                  body: "${config.appDescription}",
                  image: Container(
                    color: Colors.white,
                    alignment: AlignmentDirectional.bottomStart,
                    padding: EdgeInsets.all(110.0),
                    child: Center(
                      child: Image.asset(
                        config.appIcon,
                      ),
                    ),
                  ),
                  decoration: PageDecoration(
                    pageColor: config.themeData.primaryColor,
                    titleTextStyle: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    imageFlex: 1,
                    bodyTextStyle: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white70,
                    ),
                    dotsDecorator: DotsDecorator(
                      color: Colors.black54,
                      activeColor: Colors.white,
                    ),
                  ),
                ),
                PageViewModel(
                  title: "Geofencing",
                  body:
                      "The app will inform you when you are near a customer in your route. It may also notify you whether they may buy a product in your inventory.",
                  image: Container(
                    color: Colors.white,
                    alignment: AlignmentDirectional.bottomStart,
                    padding: EdgeInsets.all(20.0),
                    child: Image.asset(
                      "assets/images/geofencing.png",
                    ),
                  ),
                  decoration: PageDecoration(
                    pageColor: Color(0xfff5a81e),
                    titleTextStyle: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    imageFlex: 1,
                    bodyTextStyle: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white70,
                    ),
                    dotsDecorator: DotsDecorator(
                      color: Colors.black54,
                      activeColor: Colors.white,
                    ),
                  ),
                ),
                PageViewModel(
                  title: "App Permissions",
                  body:
                      "${config.appName} requires some permissions to operate properly. Kindly grant all the requested permissions",
                  image: Container(
                    color: Colors.white,
                    child: Image.asset(
                      "assets/images/permissions.png",
                      height: 500.0,
                    ),
                  ),
                  footer: _buildPermissionButton(),
                  decoration: PageDecoration(
                    pageColor: Colors.blue,
                    titleTextStyle: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    bodyTextStyle: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white70,
                    ),
                    dotsDecorator: DotsDecorator(
                      color: Colors.black54,
                      activeColor: Colors.white,
                    ),
                  ),
                )
              ],
              onDone: bloc.onDonePress,
              showSkipButton: true,
              skip: const Text(
                "SKIP",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              next: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              done: permissionManager.shouldAskPermissions()
                  ? Container()
                  : Container(
                      padding: EdgeInsets.all(18.0),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF01579B),
                        shape: BoxShape.circle,
                      ),
                    ),
            );
          }),
    );
  }
}
