import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/route_plans_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';

class RoutePlansScreen extends StatelessWidget {
  final bloc = RoutePlansBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Route plans"),
                actions: <Widget>[
                  StreamBuilder(
                      stream: syncManager.stream,
                      builder: (context, snapshot) {
                        return (!syncManager.syncing)
                            ? IconButton(
                                onPressed: bloc.refresh,
                                icon: Icon(
                                  Icons.refresh,
                                ),
                              )
                            : Container();
                      }),
                ],
              ),
              body: Container(
                color: Colors.grey[200],
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: StreamBuilder(
                            stream: routePlansManager.stream,
                            builder: (context, snapshot) {
                              return CircularMaterialSpinner(
                                loading: routePlansManager.loadingRoutePlans,
                                child: ListView.builder(
                                  itemCount:
                                      routePlansManager.routePlans.length,
                                  itemBuilder: (context, index) {
                                    var routePlan =
                                        routePlansManager.routePlans[index];
                                    return GestureDetector(
                                      onTap: () {
                                        bloc.onRoutePlanTap(routePlan);
                                      },
                                      child: Card(
                                        child: Container(
                                          padding: EdgeInsets.all(10.0),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                height: 50.0,
                                                alignment:
                                                    AlignmentDirectional.center,
                                                padding: EdgeInsets.all(10.0),
                                                child: Text(
                                                  "${routePlan.visitDay}",
                                                ),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey[300],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Text(
                                                              "${routePlan.name}"),
                                                          Text(
                                                            "${routePlan.shops}",
                                                            style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Text(
                                                              "${routePlan.frequency}"),
                                                          Text(
                                                              "Week: ${routePlan.visitWeek}"),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey[200],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                      ),
                      Footer(),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
