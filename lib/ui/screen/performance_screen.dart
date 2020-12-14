import 'dart:io';

import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/performance_bloc.dart';
import 'package:solutech_sat/bloc/records_bloc.dart';
import 'package:solutech_sat/bloc/sales_reports_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/cat.dart';
import 'package:solutech_sat/data/models/monthly_performance.dart';
import 'package:solutech_sat/data/models/performance.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/reports_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class PerformanceScreen extends StatelessWidget {
  final bloc = PerformanceBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text("Performance"),
                actions: <Widget>[
                  IconButton(
                    onPressed: bloc.onRefresh,
                    icon: Icon(
                      Icons.refresh,
                      color: config.contrastColor,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.date_range,
                      color: config.contrastColor,
                    ),
                    onPressed: bloc.filterByDate,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.filter_list,
                      color: config.contrastColor,
                    ),
                    onPressed: bloc.filterByPeriod,
                  ),
                ],
              ),
              body: StreamBuilder(
                stream: reportsManager.stream,
                builder: (context, snapshot) {
                  return Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: CircularMaterialSpinner(
                            loading: reportsManager.loadingPerformance,
                            child: Container(
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: ListView(
                                        children: [
                                          Table(
                                            columnWidths: {
                                              0: FixedColumnWidth(120),
                                            },
                                            children: [
                                              TableRow(children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    top: 10.0,
                                                    bottom: 10.0,
                                                  ),
                                                  child: Text(
                                                    "PRODUCT",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    top: 10.0,
                                                    bottom: 10.0,
                                                  ),
                                                  child: Text(
                                                    "TARGET",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    top: 10.0,
                                                    bottom: 10.0,
                                                  ),
                                                  child: Text(
                                                    "ACHIEVED",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    top: 10.0,
                                                    bottom: 10.0,
                                                  ),
                                                  child: Text(
                                                    "%",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                )
                                              ]),
                                              ...reportsManager.performances
                                                  .map<TableRow>((Performance
                                                      performance) {
                                                var index = reportsManager
                                                    .performances
                                                    .indexOf(performance);
                                                return TableRow(
                                                        decoration: BoxDecoration(
                                                            color: (index + 1) %
                                                                        2 ==
                                                                    0
                                                                ? Colors.white
                                                                : Colors
                                                                    .grey[200]),
                                                        children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: 10.0,
                                                          bottom: 10.0,
                                                        ),
                                                        child: Text(
                                                          "${performance.productDesc}",
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: 10.0,
                                                          bottom: 10.0,
                                                        ),
                                                        child: Text(
                                                          "${performance.target ?? 0}",
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: 10.0,
                                                          bottom: 10.0,
                                                        ),
                                                        child: Text(
                                                          "${performance.achieved ?? 0}",
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: 10.0,
                                                          bottom: 10.0,
                                                        ),
                                                        child: Text(
                                                          "${performance.perfomance ?? 0}",
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ]) /*Container(
                                                      height: 40.0,
                                                      color: ((index + 1) % 2 == 0)
                                                          ? Colors.grey[200]
                                                          : Colors.white,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                        children: <Widget>[
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              "${performance.productDesc}",
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              "${performance.target ?? 0}",
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              "${performance.achieved ?? 0}",
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              "${performance.perfomance ?? 0}",
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )*/
                                                    ;
                                              }).toList(),
                                            ],
                                          ),
                                          /*...reportsManager.performances
                                              .map<Widget>(
                                                  (Performance performance) {
                                            var index = reportsManager
                                                .performances
                                                .indexOf(performance);
                                            return Container(
                                              height: 40.0,
                                              color: ((index + 1) % 2 == 0)
                                                  ? Colors.grey[200]
                                                  : Colors.white,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      "${performance.productDesc}",
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "${performance.target ?? 0}",
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "${performance.achieved ?? 0}",
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "${performance.perfomance ?? 0}",
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          }).toList()*/
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Footer(),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
