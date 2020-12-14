import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/brand_availability_bloc.dart';
import 'package:solutech_sat/bloc/competitor_activities_bloc.dart';
import 'package:solutech_sat/bloc/inventory_bloc.dart';
import 'package:solutech_sat/bloc/posm_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/availability.dart';
import 'package:solutech_sat/data/models/availability_item.dart';
import 'package:solutech_sat/data/models/competitor_activity.dart';
import 'package:solutech_sat/data/models/posm.dart';
import 'package:solutech_sat/data/models/product_availability.dart';
import 'package:solutech_sat/data/models/product_availability_detail.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/competitor_activities_manager.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/availability_manager.dart';
import 'package:solutech_sat/helpers/product_availability_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/helpers/stockpoints_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/competition_card.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/ui/widgets/inventory_view.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class CompetitorActivitiesScreen extends StatelessWidget {
  final bloc = CompetitorActivitiesBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("${roleManager.resolveTitle(
            title: "Competitor activities",
            module: Roles.COMPETITOR,
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
                            stream: competitorActivitiesManager.stream,
                            builder: (context, snapshot) {
                              return CircularMaterialSpinner(
                                loading: competitorActivitiesManager
                                    .loadingCompetitorActivities,
                                child: ListView.builder(
                                    itemCount: competitorActivitiesManager
                                        .competitorActivities.length,
                                    itemBuilder: (context, index) {
                                      CompetitorActivity competitorActivity =
                                          competitorActivitiesManager
                                              .competitorActivities[index];

                                      return CompetitionCard(
                                        competitorActivity: competitorActivity,
                                      );
                                    }),
                              );
                            }),
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
