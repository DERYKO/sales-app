import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/performance_reports_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/monthly_performance.dart';
import 'package:solutech_sat/helpers/reports_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class PerformanceReportsScreen extends StatelessWidget {
  final bloc = PerformanceReportsBloc();
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
                title: Text("Performance reports"),
                actions: <Widget>[
                  IconButton(
                    onPressed: bloc.loadData,
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
                            loading: reportsManager.loadingMonthlyPerformance,
                            child: Container(
                              padding:
                                  EdgeInsets.all(10.0).copyWith(right: 0.0),
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            "DATE",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "TARGET",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "ACHIEVED",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "%",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "COMM",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ...reportsManager.monthlyPerformance
                                      .map<Widget>(
                                          (MonthlyPerformance performance) {
                                    var index = reportsManager
                                        .monthlyPerformance
                                        .indexOf(performance);
                                    return Container(
                                      height: 40.0,
                                      color: ((index + 1) % 2 == 0)
                                          ? Colors.grey[200]
                                          : Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Expanded(
                                            child: AutoSizeText(
                                              "${performance.yearMonth}",
                                              minFontSize: 8,
                                              maxFontSize: 10.0,
                                            ),
                                          ),
                                          Container(
                                            width: 2.0,
                                          ),
                                          Expanded(
                                            child: AutoSizeText(
                                              "${formatCurrency(double.parse("${performance.targetValue ?? 0}"))}",
                                              minFontSize: 8,
                                              maxFontSize: 10.0,
                                            ),
                                          ),
                                          Container(
                                            width: 2.0,
                                          ),
                                          Expanded(
                                            child: AutoSizeText(
                                              "${formatCurrency(double.parse("${performance.totalCost ?? 0}"))}",
                                              minFontSize: 8,
                                              maxFontSize: 10.0,
                                            ),
                                          ),
                                          Container(
                                            width: 2.0,
                                          ),
                                          Expanded(
                                            child: AutoSizeText(
                                              "${double.parse("${performance.salerPerformance ?? 0}").toStringAsFixed(2)}%",
                                              minFontSize: 8,
                                              maxFontSize: 10.0,
                                            ),
                                          ),
                                          Expanded(
                                            child: AutoSizeText(
                                              "${performance.commission}",
                                              minFontSize: 8,
                                              maxFontSize: 10.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList()
                                ],
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
