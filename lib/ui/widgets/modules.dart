import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/modules_bloc.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/module_item.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class Modules extends StatelessWidget {
  ModulesBloc bloc = ModulesBloc();
  @override
  Widget build(BuildContext context) {
    // You have to set the context if it is not a screen
    bloc.context = context;
    return BlocProvider(
      bloc: bloc,
      child: Container(
        child: StreamBuilder(
          stream: roleManager.stream,
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Wrap(
                children: <Widget>[
                  if (!roleManager.hasRole(Roles.CHECK_IN) &&
                      sessionManager.inSession)
                    Container(
                      child: Card(
                        child: StreamBuilder(
                            stream: sessionManager.stream,
                            builder: (context, snapshot) {
                              return GestureDetector(
                                onTap: bloc.onNavigateToCustomer,
                                child: Container(
                                  height: 80.0,
                                  width: double.infinity,
                                  padding: EdgeInsets.all(6.0),
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(
                                        "CHECKIN: ${formatDate(sessionManager.session?.startTime, "jms")}",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "${sessionManager.timeIn}",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color:
                                                Theme.of(context).accentColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${routePlansManager.getCustomerById(sessionManager.session?.customerId)?.shopName}",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  if (roleManager.hasRole(Roles.CHECK_IN))
                    ModuleItem(
                      onTap: bloc.onCheckins,
                      assetImage: "assets/images/location.png",
                      title: roleManager.resolveTitle(
                        title: "Checkin/Checkout",
                        module: Roles.CHECK_IN,
                      ),
                    ),
                  if (roleManager.hasRole(Roles.SALES) ||
                      roleManager.hasRole(Roles.ORDERS))
                    ModuleItem(
                      onTap: bloc.onSalesAndOrders,
                      assetImage: "assets/images/shopping-cart.png",
                      title:
                          "${(roleManager.hasRole(Roles.ORDERS) && roleManager.hasRole(Roles.SALES)) ? "Orders/Sales" : roleManager.hasRole(Roles.ORDERS) ? "Orders" : "Sales"}",
                    ),
                  ModuleItem(
                    onTap: bloc.onCustomers,
                    assetImage: "assets/images/customers.png",
                    title: "Customers",
                  ),
                  if (roleManager.hasRole(Roles.INVENTORY))
                    ModuleItem(
                      onTap: bloc.openInventory,
                      assetImage: "assets/images/inventory.png",
                      title: roleManager.resolveTitle(
                        title: "Inventory",
                        module: Roles.INVENTORY,
                      ),
                    ),
                  if (roleManager.hasRole(Roles.AVAILABILITY))
                    ModuleItem(
                      onTap: bloc.onShelfAvailability,
                      assetImage: "assets/images/shelf.png",
                      title: roleManager.resolveTitle(
                        title: "On Shelf Availability",
                        module: Roles.AVAILABILITY,
                      ),
                    ),
                  if (roleManager.hasRole(Roles.SHELF_SHARE))
                    ModuleItem(
                      onTap: bloc.onShareOfShelf,
                      assetImage: "assets/images/boxes.png",
                      title: roleManager.resolveTitle(
                        title: "Share of Shelf",
                        module: Roles.SHELF_SHARE,
                      ),
                    ),
                  // ignore: sdk_version_ui_as_code
                  if (roleManager.hasRole(Roles.SHARE_OF_DISPLAY))
                    ModuleItem(
                      onTap: bloc.onShareOfDisplay,
                      assetImage: "assets/images/shelf-display.png",
                      title: roleManager.resolveTitle(
                        title: "Share of Display",
                        module: Roles.SHARE_OF_DISPLAY,
                      ),
                    ),
                  if (roleManager.hasRole(Roles.EXPIRIES) ||
                      roleManager.hasRole(Roles.DELIVERY))
                    ModuleItem(
                      onTap: bloc.onProductUpdates,
                      assetImage: "assets/images/expiry.png",
                      title: "Product updates",
                    ),
                  if (roleManager.hasRole(Roles.IMAGES))
                    ModuleItem(
                      onTap: bloc.onPhotos,
                      assetImage: "assets/images/camera.png",
                      title: roleManager.resolveTitle(
                        title: "Photos",
                        module: Roles.IMAGES,
                      ),
                    ),
                  if (roleManager.hasRole(Roles.COMPETITOR))
                    ModuleItem(
                      onTap: bloc.onCompetitorActivities,
                      assetImage: "assets/images/competition.png",
                      title: roleManager.resolveTitle(
                        title: "Competitor activities",
                        module: Roles.COMPETITOR,
                      ),
                    ),
                  if (roleManager.hasRole(Roles.CRATES))
                    ModuleItem(
                      onTap: bloc.onComingSoon,
                      assetImage: "assets/images/crate.png",
                      title: roleManager.resolveTitle(
                        title: "Crates collection",
                        module: Roles.CRATES,
                      ),
                    ),
                  if (roleManager.hasRole(Roles.PAYMENTS))
                    ModuleItem(
                      onTap: bloc.onPaymentCollection,
                      assetImage: "assets/images/cash-collection.png",
                      title: roleManager.resolveTitle(
                        title: "Payment Collection",
                        module: Roles.PAYMENTS,
                      ),
                    ),
                  if (roleManager.hasRole(Roles.DELIVERY))
                    ModuleItem(
                      onTap: bloc.onDeliveries,
                      assetImage: "assets/images/delivery-truck.png",
                      title: roleManager.resolveTitle(
                        title: "Deliveries",
                        module: Roles.DELIVERY,
                      ),
                    ),
                  if (roleManager.hasRole(Roles.SALES) ||
                      roleManager.hasRole(Roles.ORDERS))
                    ModuleItem(
                      onTap: bloc.onSalesReport,
                      assetImage: "assets/images/bar-chart.png",
                      title: "Sales report",
                    ),
                  if (roleManager.hasRole(Roles.SALES) ||
                      roleManager.hasRole(Roles.ORDERS))
                    ModuleItem(
                      onTap: bloc.onPerformance,
                      assetImage: "assets/images/bar-chart.png",
                      title: "Performance",
                    ),
                  ModuleItem(
                    onTap: bloc.onRoutePlan,
                    assetImage: "assets/images/destination.png",
                    title: "Route plan",
                  ),
                  if (roleManager.hasRole(Roles.STATUS_UPDATE))
                    ModuleItem(
                      onTap: bloc.onStatusUpdate,
                      assetImage: "assets/images/conversation.png",
                      title: roleManager.resolveTitle(
                        title: "Status updates",
                        module: Roles.STATUS_UPDATE,
                      ),
                    ),
                  if (roleManager.hasRole(Roles.FEEDBACK))
                    ModuleItem(
                      onTap: bloc.onFeedbacks,
                      assetImage: "assets/images/feedback.png",
                      title: roleManager.resolveTitle(
                        title: "Feedback",
                        module: Roles.FEEDBACK,
                      ),
                    ),
                  if (roleManager.hasRole(Roles.SURVEY))
                    ModuleItem(
                      onTap: bloc.onSurveys,
                      assetImage: "assets/images/qualitative_research.png",
                      title: roleManager.resolveTitle(
                        title: "Survey",
                        module: Roles.SURVEY,
                      ),
                    ),
                  //if (roleManager.hasRole(Roles.BANKING))
                  ModuleItem(
                    onTap: bloc.onBanking,
                    assetImage: "assets/images/banking.png",
                    title: "Banking",
                  ),
                  if (roleManager.hasRole(Roles.STOCK_TAKING))
                    ModuleItem(
                      onTap: bloc.listStockTakes,
                      assetImage: "assets/images/order.png",
                      title: roleManager.resolveTitle(
                        title: "Stock Takes",
                        module: Roles.STOCK_TAKING,
                      ),
                    ),
                  if (roleManager.hasRole(Roles.POSM_AUDIT))
                    ModuleItem(
                      onTap: bloc.listPosm,
                      assetImage: "assets/images/pos.png",
                      title: roleManager.resolveTitle(
                        title: "POSM",
                        module: Roles.POSM_AUDIT,
                      ),
                    ),
                  if (roleManager.hasRole(Roles.BRAND_AVAILABILITY))
                    ModuleItem(
                      onTap: bloc.listAvailability,
                      assetImage: "assets/images/order.png",
                      title: roleManager.resolveTitle(
                        title: "Brand Availability",
                        module: Roles.BRAND_AVAILABILITY,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
