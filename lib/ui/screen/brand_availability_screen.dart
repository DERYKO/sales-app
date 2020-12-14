import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/brand_availability_bloc.dart';
import 'package:solutech_sat/bloc/inventory_bloc.dart';
import 'package:solutech_sat/bloc/posm_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/availability.dart';
import 'package:solutech_sat/data/models/availability_item.dart';
import 'package:solutech_sat/data/models/posm.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/availability_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/helpers/stockpoints_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/ui/widgets/inventory_view.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class BrandAvailabilityScreen extends StatelessWidget {
  final bloc = BrandAvailabilityBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("${roleManager.resolveTitle(
            title: "Brand Availability",
            module: Roles.BRAND_AVAILABILITY,
          )}"),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: config.contrastColor,
              ),
              onPressed: bloc.refresh,
            ),
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
                            stream: availabilityManager.stream,
                            builder: (context, snapshot) {
                              return CircularMaterialSpinner(
                                loading:
                                    availabilityManager.loadingAvailability,
                                child: ListView.builder(
                                    itemCount: availabilityManager
                                        .availabilities.length,
                                    itemBuilder: (context, index) {
                                      Availability availability =
                                          availabilityManager
                                              .availabilities[index];

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
                                                                  "${availability.shopName}",
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
                                                                color: (availability
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
                                                              "${formatDate(availability.entryTime)} ${formatDate(availability.entryTime, "jm")}",
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
                                                            ...availabilityManager
                                                                .getAvailabilityItemsById(
                                                                    availability
                                                                        .recordId)
                                                                .map<Widget>(
                                                                    (AvailabilityItem
                                                                        availabilityItem) {
                                                              var index = availabilityManager
                                                                  .getAvailabilityItemsById(
                                                                      availability
                                                                          .recordId)
                                                                  .indexOf(
                                                                      availabilityItem);
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
                                                                          "${availabilityItem.productName}",
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
                                                                        "${availabilityItem.availabilityStatus}",
                                                                        style:
                                                                            TextStyle(
                                                                          color: (availabilityItem.availabilityStatus == "Available")
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
