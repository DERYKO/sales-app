import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solutech_sat/bloc/deliveries_bloc.dart';
import 'package:solutech_sat/bloc/posm_bloc.dart';
import 'package:solutech_sat/bloc/survey_bloc.dart';
import 'package:solutech_sat/bloc/surveys_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/delivery.dart';
import 'package:solutech_sat/data/models/posm.dart';
import 'package:solutech_sat/data/models/scheduled_delivery.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/deliveries_manager.dart';
import 'package:solutech_sat/helpers/posm_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/surveys_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class SurveyScreen extends StatelessWidget {
  SurveyBloc bloc;
  SurveyScreen({Customer customer}) : bloc = SurveyBloc(customer: customer);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return WillPopScope(
              onWillPop: bloc.onWillPop,
              child: Scaffold(
                appBar: AppBar(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FittedBox(
                        child: Text("${roleManager.resolveTitle(
                          title: "SURVEY",
                          module: Roles.SURVEY,
                          capitalize: true,
                        )}"),
                      ),
                      if (bloc.customer != null)
                        Text(
                          "${bloc.customer?.shopName?.toUpperCase()}",
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                    ],
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: bloc.loadData,
                    )
                  ],
                  bottom: (bloc.customer != null)
                      ? PreferredSize(
                          child: Container(
                            height: 40.0,
                            width: double.infinity,
                            margin: EdgeInsets.only(
                                left: 72.0, bottom: 10.0, right: 17.0),
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "${bloc.customer.shopName}",
                              style: TextStyle(
                                  fontSize: 17.0, color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white.withAlpha(30),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.0))),
                          ),
                          preferredSize: Size(double.infinity, 50),
                        )
                      : null,
                ),
                body: StreamBuilder(
                  stream: surveysManager.stream,
                  builder: (context, snapshot) {
                    return Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: (bloc.survey == null)
                                ? CircularMaterialSpinner(
                                    loading: surveysManager.loadingSurveys,
                                    child: Container(
                                      color: Colors.grey[100],
                                      padding: const EdgeInsets.all(10.0),
                                      child: ListView(
                                        children: surveysManager
                                            .surveyProperties
                                            .map((surveyProperty) {
                                          return MaterialButton(
                                            color: Colors.white,
                                            onPressed: () => bloc
                                                .onSelectSurvey(surveyProperty),
                                            child: Text(
                                                "${surveyProperty?.surveyTitle?.toUpperCase()}"),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  )
                                : ListView(
                                    children: <Widget>[
                                      Container(
                                        color: Colors.grey[100],
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "${bloc.survey.surveyTitle ?? ""}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Text(
                                                "${bloc.survey.introMessage ?? ""}",
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ...surveysManager
                                          .getSurveyQuestionsById(
                                              bloc.survey.id)
                                          .map((question) {
                                        var index = surveysManager
                                            .getSurveyQuestionsById(
                                                bloc.survey.id)
                                            .indexOf(question);
                                        return Container(
                                          padding: EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0)
                                                        .copyWith(left: 0.0),
                                                child: RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                      text:
                                                          "${index + 1}. ${question.questionTitle}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    TextSpan(text: " "),
                                                    TextSpan(
                                                      text:
                                                          "${question.required == "true" ? "*" : ""}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                              if (question.questionType ==
                                                  "String")
                                                TextFormField(
                                                  controller: bloc
                                                      .questionHelpers[index],
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    hintText:
                                                        question.description,
                                                  ),
                                                ),
                                              if (question.questionType ==
                                                  "Number")
                                                TextFormField(
                                                  controller: bloc
                                                      .questionHelpers[index],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    hintText:
                                                        question.description,
                                                  ),
                                                ),
                                              if (question.questionType ==
                                                  "Checkboxes")
                                                Wrap(
                                                  children:
                                                      (question.choices ?? "")
                                                          .split(",")
                                                          .map((choice) {
                                                    return CheckboxListTile(
                                                      isThreeLine: false,
                                                      dense: true,
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading,
                                                      title: Text("$choice"),
                                                      value:
                                                          (bloc.questionHelpers[
                                                                      index]
                                                                  as List)
                                                              .contains(choice),
                                                      onChanged: (_) =>
                                                          bloc.onCheckboxChange(
                                                              choice, index),
                                                    );
                                                  }).toList(),
                                                ),
                                              if (question.questionType ==
                                                  "Radioboxes")
                                                Wrap(
                                                  children:
                                                      (question.choices ?? "")
                                                          .split(",")
                                                          .map((choice) {
                                                    return RadioListTile(
                                                      isThreeLine: false,
                                                      dense: true,
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading,
                                                      title: Text("$choice"),
                                                      value: choice,
                                                      groupValue:
                                                          bloc.questionHelpers[
                                                              index],
                                                      onChanged: (selected) =>
                                                          bloc.onRadioButtonChange(
                                                              selected, index),
                                                    );
                                                  }).toList(),
                                                ),
                                              if (question.questionType ==
                                                  "StringMultiline")
                                                TextFormField(
                                                  controller: bloc
                                                      .questionHelpers[index],
                                                  maxLines:
                                                      question.numberOfLines > 0
                                                          ? question
                                                              .numberOfLines
                                                          : 2,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    hintText:
                                                        question.description,
                                                  ),
                                                ),
                                              if (question.questionType ==
                                                  "Photo")
                                                GestureDetector(
                                                  onTap: () =>
                                                      bloc.takePhoto(index),
                                                  child: Container(
                                                    height:
                                                        (bloc.questionHelpers[
                                                                    index] !=
                                                                null)
                                                            ? 200.0
                                                            : 50.0,
                                                    width: double.infinity,
                                                    color: Colors.grey[100],
                                                    child: Container(
                                                      child:
                                                          (bloc.questionHelpers[
                                                                      index] !=
                                                                  null)
                                                              ? Image.file(
                                                                  bloc.questionHelpers[
                                                                      index],
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )
                                                              : Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: <
                                                                      Widget>[
                                                                    Icon(
                                                                      Icons
                                                                          .camera_alt,
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        "PHOTO",
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                    ),
                                                  ),
                                                ),
                                              if (question.questionType ==
                                                  "Date")
                                                Container(
                                                  padding: EdgeInsets.all(0.0)
                                                      .copyWith(
                                                          bottom: 0.0,
                                                          top: 5.0),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      TextFormField(
                                                        controller:
                                                            bloc.questionHelpers[
                                                                index][0],
                                                        decoration:
                                                            InputDecoration(
                                                          isDense: true,
                                                          filled: true,
                                                          hintText: "Date",
                                                          labelText: "Date",
                                                          suffixIcon: Icon(
                                                            Icons.date_range,
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () => bloc
                                                            .pickDate(index),
                                                        child: Container(
                                                          color: Colors
                                                              .transparent,
                                                          height: 50.0,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              if (question.questionType ==
                                                  "Time")
                                                Container(
                                                  padding: EdgeInsets.all(0.0)
                                                      .copyWith(
                                                          bottom: 0.0,
                                                          top: 5.0),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      TextFormField(
                                                        controller:
                                                            bloc.questionHelpers[
                                                                index][0],
                                                        decoration:
                                                            InputDecoration(
                                                          isDense: true,
                                                          filled: true,
                                                          hintText: "Time",
                                                          labelText: "Time",
                                                          suffixIcon: Icon(
                                                            Icons.access_time,
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () => bloc
                                                            .pickTime(index),
                                                        child: Container(
                                                          color: Colors
                                                              .transparent,
                                                          height: 50.0,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                      Container(
                                        padding: EdgeInsets.all(
                                          10.0,
                                        ).copyWith(top: 0.0),
                                        child: MaterialButton(
                                          height: 45.0,
                                          textColor: Colors.white,
                                          onPressed: bloc.submitSurvey,
                                          color: Theme.of(context).accentColor,
                                          child: Text(
                                            "SUBMIT SURVEY",
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                        ),
                        Footer(),
                      ],
                    );
                  },
                ),
              ),
            );
          }),
    );
  }
}
