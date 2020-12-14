import 'package:solutech_sat/data/models/survey_answer.dart';

class GroupedSurveyAnswers {
  String surveyTitle;
  int surveyId;
  int shopId;
  DateTime entryTime;
  double latitude;
  double longitude;
  bool synced;
  List<SurveyAnswer> items;

  GroupedSurveyAnswers({
    this.surveyTitle,
    this.surveyId,
    this.shopId,
    this.entryTime,
    this.items,
    this.latitude,
    this.longitude,
    this.synced,
  });

  factory GroupedSurveyAnswers.fromMap(Map<String, dynamic> json) =>
      GroupedSurveyAnswers(
        surveyId: json["survey_id"],
        surveyTitle: json["survey_title"],
        shopId: json["shop_id"],
        entryTime: json["entry_time"] != null
            ? DateTime.parse(json["entry_time"])
            : null,
        latitude: json["latitude"],
        longitude: json["longitude"],
        items: json["items"],
      );

  Map<String, dynamic> toMap() => {
        "survey_id": surveyId,
        "survey_title": surveyTitle,
        "shop_id": shopId,
        "entry_time": entryTime?.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
        "synced": synced,
        "items": items,
      };
}
