import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/brand_availability_bloc.dart';
import 'package:solutech_sat/bloc/inventory_bloc.dart';
import 'package:solutech_sat/bloc/posm_bloc.dart';
import 'package:solutech_sat/bloc/sos_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/availability.dart';
import 'package:solutech_sat/data/models/availability_item.dart';
import 'package:solutech_sat/data/models/posm.dart';
import 'package:solutech_sat/data/models/product_availability.dart';
import 'package:solutech_sat/data/models/product_availability_detail.dart';
import 'package:solutech_sat/data/models/sos.dart';
import 'package:solutech_sat/data/models/sos_item.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/availability_manager.dart';
import 'package:solutech_sat/helpers/product_availability_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/helpers/sos_manager.dart';
import 'package:solutech_sat/helpers/stockpoints_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/competition_card.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/ui/widgets/inventory_view.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class SosScreen extends StatelessWidget {
  final bloc = SosBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: AutoSizeText("${roleManager.resolveTitle(
            title: "Share of Shelf",
            module: Roles.SHELF_SHARE,
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
                            stream: sosManager.stream,
                            builder: (context, snapshot) {
                              return CircularMaterialSpinner(
                                loading: sosManager.loadingSos,
                                child: ListView.builder(
                                    itemCount: sosManager.sos.length,
                                    itemBuilder: (context, index) {
                                      Sos sos = sosManager.sos[index];

                                      return CustomExpansionTile(
                                          title: Container(
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Container(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: Text(
                                                                  "${sos.shopName}",
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
                                                                color: (sos
                                                                        .synced)
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .grey,
                                                                size: 16.0,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: (sos.photo !=
                                                                  null)
                                                              ? (sos.fromServer)
                                                                  ? CachedNetworkImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      imageUrl:
                                                                          "${settingsManager.updateProfile.imagestorage}displayaudit/${sos.photo}",
                                                                      errorWidget:
                                                                          (context,
                                                                              url,
                                                                              error) {
                                                                        return Image
                                                                            .asset(
                                                                          "assets/images/noimage.jpg",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          height:
                                                                              250.0,
                                                                        );
                                                                      },
                                                                      height:
                                                                          250.0,
                                                                      width:
                                                                          70.0,
                                                                    )
                                                                  : Image.file(
                                                                      File(
                                                                          "${sos.photo}"),
                                                                      height:
                                                                          250.0,
                                                                      width:
                                                                          70.0,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )
                                                              : Image.asset(
                                                                  "assets/images/noimage.jpg",
                                                                  height: 250.0,
                                                                  width: 250.0,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                                  .all(10.0)
                                                              .copyWith(
                                                                  bottom: 0.0,
                                                                  top: 0.0),
                                                          child: Column(
                                                            children: <Widget>[
                                                              DetailItem(
                                                                title:
                                                                    "Total Facings",
                                                                value:
                                                                    "${sos.totalFacings}",
                                                              ),
                                                              DetailItem(
                                                                title:
                                                                    "Total Length",
                                                                value:
                                                                    "${sos.totalLength}",
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Align(
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .bottomEnd,
                                                            child: Text(
                                                              "${formatDate(sos.entryTime, "dt")}",
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .accentColor,
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
                                                        ...sosManager
                                                            .getSosItemsFor(
                                                                sos.id)
                                                            .map<Widget>(
                                                                (SosItem
                                                                    sosItem) {
                                                          var index = sosManager
                                                              .getSosItemsFor(
                                                                sos.id,
                                                              )
                                                              .indexOf(sosItem);
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
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                DetailItem(
                                                                  title:
                                                                      "Product",
                                                                  value:
                                                                      "${sosItem.productName}",
                                                                ),
                                                                DetailItem(
                                                                  title:
                                                                      "Facings",
                                                                  value:
                                                                      "${sosItem.facings}",
                                                                ),
                                                                DetailItem(
                                                                  title:
                                                                      "Length",
                                                                  value:
                                                                      "${sosItem.length}",
                                                                ),
                                                                DetailItem(
                                                                  title:
                                                                      "Position",
                                                                  value:
                                                                      "${sosItem.position}",
                                                                ),
                                                                DetailItem(
                                                                  title:
                                                                      "Facings Sos",
                                                                  value:
                                                                      "${((double.parse("${sosItem.facings != "" ? sosItem.facings : 0}") / double.parse("${sos.totalFacings != "" ? sos.totalFacings : 0}")) * 100).toStringAsFixed(0)}%",
                                                                ),
                                                                DetailItem(
                                                                  title:
                                                                      "Length Sos",
                                                                  value:
                                                                      "${((double.parse("${sosItem.length != "" ? sosItem.length : 0}") / double.parse("${sos.totalLength != "" ? sos.totalLength : 0}")) * 100).toStringAsFixed(0)}%",
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }).toList(),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
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
