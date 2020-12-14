import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solutech_sat/bloc/open_day_bloc.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/connection_status.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/utils/device_utils.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class OpenDayScreen extends StatelessWidget {
  final bloc = OpenDayBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarOpacity: 1.0,
          elevation: 0.0,
          title: Text(
            "START DAY",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              ConnectionStatus(),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Container(
                    padding: EdgeInsets.all(
                      20.0,
                    ).copyWith(
                      top: 20.0,
                      bottom: 0.0,
                    ),
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Hello, ${authManager.user.name.split(" ")[0]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 21.0,
                                ),
                              ),
                              Text(
                                "It is now ${formatDate(DateTime.now(), "jm")}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        FutureBuilder(
                          future: battery.batteryLevel,
                          builder: (context, snapshot) {
                            return (snapshot.data != null)
                                ? Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          "Battery level",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 20.0),
                                        child: Text(
                                          "${snapshot.data}%",
                                          style: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        int.parse("${snapshot.data}") > 50
                                            ? Icons.check_circle
                                            : Icons.cancel,
                                        color: int.parse("${snapshot.data}") >
                                                70
                                            ? Colors.green
                                            : int.parse("${snapshot.data}") > 50
                                                ? Colors.orange
                                                : Colors.red,
                                      ),
                                    ],
                                  )
                                : Container();
                          },
                        ),
                        if (locationManager.position != null)
                          Container(
                            margin: EdgeInsets.only(
                              top: 10.0,
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "GPS Accuracy",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 20.0),
                                  child: Text(
                                    "${locationManager.position.accuracy.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                Icon(
                                  locationManager.position.accuracy < 200
                                      ? Icons.check_circle
                                      : Icons.cancel,
                                  color: locationManager.position.accuracy < 200
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ],
                            ),
                          ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Route",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 20.0),
                                  child: Text(
                                    "${routePlansManager.currentRoutePlan?.name ?? ""}",
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                              Icon(
                                routePlansManager.currentRoutePlan != null
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color:
                                    routePlansManager.currentRoutePlan != null
                                        ? Colors.green
                                        : Colors.red,
                              ),
                            ],
                          ),
                        ),
                        if (roleManager.hasRole(Roles.USE_ODOMETER))
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: TextFormField(
                              controller: bloc.odometerCtrl,
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: "What is your odometer reading?",
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: TextFormField(
                            controller: bloc.commentsCtrl,
                            maxLines: 5,
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              labelText: "Is everything okay?",
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: StreamBuilder(
                              stream: dayManager.stream,
                              builder: (context, snapshot) {
                                return StreamBuilder(
                                    stream: connectionManager.stream,
                                    builder: (context, snapshot) {
                                      return MaterialButton(
                                        elevation: (dayManager.openingDay ||
                                                !connectionManager.isConnected)
                                            ? 0.0
                                            : 2.0,
                                        disabledColor: Color(0xFFdfdfdf),
                                        onPressed: (dayManager.openingDay ||
                                                !connectionManager.isConnected)
                                            ? null
                                            : bloc.openDay,
                                        child: CircularMaterialSpinner(
                                          loading: dayManager.openingDay,
                                          color: Colors.grey,
                                          width: 25.0,
                                          height: 25.0,
                                          strokeWidth: 4.0,
                                          child: Text(
                                            "START DAY",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        color: (dayManager.openingDay ||
                                                !connectionManager.isConnected)
                                            ? Color(0xFFdfdfdf)
                                            : Theme.of(context).accentColor,
                                        height: 45.0,
                                        minWidth:
                                            MediaQuery.of(context).size.width,
                                      );
                                    });
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
