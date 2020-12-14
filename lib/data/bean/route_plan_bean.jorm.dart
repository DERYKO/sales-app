// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_plan_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _RoutePlanBean implements Bean<RoutePlan> {
  final id = IntField('id');
  final name = StrField('name');
  final description = StrField('description');
  final visitDay = StrField('visit_day');
  final visitWeek = StrField('visit_week');
  final frequency = StrField('frequency');
  final shops = IntField('shops');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        name.name: name,
        description.name: description,
        visitDay.name: visitDay,
        visitWeek.name: visitWeek,
        frequency.name: frequency,
        shops.name: shops,
      };
  RoutePlan fromMap(Map map) {
    RoutePlan model = RoutePlan();
    model.id = adapter.parseValue(map['id']);
    model.name = adapter.parseValue(map['name']);
    model.description = adapter.parseValue(map['description']);
    model.visitDay = adapter.parseValue(map['visit_day']);
    model.visitWeek = adapter.parseValue(map['visit_week']);
    model.frequency = adapter.parseValue(map['frequency']);
    model.shops = adapter.parseValue(map['shops']);

    return model;
  }

  List<SetColumn> toSetColumns(RoutePlan model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(id.set(model.id));
      ret.add(name.set(model.name));
      ret.add(description.set(model.description));
      ret.add(visitDay.set(model.visitDay));
      ret.add(visitWeek.set(model.visitWeek));
      ret.add(frequency.set(model.frequency));
      ret.add(shops.set(model.shops));
    } else if (only != null) {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(name.name)) ret.add(name.set(model.name));
      if (only.contains(description.name))
        ret.add(description.set(model.description));
      if (only.contains(visitDay.name)) ret.add(visitDay.set(model.visitDay));
      if (only.contains(visitWeek.name))
        ret.add(visitWeek.set(model.visitWeek));
      if (only.contains(frequency.name))
        ret.add(frequency.set(model.frequency));
      if (only.contains(shops.name)) ret.add(shops.set(model.shops));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.name != null) {
        ret.add(name.set(model.name));
      }
      if (model.description != null) {
        ret.add(description.set(model.description));
      }
      if (model.visitDay != null) {
        ret.add(visitDay.set(model.visitDay));
      }
      if (model.visitWeek != null) {
        ret.add(visitWeek.set(model.visitWeek));
      }
      if (model.frequency != null) {
        ret.add(frequency.set(model.frequency));
      }
      if (model.shops != null) {
        ret.add(shops.set(model.shops));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, isNullable: false);
    st.addStr(name.name, isNullable: true);
    st.addStr(description.name, isNullable: true);
    st.addStr(visitDay.name, isNullable: true);
    st.addStr(visitWeek.name, isNullable: true);
    st.addStr(frequency.name, isNullable: true);
    st.addInt(shops.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(RoutePlan model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<RoutePlan> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(RoutePlan model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<RoutePlan> models,
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

  Future<void> updateMany(List<RoutePlan> models,
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
