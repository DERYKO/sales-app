import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/deliveries_bloc.dart';
import 'package:solutech_sat/bloc/posm_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/delivery.dart';
import 'package:solutech_sat/data/models/posm.dart';
import 'package:solutech_sat/data/models/scheduled_delivery.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/deliveries_manager.dart';
import 'package:solutech_sat/helpers/posm_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class DeliveriesScreen extends StatelessWidget {
  final bloc = DeliveriesBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("${roleManager.resolveTitle(
            title: "Deliveries",
            module: Roles.DELIVERY,
          )}"),
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
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.grey[100],
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: StreamBuilder(
                            stream: deliveriesManager.stream,
                            builder: (context, snapshot) {
                              return CircularMaterialSpinner(
                                loading: deliveriesManager.loadingDeliveries,
                                child: ListView.builder(
                                  itemCount: deliveriesManager
                                      .scheduledDeliveries.length,
                                  itemBuilder: (context, index) {
                                    ScheduledDelivery scheduledDelivery =
                                        deliveriesManager
                                            .scheduledDeliveries[index];
                                    return CustomExpansionTile(
                                      title: Container(
                                        height: 50.0,
                                        padding: EdgeInsets.all(5.0),
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              "SCHEDULE",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              "${formatDate("${scheduledDelivery.scheduledTime}", "dt")}",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor,
                                              ),
                                            )
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
                                        if ((scheduledDelivery.dispatchTime ==
                                                null ||
                                            scheduledDelivery.returnTime ==
                                                null))
                                          Padding(
                                            padding:
                                                EdgeInsets.all(10.0).copyWith(
                                              top: 0.0,
                                              bottom: 0.0,
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: MaterialButton(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    color: (scheduledDelivery
                                                                .dispatchTime ==
                                                            null)
                                                        ? Colors.green
                                                        : Colors.grey[300],
                                                    onPressed: (scheduledDelivery
                                                                .dispatchTime ==
                                                            null)
                                                        ? () => bloc.startTrip(
                                                            scheduledDelivery
                                                                .id)
                                                        : null,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: <Widget>[
                                                        Text(
                                                          "START TRIP",
                                                          style: TextStyle(
                                                            color: (scheduledDelivery
                                                                        .dispatchTime ==
                                                                    null)
                                                                ? Colors.white
                                                                : Colors.grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(5.0),
                                                ),
                                                Expanded(
                                                  child: MaterialButton(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    color: (scheduledDelivery
                                                                    .dispatchTime !=
                                                                null &&
                                                            scheduledDelivery
                                                                    .returnTime ==
                                                                null)
                                                        ? Colors.red
                                                        : Colors.grey[300],
                                                    onPressed: (scheduledDelivery
                                                                    .dispatchTime !=
                                                                null &&
                                                            scheduledDelivery
                                                                    .returnTime ==
                                                                null)
                                                        ? () => bloc.endTrip(
                                                            scheduledDelivery
                                                                .id)
                                                        : null,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: <Widget>[
                                                        Text(
                                                          "END TRIP",
                                                          style: TextStyle(
                                                            color: (scheduledDelivery
                                                                            .dispatchTime !=
                                                                        null &&
                                                                    scheduledDelivery
                                                                            .returnTime ==
                                                                        null)
                                                                ? Colors.white
                                                                : Colors.grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ...deliveriesManager
                                            .deliveriesByScheduleId(
                                                scheduledDelivery.id)
                                            .map<Widget>((Delivery delivery) {
                                          return (scheduledDelivery
                                                      .dispatchTime !=
                                                  null)
                                              ? GestureDetector(
                                                  onTap: () =>
                                                      bloc.onDelivery(delivery),
                                                  child: Container(
                                                    color: Colors.white,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                          margin:
                                                              EdgeInsets.all(
                                                                  5.0),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Text(
                                                            "${deliveriesManager.deliveryOrderDetailsById(delivery.orderId).length}",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            "${delivery.shopName}",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  5.0),
                                                          child: Icon(
                                                            Icons.check_circle,
                                                            color: deliveriesManager
                                                                    .delivered(
                                                                        delivery
                                                                            .id)
                                                                ? Colors.green
                                                                : Colors
                                                                    .grey[400],
                                                            size: 16.0,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : CustomExpansionTile(
                                                  title: Container(
                                                    color: Colors.white,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                          margin:
                                                              EdgeInsets.all(
                                                                  5.0),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Text(
                                                            "${deliveriesManager.deliveryOrderDetailsById(delivery.orderId).length}",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            "${delivery.shopName}",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  5.0),
                                                          child: Icon(
                                                            Icons.check_circle,
                                                            color: deliveriesManager
                                                                    .delivered(
                                                                        delivery
                                                                            .id)
                                                                ? Colors.green
                                                                : Colors
                                                                    .grey[400],
                                                            size: 16.0,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  children: <Widget>[
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                        top: 10.0,
                                                        bottom: 10.0,
                                                      ),
                                                      child: Column(children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 5.0,
                                                            bottom: 5.0,
                                                          ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                flex: 4,
                                                                child: Text(
                                                                  "PRODUCT",
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  "QTY",
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  "COST",
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        ...deliveriesManager
                                                            .deliveryOrderDetailsById(
                                                                delivery
                                                                    .orderId)
                                                            .map((orderDetail) {
                                                          var index =
                                                              deliveriesManager
                                                                  .deliveryOrderDetailsById(
                                                                    delivery
                                                                        .orderId,
                                                                  )
                                                                  .indexOf(
                                                                      orderDetail);
                                                          return Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: 5.0,
                                                              top: 10.0,
                                                              bottom: 10.0,
                                                            ),
                                                            color: (index + 1) %
                                                                        2 ==
                                                                    0
                                                                ? Colors.white
                                                                : Colors
                                                                    .grey[100],
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Expanded(
                                                                  flex: 4,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .only(
                                                                      right:
                                                                          10.0,
                                                                      top: 5.0,
                                                                    ),
                                                                    child: Text(
                                                                      "${commonsManager.productById(orderDetail.productId)?.productDesc?.toUpperCase() ?? ""}",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black54,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    "${orderDetail.quantity} pcs",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    "${orderDetail.sellingTotalcost}",
                                                                    style:
                                                                        TextStyle(
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
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                flex: 4,
                                                                child: Text(
                                                                  "TOTAL",
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                "${double.parse("${deliveriesManager.deliveryOrderDetailsById(delivery.orderId).fold(0.0, (p, c) => p + double.parse("${c.sellingTotalcost ?? 0}"))}").toStringAsFixed(2)}",
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            if (routePlansManager
                                                                        .getCustomerById(
                                                                            delivery.shopId ??
                                                                                0)
                                                                        ?.shopPhoneno !=
                                                                    null &&
                                                                routePlansManager
                                                                        .getCustomerById(
                                                                          delivery.shopId ??
                                                                              0,
                                                                        )
                                                                        ?.shopPhoneno !=
                                                                    "")
                                                              Container(
                                                                child:
                                                                    FlatButton(
                                                                  onPressed: () =>
                                                                      bloc.contactCustomer(
                                                                          delivery
                                                                              .shopId),
                                                                  child: Text(
                                                                    "CONTACT CUSTOMER",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .accentColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ]),
                                                    ),
                                                  ],
                                                );
                                        }).toList()
                                      ],
                                    );
                                  },
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
