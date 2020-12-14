import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solutech_sat/bloc/add_edit_customer_bloc.dart';
import 'package:solutech_sat/bloc/add_stock_bloc.dart';
import 'package:solutech_sat/bloc/status_updates_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/status_update.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class StatusUpdatesScreen extends StatelessWidget {
  StatusUpdatesBloc bloc;

  Color updateColor(StatusUpdate statusUpdate) {
    return (statusUpdate.status == "Approved")
        ? Colors.green
        : (statusUpdate.status == "Rejected") ? Colors.red : Colors.black54;
  }

  StatusUpdatesScreen({
    Customer customer,
    String mode,
  }) : bloc = StatusUpdatesBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    "${roleManager.resolveTitle(
                      title: "Status updates",
                      module: Roles.STATUS_UPDATE,
                    )}",
                  ),
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
                  bottom: TabBar(
                    tabs: [
                      Tab(text: "PENDING"),
                      Tab(text: "APPROVED"),
                      Tab(text: "REJECTED"),
                    ],
                    indicatorColor: Colors.white,
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
                              child: CircularMaterialSpinner(
                                loading: recordsManager.loadingStatusUpdates,
                                child: TabBarView(children: [
                                  ListView.builder(
                                      itemCount: recordsManager
                                          .pendingStatusUpdates.length,
                                      itemBuilder: (context, index) {
                                        print(
                                            "The length is: ${recordsManager.pendingStatusUpdates.length}");
                                        var statusUpdates = recordsManager
                                            .pendingStatusUpdates[index];
                                        return Container(
                                          padding: EdgeInsets.all(3.0).copyWith(
                                            bottom: 12.0,
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                child: (statusUpdates
                                                            .statusPhoto !=
                                                        null)
                                                    ? (statusUpdates.fromServer)
                                                        ? CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            imageUrl:
                                                                "${settingsManager.updateProfile.imagestorage}statusupdate/${statusUpdates.statusPhoto}",
                                                            errorWidget:
                                                                (context, url,
                                                                    error) {
                                                              return Image
                                                                  .asset(
                                                                "assets/images/noimage.jpg",
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: 70.0,
                                                                width: 70.0,
                                                              );
                                                            },
                                                            height: 70.0,
                                                            width: 70.0,
                                                          )
                                                        : Image.file(
                                                            File(
                                                                "${statusUpdates.statusPhoto}"),
                                                            height: 70.0,
                                                            width: 70.0,
                                                            fit: BoxFit.cover,
                                                          )
                                                    : Image.asset(
                                                        "assets/images/noimage.jpg",
                                                        height: 70.0,
                                                        width: 70.0,
                                                      ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0),
                                                  child: Container(
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
                                                                "${statusUpdates.statusCategory}",
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      15.0,
                                                                ),
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons.done_all,
                                                              color:
                                                                  (statusUpdates
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
                                                                "${statusUpdates.statusNotes ?? ""}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  color: Colors
                                                                      .black54,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5.0),
                                                              child: Text(
                                                                "${formatDate(statusUpdates.statusTime, "dt")}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.0),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Flexible(
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Icon(
                                                                      (statusUpdates.status ==
                                                                              "Approved")
                                                                          ? Icons
                                                                              .check
                                                                          : (statusUpdates.status == "Rejected")
                                                                              ? Icons
                                                                                  .close
                                                                              : Icons
                                                                                  .update,
                                                                      size:
                                                                          15.0,
                                                                      color: updateColor(
                                                                          statusUpdates)),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5.0),
                                                                    child: Text(
                                                                      "${statusUpdates.status ?? "Pending"}",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12.0,
                                                                        color: Colors
                                                                            .black87,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            if (statusUpdates
                                                                        .status !=
                                                                    "Pending" &&
                                                                statusUpdates
                                                                        .status !=
                                                                    null)
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            5.0),
                                                                child: Text(
                                                                  "${statusUpdates.approver ?? ""}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                        if (statusUpdates
                                                                    .status !=
                                                                "Pending" &&
                                                            statusUpdates
                                                                    .status !=
                                                                null)
                                                          Container(
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .centerStart,
                                                            child: Text(
                                                              "${statusUpdates.approvalNotes}",
                                                              style: TextStyle(
                                                                fontSize: 12.0,
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                            ),
                                                          ),
                                                        if (statusUpdates
                                                                    .status !=
                                                                "Pending" &&
                                                            statusUpdates
                                                                    .status !=
                                                                null)
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: <Widget>[
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            5.0),
                                                                child: Text(
                                                                  "${formatDate(statusUpdates.approvalTime)} ${formatDate(statusUpdates.approvalTime, "jm")}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        11.0,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey[300],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                  ListView.builder(
                                      itemCount: recordsManager
                                          .approvedStatusUpdates.length,
                                      itemBuilder: (context, index) {
                                        print(
                                            "The length is: ${recordsManager.approvedStatusUpdates.length}");
                                        var statusUpdates = recordsManager
                                            .approvedStatusUpdates[index];
                                        return Container(
                                          padding: EdgeInsets.all(3.0).copyWith(
                                            bottom: 12.0,
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                child: (statusUpdates
                                                            .statusPhoto !=
                                                        null)
                                                    ? (statusUpdates.fromServer)
                                                        ? CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            imageUrl:
                                                                "${settingsManager.updateProfile.imagestorage}statusupdate/${statusUpdates.statusPhoto}",
                                                            errorWidget:
                                                                (context, url,
                                                                    error) {
                                                              return Image
                                                                  .asset(
                                                                "assets/images/noimage.jpg",
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: 70.0,
                                                                width: 70.0,
                                                              );
                                                            },
                                                            height: 70.0,
                                                            width: 70.0,
                                                          )
                                                        : Image.file(
                                                            File(
                                                                "${statusUpdates.statusPhoto}"),
                                                            height: 70.0,
                                                            width: 70.0,
                                                            fit: BoxFit.cover,
                                                          )
                                                    : Image.asset(
                                                        "assets/images/noimage.jpg",
                                                        height: 70.0,
                                                        width: 70.0,
                                                      ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0),
                                                  child: Container(
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
                                                                "${statusUpdates.statusCategory}",
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      15.0,
                                                                ),
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons.done_all,
                                                              color:
                                                                  (statusUpdates
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
                                                                "${statusUpdates.statusNotes ?? ""}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  color: Colors
                                                                      .black54,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5.0),
                                                              child: Text(
                                                                "${formatDate(statusUpdates.statusTime, "dt")}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.0),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Flexible(
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Icon(
                                                                      (statusUpdates.status ==
                                                                              "Approved")
                                                                          ? Icons
                                                                              .check
                                                                          : (statusUpdates.status == "Rejected")
                                                                              ? Icons
                                                                                  .close
                                                                              : Icons
                                                                                  .update,
                                                                      size:
                                                                          15.0,
                                                                      color: updateColor(
                                                                          statusUpdates)),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5.0),
                                                                    child: Text(
                                                                      "${statusUpdates.status ?? "Pending"}",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12.0,
                                                                        color: Colors
                                                                            .black87,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            if (statusUpdates
                                                                        .status !=
                                                                    "Pending" &&
                                                                statusUpdates
                                                                        .status !=
                                                                    null)
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            5.0),
                                                                child: Text(
                                                                  "${statusUpdates.approver ?? ""}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                        if (statusUpdates
                                                                    .status !=
                                                                "Pending" &&
                                                            statusUpdates
                                                                    .status !=
                                                                null)
                                                          Container(
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .centerStart,
                                                            child: Text(
                                                              "${statusUpdates.approvalNotes}",
                                                              style: TextStyle(
                                                                fontSize: 12.0,
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                            ),
                                                          ),
                                                        if (statusUpdates
                                                                    .status !=
                                                                "Pending" &&
                                                            statusUpdates
                                                                    .status !=
                                                                null)
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: <Widget>[
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            5.0),
                                                                child: Text(
                                                                  "${formatDate(statusUpdates.approvalTime)} ${formatDate(statusUpdates.approvalTime, "jm")}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        11.0,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey[300],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                  ListView.builder(
                                      itemCount: recordsManager
                                          .rejectedStatusUpdates.length,
                                      itemBuilder: (context, index) {
                                        print(
                                            "The length is: ${recordsManager.rejectedStatusUpdates.length}");
                                        var statusUpdates = recordsManager
                                            .rejectedStatusUpdates[index];
                                        return Container(
                                          padding: EdgeInsets.all(3.0).copyWith(
                                            bottom: 12.0,
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                child: (statusUpdates
                                                            .statusPhoto !=
                                                        null)
                                                    ? (statusUpdates.fromServer)
                                                        ? CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            imageUrl:
                                                                "${settingsManager.updateProfile.imagestorage}statusupdate/${statusUpdates.statusPhoto}",
                                                            errorWidget:
                                                                (context, url,
                                                                    error) {
                                                              return Image
                                                                  .asset(
                                                                "assets/images/noimage.jpg",
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: 70.0,
                                                                width: 70.0,
                                                              );
                                                            },
                                                            height: 70.0,
                                                            width: 70.0,
                                                          )
                                                        : Image.file(
                                                            File(
                                                                "${statusUpdates.statusPhoto}"),
                                                            height: 70.0,
                                                            width: 70.0,
                                                            fit: BoxFit.cover,
                                                          )
                                                    : Image.asset(
                                                        "assets/images/noimage.jpg",
                                                        height: 70.0,
                                                        width: 70.0,
                                                      ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0),
                                                  child: Container(
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
                                                                "${statusUpdates.statusCategory}",
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      15.0,
                                                                ),
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons.done_all,
                                                              color:
                                                                  (statusUpdates
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
                                                                "${statusUpdates.statusNotes ?? ""}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  color: Colors
                                                                      .black54,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5.0),
                                                              child: Text(
                                                                "${formatDate(statusUpdates.statusTime, "jm")}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.0),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Flexible(
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Icon(
                                                                      (statusUpdates.status ==
                                                                              "Approved")
                                                                          ? Icons
                                                                              .check
                                                                          : (statusUpdates.status == "Rejected")
                                                                              ? Icons
                                                                                  .close
                                                                              : Icons
                                                                                  .update,
                                                                      size:
                                                                          15.0,
                                                                      color: updateColor(
                                                                          statusUpdates)),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5.0),
                                                                    child: Text(
                                                                      "${statusUpdates.status ?? "Pending"}",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12.0,
                                                                        color: Colors
                                                                            .black87,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            if (statusUpdates
                                                                        .status !=
                                                                    "Pending" &&
                                                                statusUpdates
                                                                        .status !=
                                                                    null)
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            5.0),
                                                                child: Text(
                                                                  "${statusUpdates.approver ?? ""}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                        if (statusUpdates
                                                                    .status !=
                                                                "Pending" &&
                                                            statusUpdates
                                                                    .status !=
                                                                null)
                                                          Container(
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .centerStart,
                                                            child: Text(
                                                              "${statusUpdates.approvalNotes}",
                                                              style: TextStyle(
                                                                fontSize: 12.0,
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                            ),
                                                          ),
                                                        if (statusUpdates
                                                                    .status !=
                                                                "Pending" &&
                                                            statusUpdates
                                                                    .status !=
                                                                null)
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: <Widget>[
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            5.0),
                                                                child: Text(
                                                                  "${formatDate(statusUpdates.approvalTime)} ${formatDate(statusUpdates.approvalTime, "jm")}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        11.0,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey[300],
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                ]),
                              ),
                            ),
                            Footer(),
                          ],
                        ),
                      );
                    }),
                floatingActionButton: FloatingActionButton(
                  onPressed: bloc.addStatusUpdate,
                  child: Icon(Icons.add),
                ),
              ),
            );
          }),
    );
  }
}
