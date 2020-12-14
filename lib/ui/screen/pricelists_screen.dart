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
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/filled_dropdown_button.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class PricelistsScreen extends StatelessWidget {
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
                title: Text("Pricelists"),
              ),
              body: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Column(
                          children: <Widget>[
                            FilledDropdownButton(
                              padding: EdgeInsets.all(10.0),
                              isDense: true,
                              value: bloc.pricelist,
                              label: "Pricelist",
                              hint: "Select pricelist",
                              items: priceListsManager.uniquePriceLists
                                  .map((priceList) {
                                return DropdownMenuItem(
                                  child: Text("${priceList.pricelistName}"),
                                  value: priceList,
                                );
                              }).toList(),
                              onChange: (value) {
                                bloc.onPriceListChange(value);
                              },
                            ),
                            Expanded(
                              child: Container(
                                child: ListView.builder(
                                    itemCount: priceListsManager
                                        .getPriceListOfAssignedProducts(
                                            bloc.pricelist)
                                        .length,
                                    itemBuilder: (context, index) {
                                      var price = priceListsManager
                                          .getPriceListOfAssignedProducts(
                                              bloc.pricelist)[index];
                                      return Container(
                                        color: (index % 2 == 0)
                                            ? Colors.white
                                            : Colors.grey[100],
                                        padding: EdgeInsets.all(10.0),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                "${bloc.getProduct(index).productDesc}",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "CTN ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                      Text(
                                                          "${price.priceCrtns}"),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "PCS ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.orange,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${price.pricePkts}",
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            )
                          ],
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
