import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/old_version_bloc.dart';
import 'package:solutech_sat/bloc/refresh_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/ui/widgets/refresh_loader.dart';

class OldVersionScreen extends StatelessWidget {
  final bloc = OldVersionBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
        body: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Image.asset(
                              config.appIcon,
                              height: config.appIconSize.splash,
                              width: config.appIconSize.splash,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "APP IS OUTDATED",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10.0,
                            ),
                            child: Text(
                              "Hi you are on version ${config.appVersion}. We have made some improvements and we want you to update your app to version ${settingsManager.updateProfile.appversion}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // if (authManager.isLoggedIn)
                              Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: MaterialButton(
                                  onPressed: bloc.refreshApp,
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  child: Text("REFRESH"),
                                ),
                              ),
                              MaterialButton(
                                onPressed: bloc.updateApp,
                                color: Colors.green,
                                textColor: Colors.white,
                                child: Text("UPDATE APP"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Footer(),
                ],
              ),
              width: double.infinity,
              height: double.infinity,
            );
          },
        ),
      ),
    );
  }
}
