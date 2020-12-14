import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/deliveries_bloc.dart';
import 'package:solutech_sat/bloc/posm_bloc.dart';
import 'package:solutech_sat/bloc/pricelists_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/delivery.dart';
import 'package:solutech_sat/data/models/posm.dart';
import 'package:solutech_sat/data/models/scheduled_delivery.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/deliveries_manager.dart';
import 'package:solutech_sat/helpers/posm_manager.dart';
import 'package:solutech_sat/helpers/pricelist_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/stock_takes_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/filled_dropdown_button.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class StockTakesScreen extends StatelessWidget {
  final bloc = PricelistsBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                title: Text("${roleManager.resolveTitle(
                  title: "Stock Takes",
                  module: Roles.STOCK_TAKING,
                  capitalize: true,
                )}"),
              ),
              body: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Container(
                          child: ListView.builder(
                              itemCount: stockTakesManager.stockTakes.length,
                              itemBuilder: (context, index) {
                                var stockTake =
                                    stockTakesManager.stockTakes[index];
                                return CustomExpansionTile(
                                  title: Container(
                                    height: 50.0,
                                    padding: EdgeInsets.all(5.0),
                                    width: double.infinity,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10.0,
                                              ),
                                              child: Icon(
                                                Icons.done_all,
                                                color: (stockTake.synced)
                                                    ? Colors.green
                                                    : Colors.grey,
                                                size: 16.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              "${routePlansManager.getCustomerById(stockTake.outletId)?.shopName}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              "${formatDate("${stockTake.entryTime}", "dt")}",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[100],
                                            offset: Offset(0, -1),
                                          ),
                                        ]),
                                  ),
                                  children: [
                                    Container(),
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 10.0,
                                      ),
                                      child: Column(children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 5.0,
                                            bottom: 5.0,
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 4,
                                                child: Text(
                                                  "PRODUCT",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "QTY",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ...stockTakesManager.stockTakeItems
                                            .where((stockTakeItem) =>
                                                stockTakeItem.stockTakeId ==
                                                stockTake.id)
                                            .map((stockTakeItem) {
                                          var index = stockTakesManager
                                              .stockTakeItems
                                              .indexOf(stockTakeItem);
                                          return Container(
                                            padding: EdgeInsets.only(
                                              left: 5.0,
                                              top: 10.0,
                                              bottom: 10.0,
                                            ),
                                            color: (index + 1) % 2 == 0
                                                ? Colors.white
                                                : Colors.grey[100],
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 4,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      right: 10.0,
                                                      top: 5.0,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          "${commonsManager.productById(stockTakeItem.productId)?.productDesc?.toUpperCase() ?? ""}",
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "${stockTakeItem.quantity} pcs",
                                                    style: TextStyle(
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ]),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ),
                    ),
                    Footer(),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
