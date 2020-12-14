// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_answer_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _SurveyAnswerBean implements Bean<SurveyAnswer> {
  final surveyTitle = StrField('survey_title');
  final answerId = IntField('answer_id');
  final surveyId = IntField('survey_id');
  final questionType = StrField('question_type');
  final questionId = IntField('question_id');
  final shopName = StrField('shop_name');
  final shopId = IntField('shop_id');
  final question = StrField('question');
  final latitude = DoubleField('latitude');
  final longitude = DoubleField('longitude');
  final answer = StrField('answer');
  final entryTime = DateTimeField('entry_time');
  final fromServer = BoolField('from_server');
  final synced = BoolField('synced');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        surveyTitle.name: surveyTitle,
        answerId.name: answerId,
        surveyId.name: surveyId,
        questionType.name: questionType,
        questionId.name: questionId,
        shopName.name: shopName,
        shopId.name: shopId,
        question.name: question,
        latitude.name: latitude,
        longitude.name: longitude,
        answer.name: answer,
        entryTime.name: entryTime,
        fromServer.name: fromServer,
        synced.name: synced,
      };
  SurveyAnswer fromMap(Map map) {
    SurveyAnswer model = SurveyAnswer();
    model.surveyTitle = adapter.parseValue(map['survey_title']);
    model.answerId = adapter.parseValue(map['answer_id']);
    model.surveyId = adapter.parseValue(map['survey_id']);
    model.questionType = adapter.parseValue(map['question_type']);
    model.questionId = adapter.parseValue(map['question_id']);
    model.shopName = adapter.parseValue(map['shop_name']);
    model.shopId = adapter.parseValue(map['shop_id']);
    model.question = adapter.parseValue(map['question']);
    model.latitude = adapter.parseValue(map['latitude']);
    model.longitude = adapter.parseValue(map['longitude']);
    model.answer = adapter.parseValue(map['answer']);
    model.entryTime = adapter.parseValue(map['entry_time']);
    model.fromServer = adapter.parseValue(map['from_server']);
    model.synced = adapter.parseValue(map['synced']);

    return model;
  }

  List<SetColumn> toSetColumns(SurveyAnswer model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(surveyTitle.set(model.surveyTitle));
      ret.add(answerId.set(model.answerId));
      ret.add(surveyId.set(model.surveyId));
      ret.add(questionType.set(model.questionType));
      ret.add(questionId.set(model.questionId));
      ret.add(shopName.set(model.shopName));
      ret.add(shopId.set(model.shopId));
      ret.add(question.set(model.question));
      ret.add(latitude.set(model.latitude));
      ret.add(longitude.set(model.longitude));
      ret.add(answer.set(model.answer));
      ret.add(entryTime.set(model.entryTime));
      ret.add(fromServer.set(model.fromServer));
      ret.add(synced.set(model.synced));
    } else if (only != null) {
      if (only.contains(surveyTitle.name))
        ret.add(surveyTitle.set(model.surveyTitle));
      if (only.contains(answerId.name)) ret.add(answerId.set(model.answerId));
      if (only.contains(surveyId.name)) ret.add(surveyId.set(model.surveyId));
      if (only.contains(questionType.name))
        ret.add(questionType.set(model.questionType));
      if (only.contains(questionId.name))
        ret.add(questionId.set(model.questionId));
      if (only.contains(shopName.name)) ret.add(shopName.set(model.shopName));
      if (only.contains(shopId.name)) ret.add(shopId.set(model.shopId));
      if (only.contains(question.name)) ret.add(question.set(model.question));
      if (only.contains(latitude.name)) ret.add(latitude.set(model.latitude));
      if (only.contains(longitude.name))
        ret.add(longitude.set(model.longitude));
      if (only.contains(answer.name)) ret.add(answer.set(model.answer));
      if (only.contains(entryTime.name))
        ret.add(entryTime.set(model.entryTime));
      if (only.contains(fromServer.name))
        ret.add(fromServer.set(model.fromServer));
      if (only.contains(synced.name)) ret.add(synced.set(model.synced));
    } else /* if (onlyNonNull) */ {
      if (model.surveyTitle != null) {
        ret.add(surveyTitle.set(model.surveyTitle));
      }
      if (model.answerId != null) {
        ret.add(answerId.set(model.answerId));
      }
      if (model.surveyId != null) {
        ret.add(surveyId.set(model.surveyId));
      }
      if (model.questionType != null) {
        ret.add(questionType.set(model.questionType));
      }
      if (model.questionId != null) {
        ret.add(questionId.set(model.questionId));
      }
      if (model.shopName != null) {
        ret.add(shopName.set(model.shopName));
      }
      if (model.shopId != null) {
        ret.add(shopId.set(model.shopId));
      }
      if (model.question != null) {
        ret.add(question.set(model.question));
      }
      if (model.latitude != null) {
        ret.add(latitude.set(model.latitude));
      }
      if (model.longitude != null) {
        ret.add(longitude.set(model.longitude));
      }
      if (model.answer != null) {
        ret.add(answer.set(model.answer));
      }
      if (model.entryTime != null) {
        ret.add(entryTime.set(model.entryTime));
      }
      if (model.fromServer != null) {
        ret.add(fromServer.set(model.fromServer));
      }
      if (model.synced != null) {
        ret.add(synced.set(model.synced));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addStr(surveyTitle.name, isNullable: true);
    st.addInt(answerId.name, isNullable: true);
    st.addInt(surveyId.name, isNullable: true);
    st.addStr(questionType.name, isNullable: true);
    st.addInt(questionId.name, isNullable: true);
    st.addStr(shopName.name, isNullable: true);
    st.addInt(shopId.name, isNullable: true);
    st.addStr(question.name, isNullable: true);
    st.addDouble(latitude.name, isNullable: true);
    st.addDouble(longitude.name, isNullable: true);
    st.addStr(answer.name, isNullable: true);
    st.addDateTime(entryTime.name, isNullable: true);
    st.addBool(fromServer.name, isNullable: true);
    st.addBool(synced.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(SurveyAnswer model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<SurveyAnswer> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(SurveyAnswer model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<SurveyAnswer> models,
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

  Future<void> updateMany(List<SurveyAnswer> models,
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
