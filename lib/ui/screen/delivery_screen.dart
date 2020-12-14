import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/checkins_bloc.dart';
import 'package:solutech_sat/bloc/delivery_bloc.dart';
import 'package:solutech_sat/bloc/records_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/delivery.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/deliveries_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/helpers/timesheet_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/contact_buttons.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/ui/widgets/sticky_header_group.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class DeliveryScreen extends StatelessWidget {
  DeliveryBloc bloc;
  DeliveryScreen({
    Delivery delivery,
  }) : bloc = DeliveryBloc(delivery: delivery);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Delivery"),
            ),
            body: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "${bloc.delivery.shopName}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ),
                            ),
                            alignment: AlignmentDirectional.center,
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "ORDER DATE",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${formatDate(bloc.delivery.orderTime, "dt")}",
                                  style: TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0).copyWith(bottom: 0.0),
                            child: Text(
                              "ORDER DETAILS",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
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
                                            flex: 3,
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
                                          Expanded(
                                            child: Text(
                                              "COST",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ...deliveriesManager
                                        .deliveryOrderDetailsById(
                                            bloc.delivery.orderId)
                                        .map((orderDetail) {
                                      var index = deliveriesManager
                                          .deliveryOrderDetailsById(
                                              bloc.delivery.orderId)
                                          .indexOf(orderDetail);
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
                                                  "${commonsManager.productById(orderDetail.productId)?.productDesc?.toUpperCase() ?? ""}",
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${orderDetail.quantity} pcs",
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${formatCurrency(orderDetail.sellingTotalcost)}",
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
                                            flex: 4,
                                            child: Text(
                                              "TOTAL",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "${formatCurrency(double.parse("${deliveriesManager.deliveryOrderDetailsById(bloc.delivery.orderId).fold(0.0, (p, c) => p + double.parse("${c.sellingTotalcost ?? 0}"))}").toStringAsFixed(2))}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        if (routePlansManager
                                                    .getCustomerById(
                                                        bloc.delivery.shopId ??
                                                            0)
                                                    ?.shopPhoneno !=
                                                null &&
                                            routePlansManager
                                                    .getCustomerById(
                                                      bloc.delivery.shopId ?? 0,
                                                    )
                                                    ?.shopPhoneno !=
                                                "")
                                          Container(
                                            child: FlatButton(
                                              onPressed: () =>
                                                  bloc.contactCustomer(
                                                      bloc.delivery.shopId),
                                              child: Text(
                                                "CONTACT CUSTOMER",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ]),
                                ),
                                (bloc.delivery.deliveryTime == null)
                                    ? Column(
                                        children: <Widget>[
                                          Container(
                                            padding:
                                                EdgeInsets.all(5.0).copyWith(
                                              top: 10.0,
                                              bottom: 10.0,
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                GestureDetector(
                                                  onTap: bloc.takePhoto,
                                                  child: Container(
                                                    height: 97.0,
                                                    width: 97.0,
                                                    color: Colors.grey[100],
                                                    child: (bloc.image != null)
                                                        ? Image.file(
                                                            bloc.image,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Icon(
                                                            Icons.camera_alt,
                                                            size: 30.0,
                                                          ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 5.0,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: 100.0,
                                                    child: TextFormField(
                                                      controller:
                                                          bloc.commentCtrl,
                                                      maxLines: 3,
                                                      decoration:
                                                          InputDecoration(
                                                        filled: true,
                                                        labelText: "Notes",
                                                        hintText: "Enter notes",
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 5.0,
                                              right: 5.0,
                                            ),
                                            child: Stack(
                                              children: <Widget>[
                                                GestureDetector(
                                                  onHorizontalDragStart:
                                                      bloc.onDragStart,
                                                  onVerticalDragStart:
                                                      bloc.onDragStart,
                                                  child: Container(
                                                    width: double.infinity,
                                                    child: bloc.signature,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      border: Border.all(
                                                        color: Colors.grey[300],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                if (bloc.hasSignature)
                                                  Positioned(
                                                    bottom: 0.0,
                                                    right: 2.0,
                                                    child: MaterialButton(
                                                      minWidth: 20.0,
                                                      height: 30.0,
                                                      color: Colors.red,
                                                      onPressed:
                                                          bloc.clearSignature,
                                                      child: Text(
                                                        "CLEAR",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: MaterialButton(
                                              minWidth: double.infinity,
                                              height: 45.0,
                                              color:
                                                  Theme.of(context).accentColor,
                                              onPressed: bloc.deliverItems,
                                              child: Text(
                                                "DELIVER ITEMS",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  "DELIVERY DATE",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  "${formatDate(bloc.delivery.deliveryTime, "dt")}",
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          (bloc.delivery.fromServer)
                                              ? CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      "${settingsManager.updateProfile.imagestorage}deliveryreceipt/${bloc.delivery.photo}",
                                                  errorWidget:
                                                      (context, url, error) {
                                                    return Image.asset(
                                                      "assets/images/noimage.jpg",
                                                      fit: BoxFit.cover,
                                                      height: 250.0,
                                                      width: double.infinity,
                                                    );
                                                  },
                                                  height: 250.0,
                                                  width: double.infinity,
                                                )
                                              : Image.file(
                                                  File(
                                                    "${bloc.delivery.photo}",
                                                  ),
                                                  height: 250.0,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                          Text(
                                            "SIGNATURE",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          (bloc.delivery.fromServer)
                                              ? CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      "${settingsManager.updateProfile.imagestorage}deliverysignature/${bloc.delivery.receivedsignature}",
                                                  errorWidget:
                                                      (context, url, error) {
                                                    return Image.asset(
                                                      "assets/images/noimage.jpg",
                                                      fit: BoxFit.cover,
                                                      height: 250.0,
                                                      width: double.infinity,
                                                    );
                                                  },
                                                  height: 250.0,
                                                  width: double.infinity,
                                                )
                                              : Image.file(
                                                  File(
                                                    "${bloc.delivery.receivedsignature}",
                                                  ),
                                                  height: 250.0,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                        ],
                                      )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Footer(),
                  ],
                )),
          );
        },
      ),
    );
  }
}
