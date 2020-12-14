import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/inventory_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/helpers/stockpoints_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/ui/widgets/inventory_view.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class InventoryScreen extends StatelessWidget {
  final bloc = InventoryBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("${roleManager.resolveTitle(
              title: "Inventory",
              module: Roles.INVENTORY,
            )}"),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  child: Text("AVAILABLE"),
                ),
                Tab(
                  child: Text("RECEIVED"),
                ),
              ],
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
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: TabBarView(
                    children: [
                      Container(
                        color: Colors.grey[200],
                        width: double.infinity,
                        height: double.infinity,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: StreamBuilder(
                                  stream: inventoryManager.stream,
                                  builder: (context, snapshot) {
                                    return SingleChildScrollView(
                                      child: Column(
                                        children: inventoryManager
                                            .groupedVirtualStock.keys
                                            .map((String category) {
                                          var index = inventoryManager
                                              .groupedVirtualStock.keys
                                              .toList()
                                              .indexOf(category);
                                          return InventoryView(
                                            color: (index + 1) % 2 == 0
                                                ? Colors.grey[200]
                                                : Colors.white,
                                            productCategory: category,
                                            productCount: bloc.quantitySum(
                                                inventoryManager
                                                        .groupedVirtualStock[
                                                    category]),
                                            child: Column(
                                              children: inventoryManager
                                                  .groupedVirtualStock[category]
                                                  .map<Widget>(
                                                (product) {
                                                  var index = inventoryManager
                                                      .groupedVirtualStock[
                                                          category]
                                                      ?.indexOf(product);
                                                  return Container(
                                                    color: (index + 1) % 2 == 0
                                                        ? Colors.grey[200]
                                                        : Colors.white,
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Text(
                                                                "${product.productDesc}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      11.0,
                                                                ),
                                                              ),
                                                              if (product.batchnumber !=
                                                                      "" &&
                                                                  product.batchnumber !=
                                                                      null)
                                                                RichText(
                                                                  text: TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              "Batch:",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                11.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                            text:
                                                                                " "),
                                                                        TextSpan(
                                                                          text:
                                                                              "${product.batchnumber}",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                11.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color:
                                                                                Colors.black54,
                                                                          ),
                                                                        ),
                                                                      ]),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 80.0,
                                                          child: Text(
                                                            "${product.quantity} pcs",
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: TextStyle(
                                                              fontSize: 11.0,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ).toList(),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: StreamBuilder(
                          stream: inventoryManager.stream,
                          builder: (context, snapshot) {
                            return CircularMaterialSpinner(
                              loading: inventoryManager.loadingStock,
                              child: ListView.builder(
                                  itemCount: inventoryManager.stocks.length,
                                  itemBuilder: (context, index) {
                                    print(
                                        "The length is: ${inventoryManager.stocks.length}");
                                    var stock = inventoryManager.stocks[index];
                                    var stockItems = inventoryManager
                                        .stockItemsFor(stock.id);
                                    return Container(
                                      child: CustomExpansionTile(
                                        title: Container(
                                          padding: EdgeInsets.all(3.0).copyWith(
                                            bottom: 5.0,
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                child: (stock.photo != null)
                                                    ? (stock.fromServer)
                                                        ? CachedNetworkImage(
                                                            fit: BoxFit.cover,
                                                            imageUrl:
                                                                "${settingsManager.updateProfile.imagestorage}inventory/${stock.photo}",
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
                                                                "${stock.photo}"),
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
                                                    height: 70.0,
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
                                                                "${stockPointsManager.stockpointFromId(stock.supplierId)?.shopName}",
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
                                                            Text(
                                                              "${stock.entryType}",
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 14.0,
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons.done_all,
                                                              color: (stock
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
                                                            Text(
                                                              "${authManager.user.country?.currencyCode} ${inventoryManager.stockItemsTotalFor(stock.id)}",
                                                              style: TextStyle(
                                                                fontSize: 15.0,
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5.0),
                                                              child: Text(
                                                                "${formatDate(stock.entryTime, "jm")}",
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
                                                                  .end,
                                                          children: <Widget>[
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5.0),
                                                              child: Text(
                                                                "${formatDate(stock.entryTime)}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12.0,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .accentColor),
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
                                        ),
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                              top: 10.0,
                                              bottom: 10.0,
                                            ),
                                            color: Colors.white,
                                            child: Column(children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: 5.0,
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 4,
                                                      child: Text(
                                                        "PRODUCT",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "QTY",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "COST",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ...stockItems.map((stockItem) {
                                                /*var index = stockItems
                                                      .indexOf(stockItem);*/
                                                return Container(
                                                  /*color: (index % 2 == 0)
                                                        ? Colors.white
                                                        : Colors.grey[200],*/
                                                  padding: EdgeInsets.only(
                                                    left: 5.0,
                                                    top: 5.0,
                                                  ),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        flex: 4,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            right: 10.0,
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Text(
                                                                "${stockItem.productDesc}",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize:
                                                                      12.0,
                                                                ),
                                                              ),
                                                              if (stockItem
                                                                          .batchnumber !=
                                                                      null &&
                                                                  stockItem
                                                                          .batchnumber !=
                                                                      "")
                                                                RichText(
                                                                  text: TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              "Batch:",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                11.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                            text:
                                                                                " "),
                                                                        TextSpan(
                                                                          text:
                                                                              "${stockItem.batchnumber}",
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                11.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color:
                                                                                Colors.black54,
                                                                          ),
                                                                        ),
                                                                      ]),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          "${(stockItem.unit == "ctns") ? stockItem.quantity * stockItem.crtQnty : stockItem.quantity} pcs",
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          "${stockItem.price * stockItem.quantity}",
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }).toList()
                                            ]),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Footer(),
              ],
            ),
          ),
          floatingActionButton: (!roleManager.hasRole(Roles.DISABLE_INVENTORY))
              ? FloatingActionButton(
                  onPressed: (dayManager.closedDay)
                      ? bloc.showClosedDayDialog
                      : bloc.addStock,
                  child: Icon(
                    Icons.add,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
