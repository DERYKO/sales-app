import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/stats_manager.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class RepStats extends StatelessWidget {
  Function onPerformanceReport;
  Function onNavigateToCustomer;
  Function onNavigateToCheckin;
  RepStats(
      {this.onPerformanceReport,
      this.onNavigateToCheckin,
      this.onNavigateToCustomer});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          bottom: 5.0,
        ),
        child: StreamBuilder(
            stream: statsManager.stream,
            builder: (context, snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (!roleManager.hasRole(Roles.CHECK_IN) ||
                      sessionManager.inSession)
                    StreamBuilder(
                        stream: sessionManager.stream,
                        builder: (context, snapshot) {
                          return (roleManager.hasRole(Roles.CHECK_IN) &&
                                  sessionManager.inSession)
                              ? GestureDetector(
                                  onTap: onNavigateToCustomer,
                                  child: Container(
                                    height: 80.0,
                                    width: double.infinity,
                                    padding: EdgeInsets.all(6.0),
                                    color: Theme.of(context).primaryColor,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text(
                                          "CHECKIN: ${formatDate(sessionManager.session.startTime, "jms")}",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            "${sessionManager.timeIn}",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${routePlansManager.getCustomerById(sessionManager.session.customerId)?.shopName}",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 65.0,
                                  padding: EdgeInsets.all(6.0),
                                  color: Theme.of(context).primaryColor,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      StatItem(
                                        value:
                                            "${int.parse("${statsManager.salesSummary?.target ?? 0}")}",
                                        title: "Target",
                                      ),
                                      StatItem(
                                        value:
                                            "${Set.from(sessionManager.sessions.map((session) => session.customerId).toList()).length}",
                                        title: "Actual",
                                      ),
                                      StatItem(
                                        value:
                                            "${statsManager.salesSummary?.success ?? 0}",
                                        title: "Success",
                                      ),
                                      StatItem(
                                        value:
                                            "${double.parse("${statsManager.salesSummary?.performance ?? 0.0}").toStringAsFixed(2) == "NaN" ? 0 : double.parse("${statsManager.salesSummary?.performance ?? 0.0}").toStringAsFixed(2)}%",
                                        title: "Performance",
                                        onTap: onPerformanceReport,
                                      ),
                                    ],
                                  ),
                                );
                        }),
                  Container(
                    height: roleManager.hasRole(Roles.CHECK_IN) ? 60 : 65.0,
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        (roleManager.hasRole(Roles.CHECK_IN))
                            ? Expanded(
                                child: GestureDetector(
                                  onTap: () => onNavigateToCheckin(0),
                                  child: FutureBuilder(
                                      future: routePlansManager.getCustomers(
                                        routePlansManager.currentRoutePlan?.id,
                                      ),
                                      builder: (context,
                                          AsyncSnapshot<List<Customer>>
                                              snapshot) {
                                        return StatItem(
                                          value: "${snapshot.data.length ?? 0}",
                                          title: "To Visit",
                                          valueColor:
                                              Theme.of(context).primaryColor,
                                          titleColor: Colors.black,
                                        );
                                      }),
                                ),
                              )
                            : Expanded(
                                child: StatItem(
                                  value:
                                      "${authManager.user.country?.currencyCode} ${formatCurrency(double.parse("${statsManager.salesSummary?.targetValue ?? 0}"))}",
                                  title: "Target Sales",
                                  valueColor: Theme.of(context).primaryColor,
                                  titleColor: Colors.black,
                                ),
                              ),
                        Container(
                          width: 1.0,
                          color: Colors.black,
                        ),
                        (roleManager.hasRole(Roles.CHECK_IN))
                            ? Expanded(
                                child: GestureDetector(
                                  onTap: () => onNavigateToCheckin(1),
                                  child: StatItem(
                                    value:
                                        "${Set.from(sessionManager.sessions.map((session) => session.customerId).toList()).length}",
                                    title: "Visited",
                                    valueColor: Colors.green,
                                    titleColor: Colors.black,
                                  ),
                                ),
                              )
                            : Expanded(
                                child: StatItem(
                                  value:
                                      "${authManager.user.country?.currencyCode} ${formatCurrency(double.parse("${statsManager.salesSummary?.totalSales ?? 0}"))}",
                                  title: "Achieved",
                                  valueColor: Colors.green,
                                  titleColor: Colors.black,
                                ),
                              ),
                      ],
                    ),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        offset: Offset(2, 1),
                      )
                    ]),
                  )
                ],
              );
            }));
  }
}

class StatItem extends StatelessWidget {
  String title;
  String value;
  Color valueColor;
  Color titleColor;
  Function onTap;
  StatItem({
    @required this.title,
    @required this.value,
    this.valueColor,
    this.titleColor,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(2.0),
              child: AutoSizeText(
                "$value",
                style: TextStyle(
                  color: valueColor ?? config.contrastColor,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            AutoSizeText(
              "$title",
              style: TextStyle(
                fontSize: 13.0,
                color: titleColor ?? config.contrastColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
