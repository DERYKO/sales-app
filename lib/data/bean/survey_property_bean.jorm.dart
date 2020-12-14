// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_property_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _SurveyPropertyBean implements Bean<SurveyProperty> {
  final id = IntField('id');
  final surveyTitle = StrField('survey_title');
  final introMessage = StrField('intro_message');
  final endMessage = StrField('end_message');
  final skipIntro = StrField('skip_intro');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        surveyTitle.name: surveyTitle,
        introMessage.name: introMessage,
        endMessage.name: endMessage,
        skipIntro.name: skipIntro,
      };
  SurveyProperty fromMap(Map map) {
    SurveyProperty model = SurveyProperty();
    model.id = adapter.parseValue(map['id']);
    model.surveyTitle = adapter.parseValue(map['survey_title']);
    model.introMessage = adapter.parseValue(map['intro_message']);
    model.endMessage = adapter.parseValue(map['end_message']);
    model.skipIntro = adapter.parseValue(map['skip_intro']);

    return model;
  }

  List<SetColumn> toSetColumns(SurveyProperty model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(id.set(model.id));
      ret.add(surveyTitle.set(model.surveyTitle));
      ret.add(introMessage.set(model.introMessage));
      ret.add(endMessage.set(model.endMessage));
      ret.add(skipIntro.set(model.skipIntro));
    } else if (only != null) {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(surveyTitle.name))
        ret.add(surveyTitle.set(model.surveyTitle));
      if (only.contains(introMessage.name))
        ret.add(introMessage.set(model.introMessage));
      if (only.contains(endMessage.name))
        ret.add(endMessage.set(model.endMessage));
      if (only.contains(skipIntro.name))
        ret.add(skipIntro.set(model.skipIntro));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.surveyTitle != null) {
        ret.add(surveyTitle.set(model.surveyTitle));
      }
      if (model.introMessage != null) {
        ret.add(introMessage.set(model.introMessage));
      }
      if (model.endMessage != null) {
        ret.add(endMessage.set(model.endMessage));
      }
      if (model.skipIntro != null) {
        ret.add(skipIntro.set(model.skipIntro));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, isNullable: false);
    st.addStr(surveyTitle.name, isNullable: true);
    st.addStr(introMessage.name, isNullable: true);
    st.addStr(endMessage.name, isNullable: true);
    st.addStr(skipIntro.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(SurveyProperty model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<SurveyProperty> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(SurveyProperty model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<SurveyProperty> models,
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

  Future<int> update(SurveyProperty model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<SurveyProperty> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(this.id.eq(model.id));
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<SurveyProperty> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<SurveyProperty> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
