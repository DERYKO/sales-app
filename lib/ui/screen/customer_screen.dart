import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/customer_bloc.dart';
import 'package:solutech_sat/bloc/customers_bloc.dart';
import 'package:solutech_sat/bloc/records_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/route_plan.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/availability_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/competitor_activities_manager.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/general_photos_manager.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/payments_manager.dart';
import 'package:solutech_sat/helpers/posm_manager.dart';
import 'package:solutech_sat/helpers/product_availability_manager.dart';
import 'package:solutech_sat/helpers/product_updates_manager.dart';
import 'package:solutech_sat/helpers/profile_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/helpers/sod_manager.dart';
import 'package:solutech_sat/helpers/sos_manager.dart';
import 'package:solutech_sat/helpers/stock_takes_manager.dart';
import 'package:solutech_sat/helpers/stockpoints_manager.dart';
import 'package:solutech_sat/helpers/surveys_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/contact_buttons.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class CustomerScreen extends StatelessWidget {
  CustomerBloc bloc;

  CustomerScreen({
    RoutePlan routePlan,
    Customer customer,
  }) : bloc = CustomerBloc(
          routePlan: routePlan,
          customer: customer,
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
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FittedBox(
                      child: Text("${bloc.customer.shopName.toUpperCase()}"),
                    ),
                    Text(
                      "Customer",
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
              body: StreamBuilder(
                stream: sessionManager.stream,
                builder: (context, snapshot) {
                  return Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    if (!sessionManager.inSession)
                                      Stack(
                                        children: <Widget>[
                                          Container(
                                            height: 190.0,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Colors.grey[200],
                                            child: (bloc.customer.photo != null)
                                                ? (bloc.customer.fromServer &&
                                                        !bloc.customer.photo
                                                            .contains(
                                                                "com.solutech.sat"))
                                                    ? CachedNetworkImage(
                                                        fit: BoxFit.cover,
                                                        imageUrl:
                                                            "${settingsManager.updateProfile.imagestorage}customers/${bloc.customer.photo}",
                                                        errorWidget: (context,
                                                            url, error) {
                                                          return Image.asset(
                                                              "assets/images/noimage.jpg",
                                                              fit: BoxFit.cover,
                                                              height: 60.0);
                                                        },
                                                        height: 60.0,
                                                        width: 70.0,
                                                      )
                                                    : Image.file(
                                                        File(
                                                            "${bloc.customer.photo}"),
                                                        height: 60.0,
                                                        fit: BoxFit.cover,
                                                      )
                                                : Image.asset(
                                                    "assets/images/noimage.jpg",
                                                    height: 60.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                          Positioned(
                                            right: 2.0,
                                            bottom: 0.0,
                                            child: FlatButton(
                                              color:
                                                  Theme.of(context).accentColor,
                                              onPressed: bloc.editCustomer,
                                              textColor: Colors.white,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.edit,
                                                    size: 18.0,
                                                  ),
                                                  Container(
                                                    width: 3.0,
                                                  ),
                                                  Text("Edit"),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 10.0,
                                      ),
                                      child: Wrap(
                                        direction: Axis.horizontal,
                                        spacing: 10.0,
                                        runSpacing: 5.0,
                                        alignment: WrapAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Icon(Icons.store),
                                              Text(
                                                "${commonsManager.shopCatById(bloc.customer.shopCatId)?.shopCatName ?? ""}",
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Icon(Icons.date_range),
                                              Text(
                                                "${formatDate(bloc.customer.createdAt)}",
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Icon(
                                                Icons.verified_user,
                                                size: 20.0,
                                                color:
                                                    (bloc.customer.verified ==
                                                            "Valid")
                                                        ? Colors.green
                                                        : Colors.black54,
                                              ),
                                              Text(
                                                "${bloc.customer.verified}",
                                                style: TextStyle(
                                                    color: Colors.black54),
                                              ),
                                            ],
                                          ),
                                          if (bloc.customer.contactPerson !=
                                              null)
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Icon(Icons.person),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5.0),
                                                  child: Text(
                                                    "${bloc.customer.contactPerson}",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (bloc.customer.shopPhoneno != null)
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Icon(Icons.phone),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5.0),
                                                  child: Text(
                                                    "${bloc.customer.shopPhoneno}",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (bloc.customer.locationId !=
                                                  null &&
                                              locationManager
                                                      .getUserLocationById(bloc
                                                          .customer.locationId)
                                                      ?.locationName !=
                                                  null)
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.location_on,
                                                  size: 20.0,
                                                  color: Colors.black,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 5.0,
                                                  ),
                                                  child: Text(
                                                    "${locationManager.getUserLocationById(bloc.customer.locationId)?.locationName}",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (paymentsManager.getBalanceFor(
                                                  bloc.customer.id) >
                                              0)
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.monetization_on,
                                                  size: 20.0,
                                                  color: Colors.black,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 5.0,
                                                  ),
                                                  child: Text(
                                                    "BAL: ",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 5.0,
                                                  ),
                                                  child: Text(
                                                    "${authManager.user.country?.currencySymbol} ${paymentsManager.getBalanceFor(bloc.customer.id)}",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          if (bloc.customer.address != null)
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.location_city,
                                                      size: 20.0,
                                                      color: Colors.black,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 5.0,
                                                      ),
                                                      child: Text(
                                                        "${bloc.customer.address}",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                    if (bloc.customer.loyaltyEnrolledAt !=
                                            null ||
                                        bloc.customer.pezeshaEnrolledAt != null)
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 10.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            if (bloc.customer
                                                    .loyaltyEnrolledAt !=
                                                null)
                                              Image.asset(
                                                "assets/images/mzawadi.png",
                                                height: 20.0,
                                              ),
                                            if (bloc.customer
                                                    .pezeshaEnrolledAt !=
                                                null)
                                              Image.asset(
                                                "assets/images/pezesha.png",
                                                height: 20.0,
                                              )
                                          ],
                                        ),
                                      ),
                                    StreamBuilder(
                                        stream: locationManager.stream,
                                        builder: (context, snapshot) {
                                          return Container(
                                            padding: EdgeInsets.all(10.0),
                                            child: (double.parse(
                                                        "${bloc.customer?.slatitude ?? 0}") !=
                                                    double.parse(
                                                        "${bloc.customer?.slongitude ?? 0}"))
                                                ? FutureBuilder(
                                                    future: locationManager
                                                        .calculateDistance(
                                                      double.parse(
                                                          "${bloc.customer?.slatitude ?? 0}"),
                                                      double.parse(
                                                          "${bloc.customer?.slongitude ?? 0}"),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      var distanceAway =
                                                          snapshot.data;
                                                      return Column(
                                                        children: <Widget>[
                                                          if (roleManager
                                                              .hasRole(Roles
                                                                  .GEOFENCE))
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: FutureBuilder<
                                                                      double>(
                                                                  future: locationManager
                                                                      .distanceInMeters(
                                                                    bloc.customer
                                                                        .slatitude,
                                                                    bloc.customer
                                                                        .slongitude,
                                                                  ),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    return Text(
                                                                      "$distanceAway away, accuracy: ${locationManager?.position?.accuracy?.toStringAsFixed(2) ?? ""} m"
                                                                          .toUpperCase(),
                                                                      style: (snapshot.data !=
                                                                              null)
                                                                          ? TextStyle(
                                                                              color: (snapshot.data > double.parse("${settingsManager.updateProfile.geofenceradius}")) ? Colors.red : Colors.green,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12.0,
                                                                            )
                                                                          : null,
                                                                    );
                                                                  }),
                                                            ),
                                                          StreamBuilder(
                                                            stream:
                                                                sessionManager
                                                                    .stream,
                                                            builder: (context,
                                                                index) {
                                                              return (!sessionManager
                                                                      .inSession)
                                                                  ? OutlineButton(
                                                                      onPressed:
                                                                          () =>
                                                                              bloc.showDirection(),
                                                                      textColor:
                                                                          Theme.of(context)
                                                                              .primaryColor,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: <
                                                                            Widget>[
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(right: 8.0),
                                                                            child:
                                                                                Icon(Icons.directions),
                                                                          ),
                                                                          Text(
                                                                              "DIRECTIONS")
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : Container();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    })
                                                : Container(
                                                    child: Text(
                                                      "No Coordinates",
                                                    ),
                                                  ),
                                          );
                                        }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!sessionManager.inSession)
                          Expanded(
                            child: Container(),
                          ),
                        Expanded(
                            flex: sessionManager.inSession ? 1 : 0,
                            child: StreamBuilder(
                              stream: sessionManager.stream,
                              builder: (context, snapshot) {
                                return (sessionManager.inSession)
                                    ? Container(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withAlpha(10),
                                        padding: EdgeInsets.only(
                                          top: 1.0,
                                          bottom: 5.0,
                                        ),
                                        child: ListView(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(
                                                10.0,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      "Checkin: ${formatDate(sessionManager.session.startTime, "jms")}",
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    child: Text(
                                                      "${sessionManager.timeIn}",
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  MaterialButton(
                                                    onPressed: bloc.checkOut,
                                                    color: Colors.red,
                                                    child: Text(
                                                      "CHECK OUT",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Wrap(
                                              children: <Widget>[
                                                if (roleManager
                                                    .hasRole(Roles.POSM_AUDIT))
                                                  OptionItem(
                                                    onTap: bloc.onPosmAudit,
                                                    title: roleManager
                                                        .resolveTitle(
                                                      title: "POSM",
                                                      module: Roles.POSM_AUDIT,
                                                      capitalize: true,
                                                    ),
                                                    assetImage:
                                                        "assets/images/pos.png",
                                                    isDone: posmManager
                                                        .hasTodaysRecord(
                                                      bloc.customer.id,
                                                    ),
                                                  ),
                                                if (roleManager.hasRole(
                                                    Roles.BRAND_AVAILABILITY))
                                                  OptionItem(
                                                    onTap: bloc.onBrandAudit,
                                                    title: roleManager
                                                        .resolveTitle(
                                                      title: "BRAND AUDIT",
                                                      module: Roles
                                                          .BRAND_AVAILABILITY,
                                                      capitalize: true,
                                                    ),
                                                    assetImage:
                                                        "assets/images/order.png",
                                                    isDone: availabilityManager
                                                        .hasTodaysRecord(
                                                      bloc.customer.id,
                                                    ),
                                                  ),
                                                if (roleManager
                                                        .hasRole(Roles.SALES) &&
                                                    bloc.auditsAreDone())
                                                  OptionItem(
                                                    onTap: bloc.makeASale,
                                                    title: roleManager
                                                        .resolveTitle(
                                                      title: "SELL",
                                                      module: Roles.SALES,
                                                      capitalize: true,
                                                    ),
                                                    assetImage:
                                                        "assets/images/sell.png",
                                                    isDone: recordsManager
                                                        .hasTodaysRecord(
                                                      bloc.customer.id,
                                                    ),
                                                  ),
                                                if (roleManager.hasRole(
                                                        Roles.ORDERS) &&
                                                    bloc.auditsAreDone())
                                                  OptionItem(
                                                    onTap: bloc.makeAnOrder,
                                                    title: roleManager
                                                        .resolveTitle(
                                                      title: "ORDER",
                                                      module: Roles.ORDERS,
                                                      capitalize: true,
                                                    ),
                                                    assetImage:
                                                        "assets/images/order.png",
                                                    isDone: recordsManager
                                                            .hasTodaysRecord(
                                                                bloc.customer
                                                                    .id,
                                                                "Order")
                                                        ? true
                                                        : false,
                                                  ),
                                                if (roleManager.hasRole(
                                                        Roles.PAYMENTS) &&
                                                    bloc.auditsAreDone())
                                                  OptionItem(
                                                    onTap: bloc.onPayments,
                                                    title: roleManager
                                                        .resolveTitle(
                                                      title: "PAYMENTS",
                                                      module: Roles.PAYMENTS,
                                                      capitalize: true,
                                                    ),
                                                    assetImage:
                                                        "assets/images/pay.png",
                                                    isDone: paymentsManager
                                                        .hasTodaysRecord(
                                                      bloc.customer.id,
                                                    ),
                                                  ),
                                                if (!bloc.performedActivity())
                                                  OptionItem(
                                                    onTap: bloc.skipOutlet,
                                                    title: "SKIP",
                                                    assetImage:
                                                        "assets/images/skip.png",
                                                    isDone: recordsManager
                                                        .hasTodaysRecord(
                                                      bloc.customer.id,
                                                      "Skip",
                                                    ),
                                                  ),
                                                if (roleManager.hasRole(
                                                        Roles.FEEDBACK) &&
                                                    bloc.auditsAreDone())
                                                  OptionItem(
                                                    onTap: bloc.addFeedback,
                                                    title: roleManager
                                                        .resolveTitle(
                                                      title: "FEEDBACK",
                                                      module: Roles.FEEDBACK,
                                                      capitalize: true,
                                                    ),
                                                    assetImage:
                                                        "assets/images/feedback.png",
                                                    isDone: recordsManager
                                                        .hasTodaysRecord(
                                                      bloc.customer.id,
                                                      "Feedback",
                                                    ),
                                                  ),
                                                if (roleManager.hasRole(
                                                        Roles.AVAILABILITY) &&
                                                    bloc.auditsAreDone())
                                                  OptionItem(
                                                    onTap: bloc.onAuditOSA,
                                                    title: roleManager
                                                        .resolveTitle(
                                                      title: "ON SHELF AV.",
                                                      module:
                                                          Roles.AVAILABILITY,
                                                      capitalize: true,
                                                    ),
                                                    assetImage:
                                                        "assets/images/shelf.png",
                                                    isDone:
                                                        productAvailabilityManager
                                                            .hasTodaysRecord(
                                                      bloc.customer.id,
                                                    ),
                                                  ),
                                                if (roleManager.hasRole(
                                                    Roles.STOCK_TAKING))
                                                  OptionItem(
                                                    onTap: bloc.onStockTaking,
                                                    title: roleManager
                                                        .resolveTitle(
                                                      title: "STOCK TAKING",
                                                      module:
                                                          Roles.STOCK_TAKING,
                                                      capitalize: true,
                                                    ),
                                                    assetImage:
                                                        "assets/images/shelf.png",
                                                    isDone: stockTakesManager
                                                        .hasTodaysRecord(
                                                      bloc.customer.id,
                                                    ),
                                                  ),
                                                if (roleManager.hasRole(
                                                        Roles.DAMAGES) &&
                                                    bloc.auditsAreDone())
                                                  OptionItem(
                                                    onTap: bloc.onDamages,
                                                    title: roleManager
                                                        .resolveTitle(
                                                      title: "DAMAGES",
                                                      module: Roles.DAMAGES,
                                                      capitalize: true,
                                                    ),
                                                    assetImage:
                                                        "assets/images/damage.png",
                                                    isDone:
                                                        productUpdatesManager
                                                            .hasTodaysRecord(
                                                      bloc.customer.id,
                                                      "Damage",
                                                    ),
                                                  ),
                                                if (roleManager.hasRole(
                                                        Roles.EXPIRIES) &&
                                                    bloc.auditsAreDone())
                                                  OptionItem(
                                                    onTap: bloc.onExpiry,
                                                    title: roleManager
                                                        .resolveTitle(
                                                      title: "EXPIRY",
                                                      module: Roles.EXPIRIES,
                                                      capitalize: true,
                                                    ),
                                                    assetImage:
                                                        "assets/images/expiry.png",
                                                    isDone:
                                                        productUpdatesManager
                                                            .hasTodaysRecord(
                                                      bloc.customer.id,
                                                      "Expiry",
                                                    ),
                                                  ),
                                                if (roleManager.hasRole(
                                                        Roles.COMPETITOR) &&
                                                    bloc.auditsAreDone())
                                                  OptionItem(
                                                    onTap: bloc.onCompetition,
                                                    title: roleManager
                                                        .resolveTitle(
                                                      title: "COMPETITION",
                                                      module: Roles.COMPETITOR,
                                                      capitalize: true,
                                                    ),
                                                    assetImage:
                                                        "assets/images/competition.png",
                                                    isDone:
                                                        competitorActivitiesManager
                                                            .hasTodaysRecord(
                                                      bloc.customer.id,
                                                      "Competitor Activities",
                                                    ),
                                                  ),
                                                if (roleManager.hasRole(
                                                        Roles.SHELF_SHARE) &&
                                                    bloc.auditsAreDone())
                                                  OptionItem(
                                                    onTap: bloc.onShareOfShelf,
                                                    title: roleManager
                                                        .resolveTitle(
                                                      title: "SOS",
                                                      module: Roles.SHELF_SHARE,
                                                      capitalize: true,
                                                    ),
                                                    assetImage:
                                                        "assets/images/boxes.png",
                                                    isDone: sosManager
                                                        .hasTodaysRecord(
                                                      bloc.customer.id,
                                                    ),
                                                  ),
                                                if (roleManager
                                                    .hasRole(Roles.SURVEY))
                                                  OptionItem(
                                                    onTap: bloc.onSurvey,
                                                    title: roleManager
                                                        .resolveTitle(
                                                      title: "SURVEY",
                                                      module: Roles.SURVEY,
                                                      capitalize: true,
                                                    ),
                                                    assetImage:
                                                        "assets/images/qualitative_research.png",
                                                    isDone: false,
                                                  ),
                                                if (roleManager.hasRole(Roles
                                                        .SHARE_OF_DISPLAY) &&
                                                    bloc.auditsAreDone())
                                                  OptionItem(
                                                    onTap:
                                                        bloc.onShareOfDisplay,
                                                    title: roleManager
                                                        .resolveTitle(
                                                      title: "SOD",
                                                      module: Roles
                                                          .SHARE_OF_DISPLAY,
                                                      capitalize: true,
                                                    ),
                                                    assetImage:
                                                        "assets/images/shelf-display.png",
                                                    isDone: sodManager
                                                        .hasTodaysRecord(
                                                      bloc.customer.id,
                                                    ),
                                                  ),
                                                if (roleManager.hasRole(
                                                        Roles.IMAGES) &&
                                                    bloc.auditsAreDone())
                                                  OptionItem(
                                                    onTap: bloc.onPhoto,
                                                    title: roleManager
                                                        .resolveTitle(
                                                      title: "PHOTO",
                                                      module: Roles.IMAGES,
                                                      capitalize: true,
                                                    ),
                                                    assetImage:
                                                        "assets/images/camera.png",
                                                    isDone: generalPhotosManager
                                                        .hasTodaysRecord(
                                                      bloc.customer.id,
                                                    ),
                                                  )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          if (routePlansManager.routeType(
                                                      bloc.routePlan.id) ==
                                                  "ON" ||
                                              roleManager.hasRole(
                                                  Roles.ALLOW_OFF_ROUTE))
                                            MaterialButton(
                                              onPressed: bloc.checkIn,
                                              color: Colors.green,
                                              child: Text(
                                                "CHECK IN",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          if (roleManager.hasRole(Roles.ORDERS))
                                            Container(
                                              margin:
                                                  EdgeInsets.only(left: 10.0),
                                              child: MaterialButton(
                                                onPressed: bloc.makeAnOrder,
                                                color: Colors.white,
                                                child: Text(
                                                  "PLACE ORDER",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      );
                              },
                            )),
                        if (routePlansManager.routeType(bloc.routePlan.id) ==
                                "OFF" &&
                            !sessionManager.inSession)
                          FlatButton(
                            onPressed: null,
                            textColor: Colors.red[200],
                            child: Text("CUSTOMER IS OFF ROUTE"),
                          ),
                        Footer(),
                      ],
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}

class OptionItem extends StatelessWidget {
  String assetImage;
  String title;
  bool isDone;
  Function onTap;
  OptionItem({
    this.assetImage,
    this.onTap,
    this.isDone = false,
    this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width / 2) - 4,
      margin: EdgeInsets.all(2.0),
      child: MaterialButton(
        padding: EdgeInsets.all(10.0),
        color: Colors.white,
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset(
              "$assetImage",
              height: 30.0,
            ),
            Text(
              "$title",
            ),
            if (isDone)
              Container(
                padding: EdgeInsets.all(1.0),
                child: Icon(
                  Icons.check,
                  size: 13.0,
                  color: Colors.white,
                ),
                decoration:
                    BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              )
          ],
        ),
      ),
    );
  }
}
