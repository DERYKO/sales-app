import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/payments_collection_bloc.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/payments_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/contact_buttons.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';

class PaymentsCollectionScreen extends StatelessWidget {
  PaymentsCollectionBloc bloc = PaymentsCollectionBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: FittedBox(
                child: Text("${roleManager.resolveTitle(
                  title: "Payment Collection",
                  module: Roles.PAYMENTS,
                )}"),
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
                      child: ListView.builder(
                        itemCount:
                            paymentsManager.customerIdsFromBalances.length,
                        itemBuilder: (context, index) {
                          int customerId =
                              paymentsManager.customerIdsFromBalances[index];
                          Customer customer =
                              routePlansManager.getCustomerById(customerId);
                          return GestureDetector(
                            onTap: () => bloc.collectPayment(customer),
                            child: Container(
                              width: double.infinity,
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                "${customer.shopName.toUpperCase()}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "${authManager.user.country?.currencyCode} ${paymentsManager.getCustomerBalancesFor(customerId).fold<double>(0.0, (a, b) => a + (double.parse("${b.amount ?? 0}") - double.parse("${b.amountpaid ?? 0}"))).toStringAsFixed(2)} ",
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ContactButtons(
                                                phoneNumber:
                                                    customer.shopPhoneno,
                                                onEditTap: null,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
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
