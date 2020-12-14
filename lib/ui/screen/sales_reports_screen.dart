import 'dart:io';

import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/records_bloc.dart';
import 'package:solutech_sat/bloc/sales_reports_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/cat.dart';
import 'package:solutech_sat/data/models/monthly_performance.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/reports_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class SalesReportsScreen extends StatelessWidget {
  final bloc = SalesReportsBloc();
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
                title: Text("Sales report"),
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
                            loading: reportsManager.loadingCatlist,
                            child: Container(
                              padding:
                                  EdgeInsets.all(10.0).copyWith(right: 0.0),
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: ListView(
                                        children: [
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    "CATEGORY",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "QUANTITY",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "TOTAL",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ...reportsManager.catList
                                              .map<Widget>((Cat category) {
                                            var index = reportsManager.catList
                                                .indexOf(category);
                                            return GestureDetector(
                                              onTap: () =>
                                                  bloc.openProductsReport(
                                                      category.productCategory),
                                              child: Container(
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
                                                        "${category.productCategory}",
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${category.quantity}",
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${formatCurrency(double.parse(category.totalSales))}",
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList()
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: 10.0,
                                        right: 10.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              "TOTAL",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "${formatCurrency(double.parse("${reportsManager.catList.fold(0, (total, b) => total + double.parse("${b.totalSales ?? 0}"))}"))}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
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
