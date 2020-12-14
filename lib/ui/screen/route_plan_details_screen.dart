import 'dart:io';

import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/route_plan_details_bloc.dart';
import 'package:solutech_sat/data/models/route_plan.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/contact_buttons.dart';
import 'package:solutech_sat/ui/widgets/customers_map.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RoutePlanDetailsScreen extends StatelessWidget {
  final bloc = RoutePlanDetailsBloc();

  RoutePlanDetailsScreen(RoutePlan routePlan) {
    bloc.routePlan = routePlan;
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: DefaultTabController(
        length: 2,
        child: StreamBuilder(
            stream: bloc.stream,
            builder: (context, snapshot) {
              return Scaffold(
                appBar: AppBar(
                  title: Text("${bloc.routePlan.name}"),
                  bottom: TabBar(
                    controller: bloc.tabController,
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(
                        child: Text("CUSTOMERS"),
                      ),
                      Tab(
                        child: Text("MAP"),
                      ),
                    ],
                  ),
                ),
                body: Container(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: TabBarView(
                          controller: bloc.tabController,
                          physics: bloc.tabController.index == 1
                              ? NeverScrollableScrollPhysics()
                              : ScrollPhysics(
                                  parent: FixedExtentScrollPhysics()),
                          children: [
                            Container(
                              color: Colors.grey[200],
                              width: double.infinity,
                              height: double.infinity,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: bloc.customers.length,
                                        itemBuilder: (context, index) {
                                          var customer = bloc.customers[index];
                                          return GestureDetector(
                                            onTap: () => (sessionManager
                                                        .inSession &&
                                                    sessionManager.session
                                                            .customerId !=
                                                        customer.id)
                                                ? bloc.alertInSession(
                                                    sessionManager
                                                        .session.customerId,
                                                  )
                                                : bloc.viewCustomer(customer),
                                            child: Container(
                                              padding: EdgeInsets.all(10.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    height: 60.0,
                                                    width: 60.0,
                                                    color: Colors.grey[200],
                                                    margin: EdgeInsets.only(
                                                      right: 5.0,
                                                    ),
                                                    child: (customer.photo !=
                                                            null)
                                                        ? (customer.fromServer &&
                                                                !customer.photo
                                                                    .contains(
                                                                        "com.solutech.sat"))
                                                            ? CachedNetworkImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                imageUrl:
                                                                    "${settingsManager.updateProfile.imagestorage}customers/${customer.photo}",
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
                                                                        70.0,
                                                                    width: 70.0,
                                                                  );
                                                                },
                                                                height: 70.0,
                                                                width: 70.0,
                                                              )
                                                            : Image.file(
                                                                File(
                                                                    "${customer.photo}"),
                                                                height: 70.0,
                                                                width: 70.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                              )
                                                        : Image.asset(
                                                            "assets/images/noimage.jpg",
                                                            height: 70.0,
                                                            width: 70.0,
                                                          ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Text(
                                                              "${customer.shopName.toUpperCase()}",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                            Text(
                                                                "${bloc.customerType(customer.shopCatId)}")
                                                          ],
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  if (customer
                                                                          .verified ==
                                                                      "Valid")
                                                                    Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Icon(
                                                                          Icons
                                                                              .verified_user,
                                                                          size:
                                                                              15.0,
                                                                          color:
                                                                              Colors.green,
                                                                        ),
                                                                        Text(
                                                                          "${customer.verified}",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.green,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  if (roleManager
                                                                      .hasRole(Roles
                                                                          .GEOFENCE))
                                                                    ((double.parse("${customer.slatitude ?? 0}") !=
                                                                            0)
                                                                        ? FutureBuilder(
                                                                            future:
                                                                                locationManager.calculateDistance(
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
                                                                            })
                                                                        : Text(
                                                                            "No location",
                                                                          ))
                                                                ],
                                                              ),
                                                            ),
                                                            ContactButtons(
                                                              phoneNumber: customer
                                                                  .shopPhoneno,
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.grey[200],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            CustomersMap(
                              markers: bloc.getMapMarkers(),
                            ),
                          ],
                        ),
                      ),
                      Footer(),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
