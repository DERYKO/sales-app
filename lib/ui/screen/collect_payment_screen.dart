import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solutech_sat/bloc/add_stock_bloc.dart';
import 'package:solutech_sat/bloc/collect_payment_bloc.dart';
import 'package:solutech_sat/bloc/sale_order_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/route_plan.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/payments_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/stockpoints_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/filled_dropdown_button.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/ui/widgets/screen.dart';
import 'package:solutech_sat/ui/widgets/screen_stepper.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CollectPaymentScreen extends StatelessWidget {
  CollectPaymentBloc bloc;
  CollectPaymentScreen({
    @required Customer customer,
  }) {
    bloc = CollectPaymentBloc(customer: customer);
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return WillPopScope(
              child: Scaffold(
                appBar: AppBar(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FittedBox(
                        child: Text("Collect Payment"),
                      ),
                      Text(
                        "${bloc.customer?.shopName}",
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
                body: Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: double.infinity,
                  child: ScreenStepper(
                    currentScreen: bloc.currentScreen,
                    showSave: (bloc.currentScreen == 0) ? true : false,
                    screens: <Widget>[
                      ListView(children: [
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
                              right: 10.0,
                              bottom: 10.0,
                            ),
                            color: (index + 1) % 2 == 0
                                ? Colors.white
                                : Colors.grey[100],
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          right: 10.0,
                                          top: 5.0,
                                        ),
                                        child: Text(
                                          "${customerBalance.orderId}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${customerBalance.amount ?? 0}",
                                        textAlign: TextAlign.end,
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
                                        "${customerBalance.amountpaid ?? 0}",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 10.0,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text("Balance:"),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "${double.parse("${customerBalance.amount ?? 0}") - double.parse("${customerBalance.amountpaid ?? 0}")}",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: TextFormField(
                                    controller: bloc.amountControllers[index],
                                    decoration: InputDecoration(
                                      labelText: "Amount",
                                      filled: true,
                                      isDense: true,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ]),
                      Column(
                        children: <Widget>[
                          Expanded(
                            child: SingleChildScrollView(
                              child: Container(
                                color: Colors.grey[100],
                                child: Column(
                                  children: <Widget>[
                                    Card(
                                      child: Container(
                                        padding: EdgeInsets.all(10.0),
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              height: 30.0,
                                              color: Colors.white,
                                              margin: EdgeInsets.only(
                                                  bottom: 10.0, top: 10.0),
                                              child: Center(
                                                child: Text(
                                                  "${authManager.user.country?.currencyCode} ${bloc.balanceTotal()}",
                                                  style: TextStyle(
                                                    fontSize: 28.0,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Divider(),
                                            FilledDropdownButton(
                                              isDense: true,
                                              value: bloc.paymentMode,
                                              label: "Payment mode",
                                              hint: "Payment",
                                              items: commonsManager.paymentModes
                                                  .where((paymentMode) =>
                                                      paymentMode.slug !=
                                                      "credit")
                                                  .map((payment) {
                                                return DropdownMenuItem(
                                                  child: Text(
                                                      "${payment.paymentMode}"),
                                                  value: payment,
                                                );
                                              }).toList(),
                                              onChange: (value) {
                                                bloc.onPaymentModeChanged(
                                                    value);
                                              },
                                            ),
                                            Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    "Collected Amount",
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${bloc.collectedAmountTotal()}",
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (double.parse(
                                                    "${bloc.collectedAmountTotal()}") <
                                                double.parse(
                                                    "${bloc.balanceTotal()}"))
                                              Column(
                                                children: <Widget>[
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text(
                                                          "Balance",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 5.0,
                                                          ),
                                                          child: Text(
                                                              "${double.parse("${bloc.balanceTotal()}") - double.parse("${bloc.collectedAmountTotal()}")}"),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 5.0),
                                                    child: Stack(
                                                      children: <Widget>[
                                                        TextFormField(
                                                          controller: bloc
                                                              .nextPaymentDateCtrl,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: true,
                                                            filled: true,
                                                            labelText:
                                                                "Next payment",
                                                            hintText:
                                                                "Select next payment",
                                                            suffixIcon: Icon(
                                                              Icons.date_range,
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: bloc
                                                              .pickNextPaymentDate,
                                                          child: Container(
                                                            color: Colors
                                                                .transparent,
                                                            height: 50.0,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            if (bloc.paymentMode?.slug !=
                                                "cash")
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 5.0),
                                                child: StreamBuilder(
                                                    stream:
                                                        paymentsManager.stream,
                                                    builder:
                                                        (context, snapshot) {
                                                      return Stack(
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              if (paymentsManager
                                                                          .mpesaPayments
                                                                          .length >
                                                                      0 ||
                                                                  paymentsManager
                                                                      .loadingMpesaPayments)
                                                                Expanded(
                                                                  child:
                                                                      FilledDropdownButton(
                                                                    loading:
                                                                        paymentsManager
                                                                            .loadingMpesaPayments,
                                                                    isDense:
                                                                        true,
                                                                    label:
                                                                        "Payment reference",
                                                                    hint:
                                                                        "Reference",
                                                                    value: bloc
                                                                        .mpesaPayment,
                                                                    onTap: bloc
                                                                        .pickMpesaPayment,
                                                                    items: paymentsManager
                                                                        .mpesaPayments
                                                                        .map(
                                                                            (mpesaPayment) {
                                                                      return DropdownMenuItem(
                                                                        child:
                                                                            Text(
                                                                          "${mpesaPayment.transactionreference}",
                                                                        ),
                                                                        value:
                                                                            mpesaPayment,
                                                                      );
                                                                    }).toList(),
                                                                    onChange:
                                                                        (value) {
                                                                      bloc.onMpesaPaymentChanged(
                                                                          value);
                                                                    },
                                                                  ),
                                                                ),
                                                              if (paymentsManager
                                                                          .mpesaPayments
                                                                          .length ==
                                                                      0 &&
                                                                  !paymentsManager
                                                                      .loadingMpesaPayments)
                                                                Expanded(
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        bloc.referenceCtrl,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      isDense:
                                                                          true,
                                                                      labelText: (bloc.paymentMode?.slug ==
                                                                              "cheque")
                                                                          ? "Cheque Number"
                                                                          : "Payment reference",
                                                                      hintText: (bloc.paymentMode?.slug ==
                                                                              "cheque")
                                                                          ? "Cheque number"
                                                                          : "Reference",
                                                                      filled:
                                                                          true,
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (paymentsManager
                                                                          .mpesaPayments
                                                                          .length >
                                                                      0 ||
                                                                  paymentsManager
                                                                      .loadingMpesaPayments)
                                                                IconButton(
                                                                  onPressed: bloc
                                                                      .loadPayments,
                                                                  icon: Icon(
                                                                    Icons
                                                                        .refresh,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              if (bloc.paymentMode
                                                                      ?.slug ==
                                                                  "mpesa")
                                                                IconButton(
                                                                  onPressed: bloc
                                                                      .toggleReference,
                                                                  icon: Icon(
                                                                    Icons
                                                                        .swap_horiz,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                              ),
                                            if (bloc.paymentMode?.slug ==
                                                "cheque")
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 5.0),
                                                child: Stack(
                                                  children: <Widget>[
                                                    TextFormField(
                                                      controller:
                                                          bloc.maturityDateCtrl,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        filled: true,
                                                        labelText:
                                                            "Maturity date",
                                                        hintText:
                                                            "Cheque maturity",
                                                        suffixIcon: Icon(
                                                          Icons.date_range,
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap:
                                                          bloc.pickMaturityDate,
                                                      child: Container(
                                                        color:
                                                            Colors.transparent,
                                                        height: 50.0,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            if (bloc.paymentMode?.slug ==
                                                "cheque")
                                              Container(
                                                margin: EdgeInsets.only(
                                                  top: 5.0,
                                                ),
                                                child: GestureDetector(
                                                  onTap: bloc.takePhoto,
                                                  child: Container(
                                                    height: (bloc.image != null)
                                                        ? 200.0
                                                        : 50.0,
                                                    width: double.infinity,
                                                    color: Colors.grey[100],
                                                    child: Container(
                                                      child:
                                                          (bloc.image != null)
                                                              ? Image.file(
                                                                  bloc.image,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )
                                                              : Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: <
                                                                      Widget>[
                                                                    Icon(
                                                                      Icons
                                                                          .camera_alt,
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        "PHOTO",
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(top: 10.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Container(
                                                      height: 100.0,
                                                      child: TextFormField(
                                                        controller:
                                                            bloc.notesCtrl,
                                                        maxLines: 3,
                                                        decoration:
                                                            InputDecoration(
                                                          filled: true,
                                                          labelText: "Notes",
                                                          hintText:
                                                              "Enter additional notes",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: MaterialButton(
                                                height: 40.0,
                                                textColor: Colors.white,
                                                color: Theme.of(context)
                                                    .accentColor,
                                                onPressed: bloc.savePayment,
                                                child: Text("SAVE PAYMENT"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    onNext: bloc.nextScreen,
                    onPrev: bloc.prevScreen,
                  ),
                ),
              ),
              onWillPop: bloc.onWillPop,
            );
          }),
    );
  }
}

class RadioItem<T> extends StatelessWidget {
  Widget title;
  T value;
  T groupValue;
  Color activeColor;
  ValueChanged<T> onChanged;
  MaterialTapTargetSize materialTapTargetSize;
  RadioItem({
    this.title,
    @required this.value,
    @required this.groupValue,
    @required this.onChanged,
    this.activeColor,
    this.materialTapTargetSize,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Row(
        children: <Widget>[
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: activeColor,
            materialTapTargetSize: materialTapTargetSize,
          ),
          title,
        ],
      ),
    );
  }
}
