import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/photos_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/general_photo.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/general_photos_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class PhotosScreen extends StatelessWidget {
  final bloc = PhotosBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: AutoSizeText("${roleManager.resolveTitle(
            title: "Photos",
            module: Roles.IMAGES,
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
                          stream: generalPhotosManager.stream,
                          builder: (context, snapshot) {
                            return CircularMaterialSpinner(
                              loading:
                                  generalPhotosManager.loadingGeneralPhotos,
                              child: ListView.builder(
                                itemCount:
                                    generalPhotosManager.generalPhotos.length,
                                itemBuilder: (context, index) {
                                  GeneralPhoto generalPhoto =
                                      generalPhotosManager.generalPhotos[index];

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
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          "${routePlansManager.getCustomerById(generalPhoto.shopId)?.shopName}",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.done_all,
                                                        color: (generalPhoto
                                                                .synced)
                                                            ? Colors.green
                                                            : Colors.grey,
                                                        size: 16.0,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // n-

                                                (generalPhoto.fromServer)
                                                    ? CachedNetworkImage(
                                                        fit: BoxFit.cover,
                                                        imageUrl:
                                                            "${settingsManager.updateProfile.imagestorage}generalphotos/${generalPhoto.imagePhoto}",
                                                        errorWidget: (context,
                                                            url, error) {
                                                          return Image.asset(
                                                            "assets/images/noimage.jpg",
                                                            fit: BoxFit.cover,
                                                            height: 250.0,
                                                            width:
                                                                double.infinity,
                                                          );
                                                        },
                                                        height: 250.0,
                                                        width: double.infinity,
                                                      )
                                                    : Image.file(
                                                        File(
                                                          "${generalPhoto.imagePhoto}",
                                                        ),
                                                        height: 250.0,
                                                        width: double.infinity,
                                                        fit: BoxFit.cover),

                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    "Category: ${generalPhoto.imageCategory}",
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0)
                                                          .copyWith(top: 0.0),
                                                  child: Text(
                                                    "Activity: ${commonsManager.appData.firstWhere((appData) => appData.appdataId == generalPhoto.activityId, orElse: () => null)?.data ?? ""}",
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0)
                                                          .copyWith(top: 0.0),
                                                  child: Text(
                                                    "Product category: ${generalPhoto.productCategory}",
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0)
                                                          .copyWith(top: 0.0),
                                                  child: Text(
                                                    "${generalPhoto.imageNotes}",
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .bottomEnd,
                                                    child: Text(
                                                      "${formatDate(generalPhoto.imageTime, "dt")}",
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
                                },
                              ),
                            );
                          },
                        ),
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
