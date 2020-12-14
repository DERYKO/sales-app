// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_data_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _AppDataBean implements Bean<AppData> {
  final appdataId = IntField('appdata_id');
  final data = StrField('data');
  final category = StrField('category');
  final appdataTimestamp = StrField('appdata_timestamp');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        appdataId.name: appdataId,
        data.name: data,
        category.name: category,
        appdataTimestamp.name: appdataTimestamp,
      };
  AppData fromMap(Map map) {
    AppData model = AppData();
    model.appdataId = adapter.parseValue(map['appdata_id']);
    model.data = adapter.parseValue(map['data']);
    model.category = adapter.parseValue(map['category']);
    model.appdataTimestamp = adapter.parseValue(map['appdata_timestamp']);

    return model;
  }

  List<SetColumn> toSetColumns(AppData model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(appdataId.set(model.appdataId));
      ret.add(data.set(model.data));
      ret.add(category.set(model.category));
      ret.add(appdataTimestamp.set(model.appdataTimestamp));
    } else if (only != null) {
      if (only.contains(appdataId.name))
        ret.add(appdataId.set(model.appdataId));
      if (only.contains(data.name)) ret.add(data.set(model.data));
      if (only.contains(category.name)) ret.add(category.set(model.category));
      if (only.contains(appdataTimestamp.name))
        ret.add(appdataTimestamp.set(model.appdataTimestamp));
    } else /* if (onlyNonNull) */ {
      if (model.appdataId != null) {
        ret.add(appdataId.set(model.appdataId));
      }
      if (model.data != null) {
        ret.add(data.set(model.data));
      }
      if (model.category != null) {
        ret.add(category.set(model.category));
      }
      if (model.appdataTimestamp != null) {
        ret.add(appdataTimestamp.set(model.appdataTimestamp));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(appdataId.name, primary: true, isNullable: false);
    st.addStr(data.name, isNullable: true);
    st.addStr(category.name, isNullable: true);
    st.addStr(appdataTimestamp.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(AppData model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<AppData> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(AppData model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<AppData> models,
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

  Future<int> update(AppData model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.appdataId.eq(model.appdataId))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<AppData> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(this.appdataId.eq(model.appdataId));
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<AppData> find(int appdataId,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.appdataId.eq(appdataId));
    return await findOne(find);
  }

  Future<int> remove(int appdataId) async {
    final Remove remove = remover.where(this.appdataId.eq(appdataId));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<AppData> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.appdataId.eq(model.appdataId));
    }
    return adapter.remove(remove);
  }
}
