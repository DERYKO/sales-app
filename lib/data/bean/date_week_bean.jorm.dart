// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_week_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _DateWeekBean implements Bean<DateWeek> {
  final dateweekId = IntField('dateweek_id');
  final date = DateTimeField('date');
  final week = IntField('week');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        dateweekId.name: dateweekId,
        date.name: date,
        week.name: week,
      };
  DateWeek fromMap(Map map) {
    DateWeek model = DateWeek();
    model.dateweekId = adapter.parseValue(map['dateweek_id']);
    model.date = adapter.parseValue(map['date']);
    model.week = adapter.parseValue(map['week']);

    return model;
  }

  List<SetColumn> toSetColumns(DateWeek model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(dateweekId.set(model.dateweekId));
      ret.add(date.set(model.date));
      ret.add(week.set(model.week));
    } else if (only != null) {
      if (only.contains(dateweekId.name))
        ret.add(dateweekId.set(model.dateweekId));
      if (only.contains(date.name)) ret.add(date.set(model.date));
      if (only.contains(week.name)) ret.add(week.set(model.week));
    } else /* if (onlyNonNull) */ {
      if (model.dateweekId != null) {
        ret.add(dateweekId.set(model.dateweekId));
      }
      if (model.date != null) {
        ret.add(date.set(model.date));
      }
      if (model.week != null) {
        ret.add(week.set(model.week));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(dateweekId.name, primary: true, isNullable: false);
    st.addDateTime(date.name, isNullable: true);
    st.addInt(week.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(DateWeek model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<DateWeek> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(DateWeek model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<DateWeek> models,
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

  Future<int> update(DateWeek model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.dateweekId.eq(model.dateweekId))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<DateWeek> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(this.dateweekId.eq(model.dateweekId));
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<DateWeek> find(int dateweekId,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.dateweekId.eq(dateweekId));
    return await findOne(find);
  }

  Future<int> remove(int dateweekId) async {
    final Remove remove = remover.where(this.dateweekId.eq(dateweekId));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<DateWeek> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.dateweekId.eq(model.dateweekId));
    }
    return adapter.remove(remove);
  }
}
