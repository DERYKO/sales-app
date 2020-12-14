import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/app_bloc.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/shared/translations.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/screen/splash_screen.dart';
import 'config.dart';
import 'helpers/setup_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupManager.init();
  runApp(App());
}

class App extends StatelessWidget {
  final AppBloc bloc = AppBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
        bloc: bloc,
        child: StreamBuilder(
          stream: config.stream,
          builder: (context, snapshot) {
            return StreamBuilder(
                stream: locationManager.stream,
                builder: (context, snapshot) {
                  return (locationManager.serviceEnabled)
                      ? MaterialApp(
                          /*localizationsDelegates: [
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                      ],*/
                          debugShowCheckedModeBanner: false,
                          supportedLocales: translations.supportedLocales(),
                          title: config.appName,
                          theme: config.themeData,
                          home: SplashScreen(),
                        )
                      : MaterialApp(
                          /*localizationsDelegates: [
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                      ],*/
                          debugShowCheckedModeBanner: false,
                          supportedLocales: translations.supportedLocales(),
                          title: config.appName,
                          theme: config.themeData,
                          home: Scaffold(
                            body: Container(
                              padding: EdgeInsets.only(left: 20.0, right: 20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/images/location-off.png",
                                      height: 100.0,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      "LOCATION NOT ENABLED",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "The app cannot work without location enabled. Please enable location to be able to work on the app.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: MaterialButton(
                                      onPressed:
                                          locationManager.enableLocationService,
                                      color: Theme.of(context).primaryColor,
                                      textColor: Colors.white,
                                      child: Text("ENABLE LOCATION"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                });
          },
        ));
  }
}
