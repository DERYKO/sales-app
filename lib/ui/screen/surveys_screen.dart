import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/surveys_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/survey_answer.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/helpers/surveys_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class SurveysScreen extends StatelessWidget {
  SurveysBloc bloc;
  SurveysScreen({Customer customer}) : bloc = SurveysBloc(customer: customer);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                title: Text("${roleManager.resolveTitle(
                  title: "Survey",
                  module: Roles.SURVEY,
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
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: StreamBuilder(
                            stream: surveysManager.stream,
                            builder: (context, snapshot) {
                              return CircularMaterialSpinner(
                                loading: surveysManager.loadingSurveyAnswers,
                                child: ListView(
                                  children: surveysManager.groupedSurveyAnswers
                                      .toList()
                                      .map<Widget>((groupedSurveyAnswer) {
                                    return CustomExpansionTile(
                                      title: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    "${groupedSurveyAnswer.surveyTitle}",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 10.0,
                                                  ),
                                                  child: Icon(
                                                    Icons.done_all,
                                                    color: (groupedSurveyAnswer
                                                            .synced)
                                                        ? Colors.green
                                                        : Colors.grey,
                                                    size: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Text(
                                                  "${formatDate(groupedSurveyAnswer.entryTime?.toString(), "dt")}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12.0,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      children: groupedSurveyAnswer.items
                                          .map((surveyAnswer) {
                                        var index = groupedSurveyAnswer.items
                                            .indexOf(surveyAnswer);
                                        return Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "${surveyAnswer.question}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                              (surveyAnswer.questionType ==
                                                      "Photo")
                                                  ? (surveyAnswer.fromServer)
                                                      ? CachedNetworkImage(
                                                          fit: BoxFit.cover,
                                                          imageUrl:
                                                              "${settingsManager.updateProfile.imagestorage}surveyphotos/${surveyAnswer.answer}",
                                                          errorWidget: (context,
                                                              url, error) {
                                                            return Image.asset(
                                                              "assets/images/noimage.jpg",
                                                              fit: BoxFit.cover,
                                                              height: 250.0,
                                                              width: double
                                                                  .infinity,
                                                            );
                                                          },
                                                          height: 250.0,
                                                          width:
                                                              double.infinity,
                                                        )
                                                      : Image.file(
                                                          File(
                                                            "${surveyAnswer.answer}",
                                                          ),
                                                          height: 250.0,
                                                          width:
                                                              double.infinity,
                                                          fit: BoxFit.cover,
                                                        )
                                                  : Text(
                                                      "${surveyAnswer.answer}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            color: (index + 1) % 2 == 0
                                                ? Colors.white
                                                : Colors.grey[100],
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey[200],
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  }).toList(),
                                ),
                              );
                            })),
                    Footer(),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: bloc.fillSurvey,
                child: Icon(Icons.add),
              ),
            );
          }),
    );
  }
}
