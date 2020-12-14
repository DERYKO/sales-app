import 'dart:io';

import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/customer_balances_bloc.dart';
import 'package:solutech_sat/bloc/posm_audit_bloc.dart';
import 'package:solutech_sat/bloc/records_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/helpers/brands_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/payments_manager.dart';
import 'package:solutech_sat/helpers/posm_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/filled_dropdown_button.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class CustomerBalancesScreen extends StatelessWidget {
  CustomerBalancesBloc bloc;
  CustomerBalancesScreen({
    @required Customer customer,
  })  : bloc = CustomerBalancesBloc(customer: customer),
        assert(customer != null);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FittedBox(
                    child: Text("${roleManager.resolveTitle(
                      title: "COLLECT PAYMENT",
                      module: Roles.PAYMENTS,
                      capitalize: true,
                    )}"),
                  ),
                  Text(
                    "${bloc.customer.shopName.toUpperCase()}",
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            body: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      child: ListView(children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5.0,
                            right: 5.0,
                            bottom: 5.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "INVOICE",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "PAID",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Text(
                                  "BALANCE",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...paymentsManager
                            .getCustomerBalancesFor(bloc.customer.id)
                            .map((customerBalance) {
                          var index = paymentsManager
                              .getCustomerBalancesFor(bloc.customer.id)
                              .indexOf(customerBalance);
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
                                  flex: 3,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: 10.0,
                                      top: 5.0,
                                    ),
                                    child: Text(
                                      "${customerBalance.orderId}",
                                      style: TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "${customerBalance.amountpaid ?? 0}",
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: Text(
                                    "${double.parse("${customerBalance.amount ?? 0}") - double.parse("${customerBalance.amountpaid ?? 0}")}",
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "TOTAL",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "${paymentsManager.getCustomerBalancesFor(bloc.customer.id).fold<double>(0.0, (a, b) => a + (double.parse("${b.amount ?? 0}") - double.parse("${b.amountpaid ?? 0}"))).toStringAsFixed(2)}",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: MaterialButton(
                            height: 40.0,
                            textColor: Colors.white,
                            color: Theme.of(context).accentColor,
                            onPressed: bloc.collectPayment,
                            child: Text("COLLECT PAYMENT"),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  Footer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
