// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_question_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _SurveyQuestionBean implements Bean<SurveyQuestion> {
  final questionId = IntField('question_id');
  final surveyId = IntField('survey_id');
  final questionType = StrField('question_type');
  final questionTitle = StrField('question_title');
  final description = StrField('description');
  final required = StrField('required');
  final numberOfLines = IntField('number_of_lines');
  final randomChoices = StrField('random_choices');
  final choices = StrField('choices');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        questionId.name: questionId,
        surveyId.name: surveyId,
        questionType.name: questionType,
        questionTitle.name: questionTitle,
        description.name: description,
        required.name: required,
        numberOfLines.name: numberOfLines,
        randomChoices.name: randomChoices,
        choices.name: choices,
      };
  SurveyQuestion fromMap(Map map) {
    SurveyQuestion model = SurveyQuestion();
    model.questionId = adapter.parseValue(map['question_id']);
    model.surveyId = adapter.parseValue(map['survey_id']);
    model.questionType = adapter.parseValue(map['question_type']);
    model.questionTitle = adapter.parseValue(map['question_title']);
    model.description = adapter.parseValue(map['description']);
    model.required = adapter.parseValue(map['required']);
    model.numberOfLines = adapter.parseValue(map['number_of_lines']);
    model.randomChoices = adapter.parseValue(map['random_choices']);
    model.choices = adapter.parseValue(map['choices']);

    return model;
  }

  List<SetColumn> toSetColumns(SurveyQuestion model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(questionId.set(model.questionId));
      ret.add(surveyId.set(model.surveyId));
      ret.add(questionType.set(model.questionType));
      ret.add(questionTitle.set(model.questionTitle));
      ret.add(description.set(model.description));
      ret.add(required.set(model.required));
      ret.add(numberOfLines.set(model.numberOfLines));
      ret.add(randomChoices.set(model.randomChoices));
      ret.add(choices.set(model.choices));
    } else if (only != null) {
      if (only.contains(questionId.name))
        ret.add(questionId.set(model.questionId));
      if (only.contains(surveyId.name)) ret.add(surveyId.set(model.surveyId));
      if (only.contains(questionType.name))
        ret.add(questionType.set(model.questionType));
      if (only.contains(questionTitle.name))
        ret.add(questionTitle.set(model.questionTitle));
      if (only.contains(description.name))
        ret.add(description.set(model.description));
      if (only.contains(required.name)) ret.add(required.set(model.required));
      if (only.contains(numberOfLines.name))
        ret.add(numberOfLines.set(model.numberOfLines));
      if (only.contains(randomChoices.name))
        ret.add(randomChoices.set(model.randomChoices));
      if (only.contains(choices.name)) ret.add(choices.set(model.choices));
    } else /* if (onlyNonNull) */ {
      if (model.questionId != null) {
        ret.add(questionId.set(model.questionId));
      }
      if (model.surveyId != null) {
        ret.add(surveyId.set(model.surveyId));
      }
      if (model.questionType != null) {
        ret.add(questionType.set(model.questionType));
      }
      if (model.questionTitle != null) {
        ret.add(questionTitle.set(model.questionTitle));
      }
      if (model.description != null) {
        ret.add(description.set(model.description));
      }
      if (model.required != null) {
        ret.add(required.set(model.required));
      }
      if (model.numberOfLines != null) {
        ret.add(numberOfLines.set(model.numberOfLines));
      }
      if (model.randomChoices != null) {
        ret.add(randomChoices.set(model.randomChoices));
      }
      if (model.choices != null) {
        ret.add(choices.set(model.choices));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(questionId.name, isNullable: true);
    st.addInt(surveyId.name, isNullable: true);
    st.addStr(questionType.name, isNullable: true);
    st.addStr(questionTitle.name, isNullable: true);
    st.addStr(description.name, isNullable: true);
    st.addStr(required.name, isNullable: true);
    st.addInt(numberOfLines.name, isNullable: true);
    st.addStr(randomChoices.name, isNullable: true);
    st.addStr(choices.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(SurveyQuestion model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<SurveyQuestion> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(SurveyQuestion model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<SurveyQuestion> models,
      {bool onlyNonNull = false,
      Set<String> only,
      isForeignKeyEnabled = false}) async {
    final List<List<SetColumn>> data = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
    }
    final UpsertMany upsert = upserters.addAll(data);
    await adapter.upsertMany(upsert);
    return;
  }

  Future<void> updateMany(List<SurveyQuestion> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(null);
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }
}
