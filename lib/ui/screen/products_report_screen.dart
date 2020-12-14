import 'dart:io';

import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/products_report_bloc.dart';
import 'package:solutech_sat/bloc/records_bloc.dart';
import 'package:solutech_sat/bloc/sales_reports_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/monthly_performance.dart';
import 'package:solutech_sat/data/models/sku.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/reports_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class ProductsReportScreen extends StatelessWidget {
  ProductsReportBloc bloc;
  ProductsReportScreen({
    String category,
    List<DateTime> pickedDates,
  }) : bloc = ProductsReportBloc(
          category: category,
          pickedDates: pickedDates,
        );
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
                title: Text("${bloc.category}"),
                actions: <Widget>[
                  IconButton(
                    onPressed: reportsManager.loadMonthlyPerformance,
                    icon: Icon(
                      Icons.refresh,
                      color: config.contrastColor,
                    ),
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
                            loading: reportsManager.loadingSkusByCategory,
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "PRODUCT",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "QUANTITY",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "TOTAL",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ...reportsManager.skusByCategory
                                      .map<Widget>((Sku sku) {
                                    var index = reportsManager.skusByCategory
                                        .indexOf(sku);
                                    return Container(
                                      color: ((index + 1) % 2 == 0)
                                          ? Colors.grey[200]
                                          : Colors.white,
                                      padding: EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              "${sku.productDesc}",
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${sku.quantity}",
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${formatCurrency(double.parse("${sku.totalSales ?? 0}"))}",
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList()
                                ],
                              ),
                            ) /*ListView.builder(
                              itemCount: reportsManager.monthlyPerformance.length,
                              itemBuilder: (context, index) {
                                var skipRecord =
                                reportsManager.monthlyPerformance[index];
                                return ;
                              },
                            )*/
                            ,
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
