import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Feedback;
import 'package:flutter/services.dart';
import 'package:solutech_sat/bloc/add_edit_customer_bloc.dart';
import 'package:solutech_sat/bloc/add_stock_bloc.dart';
import 'package:solutech_sat/bloc/feedbacks_bloc.dart';
import 'package:solutech_sat/bloc/status_updates_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/feedback.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/status_update.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class FeedbacksScreen extends StatelessWidget {
  FeedbacksBloc bloc;

  Color updateColor(FeedbacksBloc statusUpdate) {
    return Colors.black54;
  }

  FeedbacksScreen({
    Customer customer,
    String mode,
  }) : bloc = FeedbacksBloc();

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
                  title: Text(
                    "${roleManager.resolveTitle(
                      title: "Feedback",
                      module: Roles.FEEDBACK,
                    )}",
                  ),
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
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        text: "PENDING",
                      ),
                      Tab(
                        text: "RESOLVED",
                      ),
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
                                loading: recordsManager.loadingFeedbacks,
                                child: TabBarView(children: [
                                  ListView.builder(
                                      itemCount: recordsManager
                                          .pendingFeedbacks.length,
                                      itemBuilder: (context, index) {
                                        print(
                                            "The length is: ${recordsManager.pendingFeedbacks.length}");
                                        Feedback feedback = recordsManager
                                            .pendingFeedbacks[index];
                                        return GestureDetector(
                                          onTap: () => bloc
                                              .openFeedbackComments(feedback),
                                          child: Container(
                                            padding:
                                                EdgeInsets.all(3.0).copyWith(
                                              bottom: 12.0,
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  child: (feedback.photo !=
                                                          null)
                                                      ? (feedback.fromServer)
                                                          ? CachedNetworkImage(
                                                              fit: BoxFit.cover,
                                                              imageUrl:
                                                                  "${settingsManager.updateProfile.imagestorage}generalfeedback/${feedback.photo}",
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
                                                                  "${feedback.photo}"),
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
                                                                  "${feedback.category}",
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
                                                                color: (feedback
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
                                                                  "${feedback.notes ?? ""}",
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
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10.0),
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Expanded(
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Icon(
                                                                        (feedback.status == "Pending" ||
                                                                                feedback.status == null)
                                                                            ? Icons.update
                                                                            : Icons.check,
                                                                        size:
                                                                            15.0,
                                                                        color: (feedback.status == "Pending" ||
                                                                                feedback.status == null)
                                                                            ? Colors.black54
                                                                            : Colors.green,
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 5.0),
                                                                        child:
                                                                            Text(
                                                                          "${feedback.status ?? "Pending"}",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                13.0,
                                                                            color:
                                                                                Colors.black54,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5.0),
                                                                  child: Text(
                                                                    "${formatDate(feedback.entryTime)} ${formatDate(feedback.entryTime, "jm")}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12.0),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )
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
                                            ))),
                                          ),
                                        );
                                      }),
                                  ListView.builder(
                                      itemCount: recordsManager
                                          .resolvedFeedbacks.length,
                                      itemBuilder: (context, index) {
                                        print(
                                            "The length is: ${recordsManager.resolvedFeedbacks.length}");
                                        var feedbacks = recordsManager
                                            .resolvedFeedbacks[index];
                                        return Container(
                                          padding: EdgeInsets.all(3.0).copyWith(
                                            bottom: 12.0,
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                child: (feedbacks.photo != null)
                                                    ? (feedbacks.fromServer)
                                                        ? CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            imageUrl:
                                                                "${settingsManager.updateProfile.imagestorage}generalfeedback/${feedbacks.photo}",
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
                                                                "${feedbacks.photo}"),
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
                                                                "${feedbacks.category}",
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
                                                              color: (feedbacks
                                                                      .synced)
                                                                  ? Colors.green
                                                                  : Colors.grey,
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
                                                                "${feedbacks.notes ?? ""}",
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
                                                                "${formatDate(feedbacks.entryTime, "jm")}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.0),
                                                              ),
                                                            )
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
                                          ))),
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
                  onPressed: (dayManager.closedDay)
                      ? bloc.showClosedDayDialog
                      : bloc.addFeedback,
                  child: Icon(Icons.add),
                ),
              ),
            );
          }),
    );
  }
}
