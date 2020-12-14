import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/brand_availability_bloc.dart';
import 'package:solutech_sat/bloc/inventory_bloc.dart';
import 'package:solutech_sat/bloc/posm_bloc.dart';
import 'package:solutech_sat/bloc/product_availability_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/availability.dart';
import 'package:solutech_sat/data/models/availability_item.dart';
import 'package:solutech_sat/data/models/posm.dart';
import 'package:solutech_sat/data/models/product_availability.dart';
import 'package:solutech_sat/data/models/product_availability_detail.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/availability_manager.dart';
import 'package:solutech_sat/helpers/product_availability_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/helpers/stockpoints_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/ui/widgets/inventory_view.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class ProductAvailabilityScreen extends StatelessWidget {
  final bloc = ProductAvailabilityBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: AutoSizeText("${roleManager.resolveTitle(
            title: "On Shelf Availability",
            module: Roles.AVAILABILITY,
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
            IconButton(
              icon: Icon(
                Icons.date_range,
                color: config.contrastColor,
              ),
              onPressed: bloc.filterByDate,
            ),
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
                            stream: productAvailabilityManager.stream,
                            builder: (context, snapshot) {
                              return CircularMaterialSpinner(
                                loading: productAvailabilityManager
                                    .loadingAvailability,
                                child: ListView.builder(
                                    itemCount: productAvailabilityManager
                                        .productAvailabilities.length,
                                    itemBuilder: (context, index) {
                                      ProductAvailability productAvailability =
                                          productAvailabilityManager
                                              .productAvailabilities[index];

                                      return CustomExpansionTile(
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
                                                        left: 5.0, right: 5.0),
                                                    child: Container(
                                                      height: 40.0,
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
                                                                  "${routePlansManager.getCustomerById(productAvailability.outletId)?.shopName}",
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
                                                                color: (productAvailability
                                                                        .synced)
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .grey,
                                                                size: 16.0,
                                                              ),
                                                            ],
                                                          ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .bottomEnd,
                                                            child: Text(
                                                              "${formatDate(productAvailability.entryTime)} ${formatDate(productAvailability.entryTime, "jm")}",
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
                                                      child: Column(
                                                          children: <Widget>[
                                                            ...productAvailabilityManager
                                                                .getAvailabilityDetailsById(
                                                                    productAvailability
                                                                        .id)
                                                                .map<Widget>(
                                                                    (ProductAvailabilityDetail
                                                                        availabilityDetail) {
                                                              var index =
                                                                  productAvailabilityManager
                                                                      .getAvailabilityDetailsById(
                                                                        productAvailability
                                                                            .id,
                                                                      )
                                                                      .indexOf(
                                                                          availabilityDetail);
                                                              return Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 5.0,
                                                                  top: 10.0,
                                                                  bottom: 10.0,
                                                                ),
                                                                color: (index + 1) %
                                                                            2 ==
                                                                        0
                                                                    ? Colors
                                                                        .white
                                                                    : Colors.grey[
                                                                        100],
                                                                child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      flex: 3,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.only(
                                                                          right:
                                                                              10.0,
                                                                          top:
                                                                              5.0,
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          "${commonsManager.productById(availabilityDetail.productId)?.productDesc}",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black54,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        "${availabilityDetail.availabilityStatus} ${(availabilityDetail.quantity != null) ? "(${availabilityDetail.quantity})" : ""}",
                                                                        style:
                                                                            TextStyle(
                                                                          color: (availabilityDetail.availabilityStatus == "Available")
                                                                              ? Colors.green
                                                                              : Colors.red,
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
