import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/brand_availability_bloc.dart';
import 'package:solutech_sat/bloc/inventory_bloc.dart';
import 'package:solutech_sat/bloc/posm_bloc.dart';
import 'package:solutech_sat/bloc/sod_bloc.dart';
import 'package:solutech_sat/bloc/sos_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/availability.dart';
import 'package:solutech_sat/data/models/availability_item.dart';
import 'package:solutech_sat/data/models/posm.dart';
import 'package:solutech_sat/data/models/product_availability.dart';
import 'package:solutech_sat/data/models/product_availability_detail.dart';
import 'package:solutech_sat/data/models/sod.dart';
import 'package:solutech_sat/data/models/sos.dart';
import 'package:solutech_sat/data/models/sos_item.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/availability_manager.dart';
import 'package:solutech_sat/helpers/product_availability_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/helpers/sod_manager.dart';
import 'package:solutech_sat/helpers/sos_manager.dart';
import 'package:solutech_sat/helpers/stockpoints_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/carousel_with_indicator.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/competition_card.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/ui/widgets/inventory_view.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class SodScreen extends StatelessWidget {
  final bloc = SodBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: AutoSizeText("${roleManager.resolveTitle(
            title: "Share of Display",
            module: Roles.SHARE_OF_DISPLAY,
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
                            stream: sodManager.stream,
                            builder: (context, snapshot) {
                              return CircularMaterialSpinner(
                                loading: sodManager.loadingSods,
                                child: ListView.builder(
                                    itemCount: sodManager.sods.length,
                                    itemBuilder: (context, index) {
                                      Sod sod = sodManager.sods[index];

                                      return Container(
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Text(
                                                              "${routePlansManager.getCustomerById(sod.shopId)?.shopName}",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 16.0,
                                                              ),
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons.done_all,
                                                            color: (sod.synced)
                                                                ? Colors.green
                                                                : Colors.grey,
                                                            size: 16.0,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // n-

                                                    CarouselWithIndicator(
                                                      items: [
                                                        ...sodManager
                                                            .getSodPhotosFor(
                                                                sod.id)
                                                            .map<Widget>(
                                                                (photo) {
                                                          return Builder(
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return Container(
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                  horizontal:
                                                                      5.0,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .blueGrey,
                                                                ),
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  child: (sod
                                                                          .fromServer)
                                                                      ? CachedNetworkImage(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          imageUrl:
                                                                              "${settingsManager.updateProfile.imagestorage}shareofdisplay/${photo.photoName}",
                                                                          errorWidget: (context,
                                                                              url,
                                                                              error) {
                                                                            return Image.asset(
                                                                              "assets/images/noimage.jpg",
                                                                              fit: BoxFit.cover,
                                                                              height: 250.0,
                                                                            );
                                                                          },
                                                                          height:
                                                                              250.0,
                                                                          width:
                                                                              70.0,
                                                                        )
                                                                      : Image.file(
                                                                          File(
                                                                            "${sod.photo}",
                                                                          ),
                                                                          height: 250.0,
                                                                          width: 70.0,
                                                                          fit: BoxFit.cover),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        }).toList()
                                                      ],
                                                    ),

                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Text(
                                                        "Brand: ${sod.brand}",
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .all(5.0)
                                                          .copyWith(top: 0.0),
                                                      child: Text(
                                                        "Displays: ${sod.displayType} - ${sod.quantity}",
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .all(5.0)
                                                          .copyWith(top: 0.0),
                                                      child: Text(
                                                        "${sod.notes}",
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional
                                                                .bottomEnd,
                                                        child: Text(
                                                          "${formatDate(sod.entryTime, "dt")}",
                                                          style: TextStyle(
                                                            color: Theme.of(
                                                              context,
                                                            ).accentColor,
                                                            fontSize: 11.0,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border(
                                                bottom: BorderSide(
                                              color: Colors.grey[200],
                                            ))),
                                      );
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
