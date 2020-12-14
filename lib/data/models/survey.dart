import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:solutech_sat/data/models/survey_property.dart';
import 'package:solutech_sat/data/models/survey_question.dart';

class Survey {
  SurveyProperty surveyProperties;
  List<SurveyQuestion> questions;

  Survey({
    this.surveyProperties,
    this.questions,
  });

  factory Survey.fromMap(Map<String, dynamic> json) => Survey(
        surveyProperties: SurveyProperty.fromMap(json["survey_properties"]),
        questions: List<SurveyQuestion>.from(
            json["questions"].map((x) => SurveyQuestion.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "survey_properties": surveyProperties.toMap(),
        "questions": List<dynamic>.from(questions.map((x) => x.toMap())),
      };
}
