import 'package:flutter/material.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/ui/widgets/connection_status.dart';

class LoginPageHeader extends StatelessWidget {
  Function onSetupClient;
  LoginPageHeader({@required this.onSetupClient});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: connectionManager.stream,
        builder: (context, snapshot) {
          return Container(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 24.0,
                  color: Colors.transparent,
                ),
                ConnectionStatus(),
                Container(
                  margin: EdgeInsets.only(
                      top: connectionManager.isConnected ? 80.0 : 40.0,
                      bottom: 20.0),
                  width: double.infinity,
                  child: Center(
                    child: GestureDetector(
                      onLongPress: onSetupClient,
                      child: Hero(
                        tag: "logo",
                        child: Container(
                          child: Image.asset(
                            config.appIcon,
                            height: config.appIconSize.login,
                            width: config.appIconSize.login,
                            color: connectionManager.isConnected
                                ? Colors.transparent
                                : Colors.white,
                            colorBlendMode: BlendMode.hue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      config.appName,
                      style: Theme.of(context).textTheme.headline.copyWith(
                          color: connectionManager.isConnected
                              ? Theme.of(context).accentColor
                              : Colors.black54),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
