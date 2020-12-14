import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/dashboard_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/ui/widgets/modules.dart';
import 'package:solutech_sat/ui/widgets/rep_stats.dart';
import 'package:solutech_sat/ui/widgets/sat_drawer.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class DashboardScreen extends StatelessWidget {
  DashboardBloc bloc = DashboardBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text("${config.appName}"),
          actions: <Widget>[
            StreamBuilder(
                stream: syncManager.stream,
                builder: (context, snapshot) {
                  return (!syncManager.syncing)
                      ? IconButton(
                          onPressed: bloc.refreshData,
                          icon: Icon(
                            Icons.refresh,
                          ),
                        )
                      : Container();
                }),
            IconButton(
              onPressed: bloc.showNotifications,
              icon: Icon(
                Icons.notifications,
                color: config.contrastColor,
              ),
            )
          ],
        ),
        drawer: SatDrawer(),
        body: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return Container(
              color: Colors.grey[200],
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: <Widget>[
                  RepStats(
                    onPerformanceReport: bloc.openPerformanceReport,
                    onNavigateToCustomer: bloc.navigateToCustomer,
                    onNavigateToCheckin: bloc.navigateToCheckins,
                  ),
                  Expanded(
                    child: Modules(),
                  ),
                  if (!dayManager.openedDay)
                    Container(
                      padding:
                          EdgeInsets.all(5.0).copyWith(right: 10.0, left: 10.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Text(
                                "You have not yet started your day",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: bloc.onOpenDay,
                            color: Colors.green,
                            textColor: Colors.white,
                            child: Text(
                              "START DAY",
                            ),
                          ),
                        ],
                      ),
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          offset: Offset(1.0, -1),
                          color: Colors.grey[300],
                        )
                      ]),
                    ),
                  if (!dayManager.closedDay && dayManager.openedDay)
                    Container(
                      padding:
                          EdgeInsets.all(5.0).copyWith(right: 10.0, left: 10.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Text(
                                "You started your day at ${formatDate(dayManager.openDayTime, "jm")}",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: bloc.onCloseDay,
                            color: Colors.red,
                            textColor: Colors.white,
                            child: Text(
                              "CLOSE DAY",
                            ),
                          ),
                        ],
                      ),
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          offset: Offset(1.0, -1),
                          color: Colors.grey[300],
                        )
                      ]),
                    ),
                  if (dayManager.closedDay)
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          "You closed your day at ${formatDate(dayManager.closeDayTime, "jm")}",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          offset: Offset(1.0, -1),
                          color: Colors.grey[300],
                        )
                      ]),
                    ),
                  Footer(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
