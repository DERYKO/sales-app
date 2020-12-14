import 'package:jaguar_orm/jaguar_orm.dart';

class SurveyAnswer {
  @Column(isNullable: true)
  String surveyTitle;
  @Column(isNullable: true)
  int answerId;
  @Column(isNullable: true)
  int surveyId;
  @Column(isNullable: true)
  String questionType;
  @Column(isNullable: true)
  int questionId;
  @Column(isNullable: true)
  String shopName;
  @Column(isNullable: true)
  int shopId;
  @Column(isNullable: true)
  String question;
  @Column(isNullable: true)
  double latitude;
  @Column(isNullable: true)
  double longitude;
  @Column(isNullable: true)
  String answer;
  @Column(isNullable: true)
  DateTime entryTime;
  @Column(isNullable: true)
  bool fromServer;
  @Column(isNullable: true)
  bool synced;

  SurveyAnswer({
    this.surveyTitle,
    this.answerId,
    this.surveyId,
    this.questionType,
    this.questionId,
    this.shopId,
    this.latitude,
    this.longitude,
    this.shopName,
    this.question,
    this.answer,
    this.entryTime,
    this.fromServer = false,
    this.synced = false,
  });

  factory SurveyAnswer.fromMap(Map<String, dynamic> json) => SurveyAnswer(
        surveyTitle: json["survey_title"],
        answerId: json["answer_id"],
        surveyId: json["survey_id"],
        shopId: json["shop_id"],
        questionType: json["question_type"],
        questionId: json["question_id"],
        shopName: json["shop_name"],
        question: json["question"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        answer: json["answer"],
        entryTime: json["entry_time"] != null
            ? DateTime.parse(json["entry_time"])
            : null,
      );

  Map<String, dynamic> toMap() => {
        "survey_title": surveyTitle,
        "answer_id": answerId,
        "survey_id": surveyId,
        "shop_id": shopId,
        "question_type": questionType,
        "question_id": questionId,
        "shop_name": shopName,
        "question": question,
        "latitude": latitude,
        "longitude": longitude,
        "answer": answer,
        "entry_time": entryTime?.toIso8601String(),
      };
}
