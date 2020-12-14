import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:solutech_sat/api/api.dart';
import 'package:solutech_sat/data/database.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/survey_answer.dart';
import 'package:solutech_sat/data/models/survey_info.dart';
import 'package:solutech_sat/data/models/survey_property.dart';
import 'package:solutech_sat/data/models/survey_question.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/manager.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class SurveysManager extends Manager {
  static SurveysManager instance;
  factory SurveysManager() => instance ??= SurveysManager._instance();
  SurveysManager._instance();
  List<SurveyAnswer> surveyAnswers = [];
  List<SurveyProperty> surveyProperties = [];
  List<SurveyQuestion> surveyQuestions = [];
  bool _loadingSurveys = false;
  bool _loadingSurveyAnswers = false;

  Future getDBData() async {
    surveyAnswers = await db.surveyAnswerBean.getAll();
    surveyProperties = await db.surveyPropertyBean.getAll();
    surveyQuestions = await db.surveyQuestionBean.getAll();
    notifyChanges();
  }

  bool get loadingSurveys => _loadingSurveys;

  set loadingSurveys(bool show) {
    _loadingSurveys = show;
    notifyChanges();
  }

  bool get loadingSurveyAnswers => _loadingSurveyAnswers;

  set loadingSurveyAnswers(bool show) {
    _loadingSurveyAnswers = show;
    notifyChanges();
  }

  List<SurveyQuestion> getSurveyQuestionsById(int surveyId) {
    return surveysManager.surveyQuestions
        .where((surveyQuestion) => surveyQuestion.surveyId == surveyId)
        .toList();
  }

  List<GroupedSurveyAnswers> get groupedSurveyAnswers {
    List<GroupedSurveyAnswers> groupedSurveyAnswers = [];
    surveyAnswers.forEach((surveyAnswer) {
      var index = groupedSurveyAnswers.indexWhere(
        (gsA) =>
            gsA.surveyTitle == surveyAnswer.surveyTitle &&
            gsA.entryTime?.toString() == surveyAnswer.entryTime?.toString() &&
            gsA.latitude == surveyAnswer.latitude &&
            gsA.longitude == surveyAnswer.longitude,
      );
      if (index != -1) {
        groupedSurveyAnswers[index].items.add(surveyAnswer);
      } else {
        groupedSurveyAnswers.add(
          GroupedSurveyAnswers(
            surveyTitle: surveyAnswer.surveyTitle,
            entryTime: surveyAnswer.entryTime,
            latitude: surveyAnswer.latitude,
            longitude: surveyAnswer.longitude,
            synced: surveyAnswer.synced,
            surveyId: surveyAnswer.surveyId,
            shopId: surveyAnswer.shopId,
            items: [surveyAnswer],
          ),
        );
      }
    });
    return groupedSurveyAnswers;
  }

  Future loadSurveys() async {
    loadingSurveys = true;
    return api.getSurveys().then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveSurveysLocally(payload);
        loadingSurveys = false;
        return response;
      } else {
        loadingSurveys = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future loadSurveyAnswers([List<DateTime> pickedDates]) async {
    loadingSurveyAnswers = true;
    var filterDates = filterDatesFrom(pickedDates);
    return api.getSurveyAnswers(filterDates).then((response) async {
      if (response.data["status"] == 1) {
        var payload = response.data["payload"];
        await _saveSurveyAnswersLocally(payload);
        loadingSurveyAnswers = false;
        return response;
      } else {
        loadingSurveyAnswers = false;
        throw DioError(
          response: response,
        );
      }
    });
  }

  Future saveSurvey({
    Customer customer,
    double latitude,
    double longitude,
    SurveyProperty survey,
    DateTime entryTime,
    List<Map<String, dynamic>> items,
  }) async {
    for (var item in items) {
      await db.surveyAnswerBean.insert(
        SurveyAnswer(
            shopName: customer?.shopName,
            shopId: customer?.id,
            surveyId: survey.id,
            entryTime: entryTime,
            latitude: latitude,
            longitude: longitude,
            surveyTitle: survey.surveyTitle,
            answer: item["answer"],
            questionId: item["question_id"],
            questionType: item["question_type"],
            question: item["question"],
            synced: false,
            fromServer: false),
      );
    }
    print("Survey inserted");
    await getDBData();
    syncManager.sync();
  }

  Future _saveSurveysLocally(payload) async {
    await db.surveyPropertyBean.removeAll();
    await db.surveyQuestionBean.removeAll();
    for (var item in payload) {
      await db.surveyPropertyBean
          .insert(SurveyProperty.fromMap(item["survey_properties"]));
      for (var question in item["questions"]) {
        await db.surveyQuestionBean.insert(
          SurveyQuestion(
            questionId: question["question_id"],
            questionType: question["question_type"],
            questionTitle: question["question_title"],
            randomChoices: question["random_choices"],
            required: question["required"],
            description: question["description"],
            numberOfLines: question["number_of_lines"],
            choices: question["choices"].join(","),
            surveyId: SurveyProperty.fromMap(item["survey_properties"]).id,
          ),
        );
      }
    }
    print("Survey saved");
    await getDBData();
    notifyChanges();
  }

  Future _saveSurveyAnswersLocally(payload) async {
    await db.surveyAnswerBean.removeAll();
    for (var item in payload) {
      await db.surveyAnswerBean.insert(
        SurveyAnswer.fromMap(item)
          ..fromServer = true
          ..synced = true,
      );
    }
    print("Survey answers saved");
    await getDBData();
    notifyChanges();
  }

  _onSyncError(error) {
    print("Error $error");
  }

  Future syncSurveyAnswers() async {
    List<GroupedSurveyAnswers> unsyncedSurveyAnswers = groupedSurveyAnswers
        .where((GroupedSurveyAnswers groupedSurveyAnswers) =>
            groupedSurveyAnswers.synced == false)
        .toList();
    for (GroupedSurveyAnswers groupedSurveyAnswer in unsyncedSurveyAnswers) {
      if (groupedSurveyAnswer.shopId == null ||
          routePlansManager
              .getCustomerById(groupedSurveyAnswer.shopId)
              .synced) {
        try {
          var response = await api.saveSurveyAnswers({
            "shop_id": groupedSurveyAnswer.shopId,
            "user_id": authManager.user.id,
            "lat": groupedSurveyAnswer.latitude,
            "lon": groupedSurveyAnswer.longitude,
            "survey_id": groupedSurveyAnswer.surveyId,
            "entry_time":
                formatDate(groupedSurveyAnswer.entryTime?.toString(), "xt"),
            "answers": json.encode(groupedSurveyAnswer.items
                .map(((surveyAnswer) => {
                      "question_id": surveyAnswer.questionId,
                      "question": surveyAnswer.question,
                      "question_type": surveyAnswer.questionType,
                      "answer": surveyAnswer.answer
                    }))
                .toList())
          });
          if (response.data["status"] == 1) {
            _onSurveyAnswersSyncResponse();
          } else {
            throw DioError(
              response: response,
            );
          }
        } catch (error) {
          _onSyncError(error);
        }
      }
    }
  }

  bool hasTodaysRecord(
    int customerId,
  ) {
    var now = DateTime.now();
    return surveyAnswers
            .where((SurveyAnswer surveyAnswer) =>
                surveyAnswer.shopId == customerId &&
                DateTime(
                        surveyAnswer.entryTime.year,
                        surveyAnswer.entryTime.month,
                        surveyAnswer.entryTime.day) ==
                    DateTime(now.year, now.month, now.day))
            .toList()
            .length >
        0;
  }

  void _onSurveyAnswersSyncResponse() {
    loadSurveyAnswers();
  }

  @override
  Future init() async {
    super.init();
    await getDBData();
  }
}

var surveysManager = SurveysManager();
