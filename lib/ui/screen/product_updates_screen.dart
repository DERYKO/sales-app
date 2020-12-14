import 'dart:io';

import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/product_updates_bloc.dart';
import 'package:solutech_sat/bloc/records_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/product_updates_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/ui/widgets/product_updates_card.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class ProductUpdatesScreen extends StatelessWidget {
  final bloc = ProductUpdatesBloc();
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
                title: Text("Product updates"),
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
                      child: Text("DAMAGES"),
                    ),
                    Tab(
                      child: Text("EXPIRIES"),
                    ),
                  ],
                ),
              ),
              body: StreamBuilder(
                stream: productUpdatesManager.stream,
                builder: (context, snapshot) {
                  return Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: TabBarView(
                            children: [
                              CircularMaterialSpinner(
                                loading:
                                    productUpdatesManager.loadingProductUpdates,
                                child: ListView.builder(
                                  itemCount: productUpdatesManager
                                      .productUpdates
                                      .where((productUpdate) =>
                                          productUpdate.updateType == "Damage")
                                      .toList()
                                      .length,
                                  itemBuilder: (context, index) {
                                    var productUpdate = productUpdatesManager
                                        .productUpdates
                                        .where((productUpdate) =>
                                            productUpdate.updateType ==
                                            "Damage")
                                        .toList()[index];
                                    return ProductUpdateCard(
                                      type: "Damage",
                                      productUpdate: productUpdate,
                                    );
                                  },
                                ),
                              ),
                              CircularMaterialSpinner(
                                loading:
                                    productUpdatesManager.loadingProductUpdates,
                                child: ListView.builder(
                                  itemCount: productUpdatesManager
                                      .productUpdates
                                      .where((productUpdate) =>
                                          productUpdate.updateType == "Expiry")
                                      .toList()
                                      .length,
                                  itemBuilder: (context, index) {
                                    var productUpdate = productUpdatesManager
                                        .productUpdates
                                        .where((productUpdate) =>
                                            productUpdate.updateType ==
                                            "Expiry")
                                        .toList()[index];
                                    return ProductUpdateCard(
                                      type: "Expiry",
                                      productUpdate: productUpdate,
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
