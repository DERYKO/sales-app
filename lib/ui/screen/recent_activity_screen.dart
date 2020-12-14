import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/customer_bloc.dart';
import 'package:solutech_sat/bloc/customers_bloc.dart';
import 'package:solutech_sat/bloc/records_bloc.dart';
import 'package:solutech_sat/bloc/recent_activity_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/availability.dart';
import 'package:solutech_sat/data/models/availability_item.dart';
import 'package:solutech_sat/data/models/posm.dart';
import 'package:solutech_sat/data/models/route_plan.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/availability_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/posm_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/helpers/stockpoints_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/contact_buttons.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class RecentActivityScreen extends StatelessWidget {
  RecentActivityBloc bloc;

  RecentActivityScreen({
    RoutePlan routePlan,
    Customer customer,
    String mode,
  }) : bloc = RecentActivityBloc(
          customer: customer,
          routePlan: routePlan,
          mode: mode,
        );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Recent activities",
                ),
              ),
              body: StreamBuilder(
                stream: bloc.stream,
                builder: (context, snapshot) {
                  return Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: double.infinity,
                    child: StreamBuilder(
                        stream: recordsManager.stream,
                        builder: (context, snapshot) {
                          return Column(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Flexible(
                                      child: (bloc.mode == "Order" ||
                                              bloc.mode == "Sale")
                                          ? ListView.builder(
                                              itemCount: recordsManager
                                                  .ordersByShopId(
                                                      bloc.customer.id,
                                                      bloc.mode)
                                                  .length,
                                              itemBuilder: (context, index) {
                                                var order = recordsManager
                                                    .ordersByShopId(
                                                        bloc.customer.id,
                                                        bloc.mode)[index];
                                                var orderItems = recordsManager
                                                    .orderItemsFromOrderId(
                                                        order.id);
                                                return Container(
                                                  child: Column(
                                                    children: <Widget>[
                                                      CustomExpansionTile(
                                                        title: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                      3.0)
                                                                  .copyWith(
                                                            bottom: 12.0,
                                                          ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              5.0,
                                                                          right:
                                                                              5.0),
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        70.0,
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: <
                                                                          Widget>[
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: <
                                                                              Widget>[
                                                                            Flexible(
                                                                              child: Text(
                                                                                "${routePlansManager.getCustomerById(order.shopId)?.shopName ?? ""}",
                                                                                style: TextStyle(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontSize: 16.0,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Icon(
                                                                              Icons.done_all,
                                                                              color: (order.synced) ? Colors.green : Colors.grey,
                                                                              size: 16.0,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: <
                                                                              Widget>[
                                                                            Text(
                                                                              "${authManager.user.country?.currencyCode} ${order.totalCost}",
                                                                              style: TextStyle(
                                                                                fontSize: 15.0,
                                                                                color: Colors.black54,
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              padding: EdgeInsets.all(5.0),
                                                                              child: Text(
                                                                                "${order.paymentMethod}",
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(2))),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Align(
                                                                          alignment:
                                                                              AlignmentDirectional.bottomEnd,
                                                                          child:
                                                                              Text(
                                                                            "${formatDate(order.orderTime)} ${formatDate(order.orderTime, "jm")}",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Theme.of(context).accentColor,
                                                                              fontSize: 11.0,
                                                                            ),
                                                                          ),
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
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 10.0,
                                                              bottom: 10.0,
                                                            ),
                                                            child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left: 5.0,
                                                                    ),
                                                                    child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Expanded(
                                                                          flex:
                                                                              4,
                                                                          child:
                                                                              Text(
                                                                            "PRODUCT",
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            "QTY",
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            "COST",
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  ...orderItems.map(
                                                                      (orderItem) {
                                                                    print(
                                                                        "Items length ${orderItems.length}");
                                                                    var index =
                                                                        orderItems
                                                                            .indexOf(orderItem);
                                                                    return Container(
                                                                      color: (index + 1) %
                                                                                  2 ==
                                                                              0
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .grey[100],
                                                                      padding:
                                                                          EdgeInsets
                                                                              .all(
                                                                        5.0,
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        children: <
                                                                            Widget>[
                                                                          Expanded(
                                                                            flex:
                                                                                4,
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.only(
                                                                                right: 10.0,
                                                                                top: 5.0,
                                                                              ),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: <Widget>[
                                                                                  Text(
                                                                                    "${commonsManager.productById(orderItem.productId).productDesc.toUpperCase()}",
                                                                                    style: TextStyle(
                                                                                      color: Colors.black54,
                                                                                    ),
                                                                                  ),
                                                                                  if (orderItem.batchnumber != null && orderItem.batchnumber != "")
                                                                                    RichText(
                                                                                      text: TextSpan(children: [
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
                                                                            child:
                                                                                Text(
                                                                              "${(orderItem.productPackaging == "ctns") ? orderItem.quantity * orderItem.cartonQuantity : orderItem.quantity} pcs",
                                                                              style: TextStyle(
                                                                                color: Colors.black54,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              "${double.parse("${orderItem.quantity * double.parse(orderItem.sellingPrice)}").toStringAsFixed(2)}",
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
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10.0),
                                                                    child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Expanded(
                                                                          flex:
                                                                              4,
                                                                          child:
                                                                              Text(
                                                                            "TOTAL",
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Text(""),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            "${order.sellingTotalCost}",
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: <
                                                                        Widget>[
                                                                      if (roleManager
                                                                          .hasRole(
                                                                              Roles.ALLOW_PRINTING))
                                                                        Container(
                                                                          child:
                                                                              FlatButton(
                                                                            onPressed: () => bloc.printSaleOrder(
                                                                                order.shopId,
                                                                                order,
                                                                                orderItems),
                                                                            child:
                                                                                Text(
                                                                              "PRINT",
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
                                            )
                                          : (bloc.mode == "Posm")
                                              ? StreamBuilder(
                                                  stream: posmManager.stream,
                                                  builder: (context, snapshot) {
                                                    return CircularMaterialSpinner(
                                                      loading: posmManager
                                                          .loadingPosms,
                                                      child: ListView.builder(
                                                          itemCount: posmManager
                                                              .todaysPosmsByCustomerId(
                                                                  bloc.customer
                                                                      .id)
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            Posm posm = posmManager
                                                                .todaysPosmsByCustomerId(bloc
                                                                    .customer
                                                                    .id)[index];
                                                            return Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.0),
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          "${posm.shopName}",
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Icon(
                                                                        Icons
                                                                            .done_all,
                                                                        color: (posm.synced)
                                                                            ? Colors.green
                                                                            : Colors.grey,
                                                                        size:
                                                                            16.0,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .only(
                                                                      top: 5.0,
                                                                    ),
                                                                    child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            "${posm.productName}",
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          "${formatDate(posm.entryTime)} ${formatDate(posm.entryTime, "jm")}",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                11.0,
                                                                            color:
                                                                                Theme.of(context).accentColor,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .only(
                                                                      top: 10.0,
                                                                    ),
                                                                    child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            "${posm.itemname}",
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        "Availability: ",
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "${posm.availability ?? ""}",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12.0,
                                                                          color:
                                                                              Colors.black54,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        "Stocked: ",
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "${posm.stocked ?? ""}",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12.0,
                                                                          color:
                                                                              Colors.black54,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        "Visibility: ",
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "${posm.visibility ?? ""}",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12.0,
                                                                          color:
                                                                              Colors.black54,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      border: Border(
                                                                          bottom: BorderSide(
                                                                        color: Colors
                                                                            .grey[300],
                                                                      ))),
                                                            );
                                                          }),
                                                    );
                                                  })
                                              : (bloc.mode == "Brand")
                                                  ? StreamBuilder(
                                                      stream:
                                                          availabilityManager
                                                              .stream,
                                                      builder:
                                                          (context, snapshot) {
                                                        return CircularMaterialSpinner(
                                                          loading:
                                                              availabilityManager
                                                                  .loadingAvailability,
                                                          child:
                                                              ListView.builder(
                                                                  itemCount: availabilityManager
                                                                      .todaysAvailabilityByCustomerId(bloc
                                                                          .customer
                                                                          .id)
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    Availability
                                                                        availability =
                                                                        availabilityManager.todaysAvailabilityByCustomerId(bloc
                                                                            .customer
                                                                            .id)[index];

                                                                    return CustomExpansionTile(
                                                                        title:
                                                                            Container(
                                                                          padding:
                                                                              EdgeInsets.all(3.0).copyWith(
                                                                            bottom:
                                                                                12.0,
                                                                          ),
                                                                          child:
                                                                              Row(
                                                                            children: <Widget>[
                                                                              Expanded(
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                                                                                  child: Container(
                                                                                    height: 40.0,
                                                                                    child: Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: <Widget>[
                                                                                        Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                          children: <Widget>[
                                                                                            Flexible(
                                                                                              child: Text(
                                                                                                "${availability.shopName}",
                                                                                                style: TextStyle(
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                  fontSize: 16.0,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Icon(
                                                                                              Icons.done_all,
                                                                                              color: (availability.synced) ? Colors.green : Colors.grey,
                                                                                              size: 16.0,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        Align(
                                                                                          alignment: AlignmentDirectional.bottomEnd,
                                                                                          child: Text(
                                                                                            "${formatDate(availability.entryTime)} ${formatDate(availability.entryTime, "jm")}",
                                                                                            style: TextStyle(
                                                                                              color: Theme.of(context).accentColor,
                                                                                              fontSize: 11.0,
                                                                                            ),
                                                                                          ),
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
                                                                                top: 5.0,
                                                                                bottom: 5.0,
                                                                              ),
                                                                              child: Column(
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsets.only(
                                                                                      left: 5.0,
                                                                                      bottom: 5.0,
                                                                                    ),
                                                                                    child: Column(children: <Widget>[
                                                                                      ...availabilityManager.getAvailabilityItemsById(availability.recordId).map<Widget>((AvailabilityItem availabilityItem) {
                                                                                        var index = availabilityManager.getAvailabilityItemsById(availability.recordId).indexOf(availabilityItem);
                                                                                        return Container(
                                                                                          padding: EdgeInsets.only(
                                                                                            left: 5.0,
                                                                                            top: 10.0,
                                                                                            bottom: 10.0,
                                                                                          ),
                                                                                          color: (index + 1) % 2 == 0 ? Colors.white : Colors.grey[100],
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
                                                                                                    "${availabilityItem.productName}",
                                                                                                    style: TextStyle(
                                                                                                      color: Colors.black54,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                child: Text(
                                                                                                  "${availabilityItem.availabilityStatus}",
                                                                                                  style: TextStyle(
                                                                                                    color: (availabilityItem.availabilityStatus == "Available") ? Colors.green : Colors.red,
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
                                                                              ))
                                                                        ]);
                                                                  }),
                                                        );
                                                      })
                                                  : ListView.builder(
                                                      itemCount: recordsManager
                                                          .skipByShopId(
                                                            int.parse(
                                                                "${bloc.customer.id}"),
                                                          )
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        var skipRecord =
                                                            recordsManager
                                                                .skipByShopId(
                                                                    int.parse(
                                                                        "${bloc.customer.id}"))[index];
                                                        return Container(
                                                          child: Column(
                                                            children: <Widget>[
                                                              Container(
                                                                padding: EdgeInsets
                                                                        .all(
                                                                            3.0)
                                                                    .copyWith(
                                                                  bottom: 12.0,
                                                                ),
                                                                child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.only(
                                                                          left:
                                                                              5.0,
                                                                          right:
                                                                              5.0,
                                                                        ),
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              EdgeInsets.only(bottom: 5.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: <Widget>[
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: <Widget>[
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      "${routePlansManager.getCustomerById(skipRecord.shopId)?.shopName ?? ""}",
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontSize: 16.0,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Icon(
                                                                                    Icons.done_all,
                                                                                    color: (skipRecord.synced) ? Colors.green : Colors.grey,
                                                                                    size: 16.0,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: <Widget>[
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      "${skipRecord.skipNotes}",
                                                                                      style: TextStyle(
                                                                                        fontSize: 15.0,
                                                                                        color: Colors.black54,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              if (skipRecord.nextVisitDate != null)
                                                                                Row(
                                                                                  children: <Widget>[
                                                                                    Text(
                                                                                      "Next visit:",
                                                                                      style: TextStyle(
                                                                                        color: Colors.black87,
                                                                                      ),
                                                                                    ),
                                                                                    Container(
                                                                                      padding: EdgeInsets.all(5.0),
                                                                                      child: Text(
                                                                                        "${formatDate(skipRecord.nextVisitDate)}",
                                                                                        style: TextStyle(
                                                                                          color: Colors.black54,
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              Align(
                                                                                alignment: AlignmentDirectional.bottomEnd,
                                                                                child: Text(
                                                                                  "${formatDate(skipRecord.orderTime)} ${formatDate(skipRecord.orderTime, "jm")}",
                                                                                  style: TextStyle(
                                                                                    color: Theme.of(context).accentColor,
                                                                                    fontSize: 11.0,
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            border:
                                                                                Border(
                                                                              bottom: BorderSide(
                                                                                color: Colors.grey[200],
                                                                              ),
                                                                            ),
                                                                          ),
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
                                    if (bloc.mode != "Skip")
                                      Container(
                                        margin: EdgeInsets.all(10.0),
                                        child: MaterialButton(
                                          height: 45.0,
                                          padding: EdgeInsets.all(10.0),
                                          color: Theme.of(context).accentColor,
                                          textColor: Colors.white,
                                          onPressed: bloc.navigateForAction,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Text(
                                                bloc.mode == "Sale"
                                                    ? (recordsManager
                                                            .hasTodaysRecord(
                                                                bloc.customer
                                                                    .id,
                                                                "Sale")
                                                        ? "MAKE ANOTHER SALE"
                                                        : "MAKE A SALE")
                                                    : bloc.mode == "Order"
                                                        ? (recordsManager
                                                                .hasTodaysRecord(
                                                                    bloc.customer
                                                                        .id,
                                                                    "Order")
                                                            ? "MAKE ANOTHER ORDER"
                                                            : "MAKE AN ORDER")
                                                        : (bloc.mode ==
                                                                    "Posm" ||
                                                                bloc.mode ==
                                                                    "Brand")
                                                            ? (posmManager
                                                                    .hasTodaysRecord(bloc
                                                                        .customer
                                                                        .id)
                                                                ? "DO ANOTHER AUDIT"
                                                                : "DO AN AUDIT")
                                                            : "SKIP CUSTOMER",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Footer(),
                            ],
                          );
                        }),
                  );
                },
              ),
            );
          }),
    );
  }
}
