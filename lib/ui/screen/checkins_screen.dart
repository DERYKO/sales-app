import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/checkins_bloc.dart';
import 'package:solutech_sat/bloc/records_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/helpers/timesheet_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/contact_buttons.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/ui/widgets/sticky_header_group.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class CheckinsScreen extends StatelessWidget {
  int initialIndex = 0;
  final bloc = CheckinsBloc();
  CheckinsScreen({this.initialIndex = 0});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          return DefaultTabController(
            length: 2,
            initialIndex: initialIndex,
            child: Scaffold(
              appBar: AppBar(
                title: Text("${roleManager.resolveTitle(
                  title: "Checkin/Checkout",
                  module: Roles.CHECK_IN,
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
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(
                      child: Text("TO VISIT"),
                    ),
                    Tab(
                      child: Text("VISITED"),
                    ),
                  ],
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
                          child: TabBarView(children: [
                            StreamBuilder(
                              stream: locationManager.stream,
                              builder: (context, snapshot) {
                                return StreamBuilder(
                                    stream: routePlansManager.stream,
                                    builder: (context, snapshot) {
                                      return CircularMaterialSpinner(
                                        loading:
                                            routePlansManager.loadingRoutePlans,
                                        child:
                                            (routePlansManager
                                                        .currentRoutePlan !=
                                                    null)
                                                ? FutureBuilder(
                                                    future: routePlansManager
                                                        .getCustomers(
                                                      routePlansManager
                                                          .currentRoutePlan.id,
                                                    ),
                                                    builder: (context,
                                                        AsyncSnapshot<
                                                                List<Customer>>
                                                            snapshot) {
                                                      return ListView(
                                                        children: <Widget>[
                                                          if (sessionManager
                                                                  .sessions
                                                                  .length >
                                                              0)
                                                            ...sessionManager
                                                                .sessions
                                                                .map<Widget>(
                                                                    (session) {
                                                              return GestureDetector(
                                                                onTap: () => (sessionManager
                                                                            .inSession &&
                                                                        sessionManager.session.customerId !=
                                                                            session
                                                                                .customerId)
                                                                    ? bloc.alertInSession(sessionManager
                                                                        .session
                                                                        .customerId)
                                                                    : bloc.viewCustomer(
                                                                        routePlansManager
                                                                            .getCustomerById(session.customerId)),
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets
                                                                          .all(
                                                                              3.0)
                                                                      .copyWith(
                                                                          bottom:
                                                                              0.0),
                                                                  color: Colors
                                                                          .grey[
                                                                      100],
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsets.only(
                                                                              left: 5.0,
                                                                              right: 5.0),
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.only(bottom: 5.0),
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: <Widget>[
                                                                                    Flexible(
                                                                                      child: Text(
                                                                                        "${routePlansManager.getCustomerById(session.customerId)?.shopName ?? ""}",
                                                                                        style: TextStyle(
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontSize: 16.0,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: <Widget>[
                                                                                    Flexible(
                                                                                      child: Container(
                                                                                        padding: EdgeInsets.only(
                                                                                          left: 5.0,
                                                                                          right: 5.0,
                                                                                          top: 2.0,
                                                                                          bottom: 2.0,
                                                                                        ),
                                                                                        child: Text(
                                                                                          "${session.endTime == null ? "Active" : timeDifference(session.startTime.toIso8601String(), session.endTime.toIso8601String())}",
                                                                                          style: TextStyle(fontSize: 15.0, color: session.endTime == null ? Colors.white : Colors.black54),
                                                                                        ),
                                                                                        decoration: BoxDecoration(color: session.endTime == null ? Colors.green : Colors.transparent, borderRadius: BorderRadius.circular(2.0)),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                if (session.startTime != null)
                                                                                  Row(
                                                                                    children: <Widget>[
                                                                                      Text(
                                                                                        "Check in:",
                                                                                        style: TextStyle(
                                                                                          color: Colors.black87,
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(left: 5.0),
                                                                                        child: Text(
                                                                                          "${formatDate(session.startTime, "jms")}",
                                                                                          style: TextStyle(
                                                                                            color: Colors.black54,
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                if (session.endTime != null)
                                                                                  Padding(
                                                                                    padding: EdgeInsets.only(top: 3.0),
                                                                                    child: Row(
                                                                                      children: <Widget>[
                                                                                        Text(
                                                                                          "Check out:",
                                                                                          style: TextStyle(
                                                                                            color: Colors.black87,
                                                                                            fontWeight: FontWeight.w500,
                                                                                          ),
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.only(left: 5.0),
                                                                                          child: Text(
                                                                                            "${formatDate(session.endTime, "jms")}",
                                                                                            style: TextStyle(
                                                                                              color: Colors.black54,
                                                                                            ),
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                Align(
                                                                                  alignment: AlignmentDirectional.bottomEnd,
                                                                                  child: Text(
                                                                                    "${formatDate(session.startTime, "dt")}",
                                                                                    style: TextStyle(
                                                                                      color: Theme.of(context).accentColor,
                                                                                      fontSize: 11.0,
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            decoration: BoxDecoration(
                                                                                border: Border(
                                                                                    bottom: BorderSide(
                                                                              color: Colors.grey[200],
                                                                            ))),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            }).toList(),
                                                          ...snapshot.data
                                                              .where((customer) => !sessionManager
                                                                  .sessions
                                                                  .map<int>(
                                                                      (session) =>
                                                                          session
                                                                              .customerId)
                                                                  .toList()
                                                                  .contains(
                                                                      customer
                                                                          .id))
                                                              .map<Widget>(
                                                                  (customer) {
                                                            return GestureDetector(
                                                              onTap: () => (sessionManager
                                                                          .inSession &&
                                                                      sessionManager
                                                                              .session
                                                                              .customerId !=
                                                                          customer
                                                                              .id)
                                                                  ? bloc.alertInSession(
                                                                      sessionManager
                                                                          .session
                                                                          .customerId)
                                                                  : bloc.viewCustomer(
                                                                      customer),
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10.0),
                                                                child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      height:
                                                                          60.0,
                                                                      width:
                                                                          60.0,
                                                                      color: Colors
                                                                              .grey[
                                                                          200],
                                                                      margin: EdgeInsets
                                                                          .only(
                                                                        right:
                                                                            5.0,
                                                                      ),
                                                                      child: (customer.photo !=
                                                                              null)
                                                                          ? (customer.fromServer && !customer.photo.contains("com.solutech.sat"))
                                                                              ? CachedNetworkImage(
                                                                                  fit: BoxFit.cover,
                                                                                  imageUrl: "${settingsManager.updateProfile.imagestorage}customers/${customer.photo}",
                                                                                  errorWidget: (context, url, error) {
                                                                                    return Image.asset(
                                                                                      "assets/images/noimage.jpg",
                                                                                      fit: BoxFit.cover,
                                                                                      height: 70.0,
                                                                                      width: 70.0,
                                                                                    );
                                                                                  },
                                                                                  height: 70.0,
                                                                                  width: 70.0,
                                                                                )
                                                                              : Image.file(
                                                                                  File("${customer.photo}"),
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
                                                                      child:
                                                                          Column(
                                                                        children: <
                                                                            Widget>[
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: <Widget>[
                                                                              Text(
                                                                                "${customer.shopName.toUpperCase()}",
                                                                                style: TextStyle(
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                              Text("${bloc.customerType(customer.shopCatId)}")
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: <Widget>[
                                                                              Expanded(
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: <Widget>[
                                                                                    if (customer.verified == "Valid")
                                                                                      Row(
                                                                                        children: <Widget>[
                                                                                          Icon(
                                                                                            Icons.verified_user,
                                                                                            size: 15.0,
                                                                                            color: Colors.green,
                                                                                          ),
                                                                                          Text(
                                                                                            "${customer.verified}",
                                                                                            style: TextStyle(
                                                                                              color: Colors.green,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ((double.parse("${customer.slatitude ?? 0}") != 0)
                                                                                        ? FutureBuilder(
                                                                                            future: locationManager.calculateDistance(
                                                                                              double.parse("${customer.slatitude}"),
                                                                                              double.parse("${customer.slongitude}"),
                                                                                            ),
                                                                                            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                                                                              if (snapshot.hasData) {
                                                                                                if (snapshot.data != null) {
                                                                                                  return Container(
                                                                                                    child: Text(
                                                                                                      "${snapshot.data}",
                                                                                                    ),
                                                                                                  );
                                                                                                } else {
                                                                                                  return Container();
                                                                                                }
                                                                                              } else {
                                                                                                return Container();
                                                                                              }
                                                                                            },
                                                                                          )
                                                                                        : Text(
                                                                                            "No location",
                                                                                          ))
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  border:
                                                                      Border(
                                                                    bottom:
                                                                        BorderSide(
                                                                      color: Colors
                                                                              .grey[
                                                                          200],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                        ],
                                                      );
                                                    })
                                                : Container(
                                                    padding: EdgeInsets.only(
                                                        left: 20.0,
                                                        right: 20.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Image.asset(
                                                          "assets/images/location.png",
                                                          height: 100.0,
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Text(
                                                            "NO ROUTE PLAN",
                                                            style: TextStyle(
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          "Make sure you have been assigned a route plan for checkins todays.",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            color:
                                                                Colors.black54,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                      );
                                    });
                              },
                            ),
                            StreamBuilder(
                                stream: timesheetManager.stream,
                                builder: (context, snapshot) {
                                  return CircularMaterialSpinner(
                                    loading: timesheetManager.loadingTimesheets,
                                    child: ListView(
                                      children: [
                                        ...timesheetManager.timesheets
                                            .map((timesheet) {
                                          return Container(
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.all(3.0)
                                                      .copyWith(
                                                    bottom: 12.0,
                                                  ),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5.0,
                                                                  right: 5.0),
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                        5.0),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: <
                                                                  Widget>[
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    Flexible(
                                                                      child:
                                                                          Text(
                                                                        "${routePlansManager.getCustomerById(timesheet.branchId)?.shopName ?? ""}",
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize:
                                                                              16.0,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: <
                                                                      Widget>[
                                                                    Flexible(
                                                                      child:
                                                                          Text(
                                                                        "${timesheet.checkoutTime == null ? "Active" : timeDifference(timesheet.checkinTime.toIso8601String(), timesheet.checkoutTime.toIso8601String())}",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15.0,
                                                                          color:
                                                                              Colors.black54,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                if (timesheet
                                                                        .checkinTime !=
                                                                    null)
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        "Check in:",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black87,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 5.0),
                                                                        child:
                                                                            Text(
                                                                          "${formatDate(timesheet.checkinTime, "jms")}",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black54,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                if (timesheet
                                                                        .checkoutTime !=
                                                                    null)
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        "Check out:",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black87,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 5.0),
                                                                        child:
                                                                            Text(
                                                                          "${formatDate(timesheet.checkoutTime, "jms")}",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black54,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional
                                                                          .bottomEnd,
                                                                  child: Text(
                                                                    "${formatDate(timesheet.checkinTime, "dt")}",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .accentColor,
                                                                      fontSize:
                                                                          11.0,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            decoration: BoxDecoration(
                                                                border: Border(
                                                                    bottom: BorderSide(
                                                              color: Colors
                                                                  .grey[200],
                                                            ))),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                        ...sessionManager.sessions
                                            .map<Widget>((session) {
                                          return Container(
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.all(3.0)
                                                      .copyWith(
                                                    bottom: 12.0,
                                                  ),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 5.0,
                                                                  right: 5.0),
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                        5.0),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: <
                                                                  Widget>[
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: <
                                                                      Widget>[
                                                                    Flexible(
                                                                      child:
                                                                          Text(
                                                                        "${routePlansManager.getCustomerById(session.customerId)?.shopName ?? ""}",
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize:
                                                                              16.0,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: <
                                                                      Widget>[
                                                                    Flexible(
                                                                      child:
                                                                          Text(
                                                                        "${session.endTime == null ? "Active" : timeDifference(session.startTime.toIso8601String(), session.endTime.toIso8601String())}",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              15.0,
                                                                          color:
                                                                              Colors.black54,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                if (session
                                                                        .startTime !=
                                                                    null)
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        "Check in:",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black87,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 5.0),
                                                                        child:
                                                                            Text(
                                                                          "${formatDate(session.startTime, "jms")}",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black54,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                if (session
                                                                        .endTime !=
                                                                    null)
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        "Check out:",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black87,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(left: 5.0),
                                                                        child:
                                                                            Text(
                                                                          "${formatDate(session.endTime, "jms")}",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black54,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional
                                                                          .bottomEnd,
                                                                  child: Text(
                                                                    "${formatDate(session.startTime, "dt")}",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .accentColor,
                                                                      fontSize:
                                                                          11.0,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            decoration: BoxDecoration(
                                                                border: Border(
                                                                    bottom: BorderSide(
                                                              color: Colors
                                                                  .grey[200],
                                                            ))),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList()
                                      ],
                                    ),
                                  );
                                }),
                          ]),
                        ),
                        Footer(),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
