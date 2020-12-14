import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/survey.dart';
import 'package:solutech_sat/data/models/survey_property.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/surveys_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:solutech_sat/utils/format_utils.dart';
import 'package:solutech_sat/utils/image_utils.dart';

class SurveyBloc extends Bloc {
  SurveyProperty survey;
  Customer customer;
  SurveyBloc({this.customer});
  List<dynamic> questionHelpers = [];

  void onSelectSurvey(SurveyProperty survey) {
    this.survey = survey;
    setQuestionHelpers();
  }

  void loadData() {
    if (connectionManager.isConnected) {
      surveysManager.loadSurveys().catchError((error) {
        surveysManager.loadingSurveys = false;
      });
    } else {
      Future.delayed(Duration(milliseconds: 1)).then((done) {
        alert(
            "You are offline", "Make sure you enable data then tap on refresh");
      });
    }
  }

  void pickDate(index) async {
    DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365 * 100)),
      lastDate: DateTime.now().add(
        Duration(days: 50),
      ),
    );
    if (pickedDate != null) {
      questionHelpers[index][0].text =
          "${formatDate(pickedDate, "MMM d, yyyy")}";
      questionHelpers[index][1] = pickedDate;
    }
  }

  void pickTime(index) async {
    TimeOfDay pickedDate = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    if (pickedDate != null) {
      questionHelpers[index][0].text = pickedDate.format(context);
      questionHelpers[index][1] = pickedDate;
    }
  }

  void setQuestionHelpers() {
    questionHelpers = surveysManager
        .getSurveyQuestionsById(survey.id)
        .map<dynamic>((surveyQuestion) {
      if (surveyQuestion.questionType == "String" ||
          surveyQuestion.questionType == "StringMultiline") {
        return TextEditingController();
      } else if (surveyQuestion.questionType == "Number") {
        return TextEditingController();
      } else if (surveyQuestion.questionType == "Checkboxes") {
        return [];
      } else if (surveyQuestion.questionType == "Radioboxes") {
        return null;
      } else if (surveyQuestion.questionType == "Date") {
        return [
          TextEditingController(),
          DateTime.now(),
        ];
      } else if (surveyQuestion.questionType == "Time") {
        return [
          TextEditingController(),
          DateTime.now(),
        ];
      } else if (surveyQuestion.questionType == "Photo") {
        return null;
      } else {
        return null;
      }
    }).toList();
    notifyChanges();
  }

  void takePhoto(index) async {
    File image;
    var pickedImage = await ImagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = await compressImageFile(pickedImage);
      questionHelpers[index] = image;
      notifyChanges();
    }
  }

  void onCheckboxChange(String choice, index) {
    if ((questionHelpers[index] as List).contains(choice)) {
      (questionHelpers[index] as List).remove(choice);
    } else {
      (questionHelpers[index] as List).add(choice);
    }
    notifyChanges();
  }

  void onRadioButtonChange(String selected, index) {
    if (questionHelpers[index] == selected) {
      questionHelpers[index] = null;
    } else {
      questionHelpers[index] = selected;
    }
    notifyChanges();
  }

  bool validFields() {
    var validFields = surveysManager
        .getSurveyQuestionsById(survey.id)
        .map<bool>((surveyQuestion) {
      var index = surveysManager
          .getSurveyQuestionsById(survey.id)
          .indexOf(surveyQuestion);
      if (surveyQuestion.questionType == "String" ||
          surveyQuestion.questionType == "StringMultiline") {
        return surveyQuestion.required == "true"
            ? questionHelpers[index].text.trim() != ""
            : true;
      } else if (surveyQuestion.questionType == "Number") {
        return surveyQuestion.required == "true"
            ? questionHelpers[index].text.trim() != ""
            : true;
      } else if (surveyQuestion.questionType == "Checkboxes") {
        return surveyQuestion.required == "true"
            ? questionHelpers[index].length > 0
            : true;
      } else if (surveyQuestion.questionType == "Radioboxes") {
        return surveyQuestion.required == "true"
            ? questionHelpers[index] != null
            : true;
      } else if (surveyQuestion.questionType == "Date") {
        return surveyQuestion.required == "true"
            ? questionHelpers[index][0].text.trim() != ""
            : true;
      } else if (surveyQuestion.questionType == "Time") {
        return surveyQuestion.required == "true"
            ? questionHelpers[index][0].text.trim() != ""
            : true;
      } else if (surveyQuestion.questionType == "Photo") {
        return surveyQuestion.required == "true"
            ? questionHelpers[index] != null
            : true;
      } else {
        return null;
      }
    }).toList();
    return !validFields.contains(false);
  }

  Future<List<Map<String, dynamic>>> _buildSurveyAnswers() async {
    var validFields = surveysManager
        .getSurveyQuestionsById(survey.id)
        .map<Future<Map<String, dynamic>>>((surveyQuestion) async {
      var index = surveysManager
          .getSurveyQuestionsById(survey.id)
          .indexOf(surveyQuestion);
      if (surveyQuestion.questionType == "String" ||
          surveyQuestion.questionType == "StringMultiline") {
        return Future.value({
          "question_id": surveyQuestion.questionId,
          "question": surveyQuestion.questionTitle,
          "question_type": surveyQuestion.questionType,
          "answer": questionHelpers[index].text.trim()
        });
      } else if (surveyQuestion.questionType == "Number") {
        return Future.value({
          "question_id": surveyQuestion.questionId,
          "question": surveyQuestion.questionTitle,
          "question_type": surveyQuestion.questionType,
          "answer": questionHelpers[index].text.trim()
        });
      } else if (surveyQuestion.questionType == "Checkboxes") {
        return Future.value({
          "question_id": surveyQuestion.questionId,
          "question": surveyQuestion.questionTitle,
          "question_type": surveyQuestion.questionType,
          "answer": questionHelpers[index].join(",")
        });
      } else if (surveyQuestion.questionType == "Radioboxes") {
        return Future.value({
          "question_id": surveyQuestion.questionId,
          "question": surveyQuestion.questionTitle,
          "question_type": surveyQuestion.questionType,
          "answer": questionHelpers[index]
        });
      } else if (surveyQuestion.questionType == "Date") {
        return Future.value({
          "question_id": surveyQuestion.questionId,
          "question": surveyQuestion.questionTitle,
          "question_type": surveyQuestion.questionType,
          "answer": questionHelpers[index][0].text.trim() != ""
              ? formatDate(questionHelpers[index][1].toString(), "xt")
              : null
        });
      } else if (surveyQuestion.questionType == "Time") {
        return Future.value({
          "question_id": surveyQuestion.questionId,
          "question": surveyQuestion.questionTitle,
          "question_type": surveyQuestion.questionType,
          "answer": questionHelpers[index][0].text.trim()
        });
      } else if (surveyQuestion.questionType == "Photo") {
        return Future.value({
          "question_id": surveyQuestion.questionId,
          "question": surveyQuestion.questionTitle,
          "question_type": surveyQuestion.questionType,
          "answer": (questionHelpers[index] != null)
              ? await base64FromFile(File(questionHelpers[index].path))
              : null
        });
      } else {
        return null;
      }
    }).toList();
    return Future.wait(validFields);
  }

  void submitSurvey() async {
    if (validFields()) {
      if (!await confirm(
          "Save survey", "This will save the survey you just filled")) return;
      var answers = await _buildSurveyAnswers();
      var currentLocation = await locationManager.currentLocation();
      surveysManager
          .saveSurvey(
        survey: survey,
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
        customer: customer,
        entryTime: DateTime.now(),
        items: answers,
      )
          .then((response) {
        alert("Survey saved", "Your answers to this survey has been saved.",
            onOk: () {
          pop();
        });
      });
    } else {
      alert(
        "Empty fields",
        "Make sure that all required fields are filled to continue.",
      );
    }
  }

  Future<bool> onWillPop() async {
    if (survey != null) {
      bool exit = await confirm(
          "Exit survey?", "This will discard all changes and close survey.");
      if (exit) {
        survey = null;
        notifyChanges();
      }
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
  }
}
