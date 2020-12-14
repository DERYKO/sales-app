import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/customers_bloc.dart';
import 'package:solutech_sat/data/models/route_plan.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/contact_buttons.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/ui/widgets/search_app_bar.dart';

class CustomersScreen extends StatelessWidget {
  final bloc = CustomersBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          return StreamBuilder(
              stream: routePlansManager.stream,
              builder: (context, snapshot) {
                return Scaffold(
                  appBar: SearchAppBar(
                    searchTextController: bloc.searchTextController,
                    onExitSearch: bloc.exitSearch,
                    search: bloc.search,
                    onSearch: bloc.onSearch,
                    mainAppBar: AppBar(
                      title: Text("Customers"),
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
                          onPressed: bloc.searchCustomers,
                          icon: Icon(
                            Icons.search,
                          ),
                        ),
                        PopupMenu(
                          onToggleVisitedCustomers: bloc.toggleVisitedCustomers,
                          viewVisitedCustomers: bloc.viewVisitedCustomers,
                        ),
                      ],
                      bottom: PreferredSize(
                        child: Container(
                          height: 40.0,
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            left: 72.0,
                            bottom: 10.0,
                            right: 17.0,
                          ),
                          padding: EdgeInsets.only(left: 5.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<RoutePlan>(
                              hint: Text(
                                "${bloc.routePlan != null ? bloc.routePlan.name : "- Select route plan -"}",
                                style: TextStyle(
                                    color: bloc.routePlan != null
                                        ? Colors.white
                                        : Colors.grey[300]),
                              ),
                              iconEnabledColor: Colors.white,
                              icon: Container(),
                              items: routePlansManager.routePlans
                                  .map<DropdownMenuItem<RoutePlan>>(
                                      (routePlan) {
                                return DropdownMenuItem(
                                  child: Text("${routePlan.name}"),
                                  value: routePlan,
                                );
                              }).toList(),
                              onChanged: bloc.onRoutePlanChanged,
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white.withAlpha(30),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0))),
                        ),
                        preferredSize: Size(double.infinity, 50),
                      ),
                    ),
                  ),
                  body: StreamBuilder(
                    stream: bloc.stream,
                    builder: (context, snapshot) {
                      return Container(
                        color: Colors.white,
                        width: double.infinity,
                        height: double.infinity,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: StreamBuilder(
                                stream: locationManager.stream,
                                builder: (context, snapshot) {
                                  return CircularMaterialSpinner(
                                    loading:
                                        routePlansManager.loadingRoutePlans,
                                    child: (bloc.routePlan != null)
                                        ? FutureBuilder(
                                            future:
                                                routePlansManager.getCustomers(
                                              bloc.routePlan.id,
                                              hideVisited:
                                                  !bloc.viewVisitedCustomers,
                                            ),
                                            initialData: [],
                                            builder: (context,
                                                AsyncSnapshot<List> snapshot) {
                                              return ListView.builder(
                                                  itemCount: snapshot.data
                                                      .where((customer) =>
                                                          customer.shopName
                                                              .toLowerCase()
                                                              .contains(bloc
                                                                  .searchTerm
                                                                  .toLowerCase()))
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var customers = snapshot
                                                        .data
                                                        .where((customer) =>
                                                            customer.shopName
                                                                .toLowerCase()
                                                                .contains(bloc
                                                                    .searchTerm
                                                                    .toLowerCase()))
                                                        .toList();
                                                    var customer =
                                                        customers[index];
                                                    return GestureDetector(
                                                      onTap: () => (sessionManager
                                                                  .inSession &&
                                                              sessionManager
                                                                      .session
                                                                      .customerId !=
                                                                  customer.id)
                                                          ? bloc.alertInSession(
                                                              sessionManager
                                                                  .session
                                                                  .customerId)
                                                          : bloc.viewCustomer(
                                                              customer),
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Container(
                                                              height: 60.0,
                                                              width: 60.0,
                                                              color: Colors
                                                                  .grey[200],
                                                              margin: EdgeInsets
                                                                  .only(
                                                                right: 5.0,
                                                              ),
                                                              child: (customer
                                                                          .photo !=
                                                                      null)
                                                                  ? (customer.fromServer &&
                                                                          !customer.photo.contains(
                                                                              "com.solutech.sat"))
                                                                      ? CachedNetworkImage(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          imageUrl:
                                                                              "${settingsManager.updateProfile.imagestorage}customers/${customer.photo}",
                                                                          errorWidget: (context,
                                                                              url,
                                                                              error) {
                                                                            return Image.asset(
                                                                              "assets/images/noimage.jpg",
                                                                              fit: BoxFit.cover,
                                                                              height: 70.0,
                                                                              width: 70.0,
                                                                            );
                                                                          },
                                                                          height:
                                                                              70.0,
                                                                          width:
                                                                              70.0,
                                                                        )
                                                                      : Image
                                                                          .file(
                                                                          File(
                                                                              "${customer.photo}"),
                                                                          height:
                                                                              70.0,
                                                                          width:
                                                                              70.0,
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        )
                                                                  : Image.asset(
                                                                      "assets/images/noimage.jpg",
                                                                      height:
                                                                          70.0,
                                                                      width:
                                                                          70.0,
                                                                    ),
                                                            ),
                                                            Expanded(
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        "${customer.shopName.toUpperCase()}",
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                          "${bloc.customerType(customer.shopCatId)}")
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Expanded(
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: <
                                                                              Widget>[
                                                                            if (customer.verified ==
                                                                                "Valid")
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
                                                                            if (roleManager.hasRole(Roles.GEOFENCE))
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
                                                                                      })
                                                                                  : Text(
                                                                                      "No location",
                                                                                    ))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      ContactButtons(
                                                                        phoneNumber:
                                                                            customer.shopPhoneno,
                                                                        onEditTap:
                                                                            () =>
                                                                                bloc.editCustomer(customer),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: Colors
                                                                  .grey[200],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            })
                                        : Container(),
                                  );
                                },
                              ),
                            ),
                            Footer(),
                          ],
                        ),
                      );
                    },
                  ),
                  floatingActionButton: (bloc.routePlan != null &&
                          !roleManager.hasRole(Roles.DISABLE_ADDING_CUSTOMERS))
                      ? FloatingActionButton(
                          onPressed: bloc.addCustomer,
                          child: Icon(
                            Icons.add,
                          ),
                        )
                      : null,
                );
              });
        },
      ),
    );
  }
}

enum MenuOptions { viewVisitedCustomers }

class PopupMenu extends StatelessWidget {
  Function onToggleVisitedCustomers;
  bool viewVisitedCustomers = false;

  PopupMenu(
      {@required this.onToggleVisitedCustomers, this.viewVisitedCustomers});

  @override
  Widget build(BuildContext context) {
    return (!viewVisitedCustomers)
        ? PopupMenuButton<MenuOptions>(
            onSelected: (MenuOptions result) {
              onToggleVisitedCustomers();
            },
            tooltip: "Menu",
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<MenuOptions>>[
                  const PopupMenuItem<MenuOptions>(
                    value: MenuOptions.viewVisitedCustomers,
                    child: const Text("View visited customers"),
                  ),
                ])
        : PopupMenuButton<MenuOptions>(
            onSelected: (MenuOptions result) {
              onToggleVisitedCustomers();
            },
            tooltip: "Menu",
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<MenuOptions>>[
                  const PopupMenuItem<MenuOptions>(
                    value: MenuOptions.viewVisitedCustomers,
                    child: const Text("Hide visited customers"),
                  ),
                ]);
  }
}
