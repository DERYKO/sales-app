import 'package:flutter/material.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';

class ConnectionStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: connectionManager.stream,
        builder: (context, snapshot) {
          return AnimatedContainer(
            duration: Duration(
              milliseconds: 100,
            ),
            padding: EdgeInsets.all(5),
            height: connectionManager.isConnected ? 0.0 : 35.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.white,
                ),
                Container(
                  width: 10.0,
                ),
                Text(
                  "YOU ARE ${connectionManager.isOnline ? "ONLINE" : "OFFLINE"}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
                color: connectionManager.isOnline ? Colors.green : Colors.red,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(1, 1),
                    color: Colors.grey,
                  )
                ]),
          );
        });
  }
}
