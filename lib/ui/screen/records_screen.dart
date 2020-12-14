import 'dart:io';

import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/records_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class RecordsScreen extends StatelessWidget {
  final bloc = RecordsBloc();
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
                title: Text("Records"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.date_range,
                      color: config.contrastColor,
                    ),
                    onPressed: bloc.filterByDate,
                  ),
                ],
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(
                      child: Text("SALES AND ORDERS"),
                    ),
                    Tab(
                      child: Text("SKIPPED SHOPS"),
                    ),
                  ],
                ),
              ),
              body: StreamBuilder(
                stream: recordsManager.stream,
                builder: (context, snapshot) {
                  return Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: TabBarView(
                            children: [
                              CircularMaterialSpinner(
                                loading: recordsManager.loadingOrders,
                                child: ListView.builder(
                                  itemCount: recordsManager.orders.length,
                                  itemBuilder: (context, index) {
                                    var order = recordsManager.orders[index];
                                    var orderItems = recordsManager
                                        .orderItemsFromOrderId(order.id);
                                    return Container(
                                      child: Column(
                                        children: <Widget>[
                                          CustomExpansionTile(
                                            title: Container(
                                              padding:
                                                  EdgeInsets.all(3.0).copyWith(
                                                bottom: 12.0,
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5.0,
                                                          right: 5.0),
                                                      child: Container(
                                                        height: 70.0,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: <
                                                                  Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    "${routePlansManager.getCustomerById(order.shopId)?.shopName ?? ""}",
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          16.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .done_all,
                                                                  color: (order
                                                                          .synced)
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .grey,
                                                                  size: 16.0,
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  "${order.entryType}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15.0,
                                                                    color: Colors
                                                                        .black54,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5.0),
                                                                  child: Text(
                                                                    "${order.paymentMethod}",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .green,
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(2))),
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  "${authManager.user.country?.currencyCode} ${order.totalCost}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15.0,
                                                                    color: Colors
                                                                        .black54,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "${formatDate(order.orderTime)} ${formatDate(order.orderTime, "jm")}",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .accentColor,
                                                                    fontSize:
                                                                        11.0,
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            children: [
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
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            "QTY",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            "COST",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  ...orderItems
                                                      .map((orderItem) {
                                                    var index = orderItems
                                                        .indexOf(orderItem);
                                                    print(
                                                        "Items length ${orderItems.length}");
                                                    return Container(
                                                      padding: EdgeInsets.only(
                                                        left: 5.0,
                                                        top: 10.0,
                                                        bottom: 10.0,
                                                      ),
                                                      color: (index + 1) % 2 ==
                                                              0
                                                          ? Colors.white
                                                          : Colors.grey[100],
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            flex: 4,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                right: 10.0,
                                                                top: 5.0,
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    "${commonsManager.productById(orderItem.productId)?.productDesc?.toUpperCase() ?? ""}",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                    ),
                                                                  ),
                                                                  if (orderItem
                                                                              .batchnumber !=
                                                                          null &&
                                                                      orderItem
                                                                              .batchnumber !=
                                                                          "")
                                                                    RichText(
                                                                      text: TextSpan(
                                                                          children: [
                                                                            TextSpan(
                                                                              text: "Batch:",
                                                                              style: TextStyle(
                                                                                fontSize: 11.0,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                            TextSpan(text: " "),
                                                                            TextSpan(
                                                                              text: "${orderItem.batchnumber}",
                                                                              style: TextStyle(
                                                                                fontSize: 11.0,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Colors.black54,
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              "${orderItem.quantity} pcs",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              "${double.parse("${orderItem.quantity * double.parse(orderItem.sellingPrice)}").toStringAsFixed(2)}",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          flex: 4,
                                                          child: Text(
                                                            "TOTAL",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(""),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            "${order.sellingTotalCost}",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "Remarks:",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                          " ${order.notes ?? ""}")
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      if (roleManager.hasRole(Roles
                                                              .ALLOW_PRINTING) &&
                                                          order.entryType !=
                                                              "Order")
                                                        Container(
                                                          child: FlatButton(
                                                            onPressed: () => bloc
                                                                .printSaleOrder(
                                                                    order
                                                                        .shopId,
                                                                    order,
                                                                    orderItems),
                                                            child: Text(
                                                              "PRINT",
                                                            ),
                                                          ),
                                                        ),
                                                      if (routePlansManager
                                                                  .getCustomerById(
                                                                      order
                                                                          .shopId)
                                                                  ?.shopPhoneno !=
                                                              null &&
                                                          routePlansManager
                                                                  .getCustomerById(
                                                                    order
                                                                        .shopId,
                                                                  )
                                                                  ?.shopPhoneno !=
                                                              "")
                                                        Container(
                                                          child: FlatButton(
                                                            onPressed: () => bloc
                                                                .contactCustomer(
                                                                    order
                                                                        .shopId),
                                                            child: Text(
                                                              "CONTACT CUSTOMER",
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ]),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              CircularMaterialSpinner(
                                loading: recordsManager.loadingSkipRecords,
                                child: ListView.builder(
                                  itemCount: recordsManager.skipRecords.length,
                                  itemBuilder: (context, index) {
                                    var skipRecord =
                                        recordsManager.skipRecords[index];
                                    return Container(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding:
                                                EdgeInsets.all(3.0).copyWith(
                                              bottom: 12.0,
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5.0, right: 5.0),
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          bottom: 5.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: Text(
                                                                  "${routePlansManager.getCustomerById(skipRecord.shopId)?.shopName ?? ""}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        16.0,
                                                                  ),
                                                                ),
                                                              ),
                                                              Icon(
                                                                Icons.done_all,
                                                                color: (skipRecord
                                                                        .synced)
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .grey,
                                                                size: 16.0,
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: Text(
                                                                  "${skipRecord.skipNotes ?? ""}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15.0,
                                                                    color: Colors
                                                                        .black54,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          if (skipRecord
                                                                  .nextVisitDate !=
                                                              null)
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  "Next visit:",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black87,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5.0),
                                                                  child: Text(
                                                                    "${formatDate(skipRecord.nextVisitDate)}",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .bottomEnd,
                                                            child: Text(
                                                              "${formatDate(skipRecord.orderTime)} ${formatDate(skipRecord.orderTime, "jm")}",
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .accentColor,
                                                                fontSize: 11.0,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                          border: Border(
                                                              bottom:
                                                                  BorderSide(
                                                        color: Colors.grey[200],
                                                      ))),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Footer(),
                      ],
                    ),
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: (dayManager.closedDay)
                    ? bloc.showClosedDayDialog
                    : bloc.chooseCustomer,
                child: Icon(
                  Icons.add,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
