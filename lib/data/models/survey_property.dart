import 'package:jaguar_orm/jaguar_orm.dart';

class SurveyProperty {
  @PrimaryKey(auto: false)
  int id;
  @Column(isNullable: true)
  String surveyTitle;
  @Column(isNullable: true)
  String introMessage;
  @Column(isNullable: true)
  String endMessage;
  @Column(isNullable: true)
  String skipIntro;

  SurveyProperty({
    this.id,
    this.surveyTitle,
    this.introMessage,
    this.endMessage,
    this.skipIntro,
  });

  factory SurveyProperty.fromMap(Map<String, dynamic> json) => SurveyProperty(
        id: json["id"],
        surveyTitle: json["survey_title"],
        introMessage: json["intro_message"],
        endMessage: json["end_message"],
        skipIntro: json["skip_intro"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "survey_title": surveyTitle,
        "intro_message": introMessage,
        "end_message": endMessage,
        "skip_intro": skipIntro,
      };
}
