import 'package:jaguar_orm/jaguar_orm.dart';

class SurveyQuestion {
  @Column(isNullable: true)
  int questionId;
  @Column(isNullable: true)
  int surveyId;
  @Column(isNullable: true)
  String questionType;
  @Column(isNullable: true)
  String questionTitle;
  @Column(isNullable: true)
  String description;
  @Column(isNullable: true)
  String required;
  @Column(isNullable: true)
  int numberOfLines;
  @Column(isNullable: true)
  String randomChoices;
  @Column(isNullable: true)
  String choices;

  SurveyQuestion({
    this.questionId,
    this.surveyId,
    this.questionType,
    this.questionTitle,
    this.description,
    this.required,
    this.numberOfLines,
    this.randomChoices,
    this.choices,
  });

  factory SurveyQuestion.fromMap(Map<String, dynamic> json) => SurveyQuestion(
        questionId: json["question_id"],
        surveyId: json["survey_id"],
        questionType: json["question_type"],
        questionTitle: json["question_title"],
        description: json["description"],
        required: json["required"],
        numberOfLines: json["number_of_lines"],
        randomChoices: json["random_choices"],
        choices: json["choices"],
      );

  Map<String, dynamic> toMap() => {
        "question_id": questionId,
        "survey_id": surveyId,
        "question_type": questionType,
        "question_title": questionTitle,
        "description": description,
        "required": required,
        "number_of_lines": numberOfLines,
        "random_choices": randomChoices,
        "choices": choices,
      };
}
