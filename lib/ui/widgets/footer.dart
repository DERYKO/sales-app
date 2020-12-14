import 'package:flutter/material.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        StreamBuilder(
          stream: syncManager.stream,
          builder: (context, snapshot) {
            return (syncManager.syncing)
                ? Container(
                    height: 3.0,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey[200],
                    ),
                  )
                : Container();
          },
        ),
        StreamBuilder(
            stream: connectionManager.stream,
            builder: (context, snapshot) {
              return Container(
                child: Align(
                  alignment: AlignmentDirectional.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      /* Icon(
                        Icons.brightness_1,
                        size: 10.0,
                        color: connectionManager.isOnline
                            ? Colors.green
                            : Colors.red,
                      ),*/
                      StreamBuilder(
                          stream: locationManager.stream,
                          builder: (context, snapshot) {
                            return Container(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Powered by Solutech Limited ${config.appVersion}. ",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: config.contrastColor,
                                    ),
                                  ),
                                  Text(
                                    " Ac. ${locationManager?.position?.accuracy?.toStringAsFixed(2) ?? ""} m",
                                    style: TextStyle(
                                      color: config.contrastColor,
                                      fontSize: 10.0,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                color: connectionManager.isConnected
                    ? Theme.of(context).primaryColor
                    : Colors.black54,
                width: MediaQuery.of(context).size.width,
              );
            }),
      ],
    );
  }
}
