// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _RoleBean implements Bean<Role> {
  final key = StrField('key');
  final status = StrField('status');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        key.name: key,
        status.name: status,
      };
  Role fromMap(Map map) {
    Role model = Role();
    model.key = adapter.parseValue(map['key']);
    model.status = adapter.parseValue(map['status']);

    return model;
  }

  List<SetColumn> toSetColumns(Role model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(key.set(model.key));
      ret.add(status.set(model.status));
    } else if (only != null) {
      if (only.contains(key.name)) ret.add(key.set(model.key));
      if (only.contains(status.name)) ret.add(status.set(model.status));
    } else /* if (onlyNonNull) */ {
      if (model.key != null) {
        ret.add(key.set(model.key));
      }
      if (model.status != null) {
        ret.add(status.set(model.status));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addStr(key.name, isNullable: false);
    st.addStr(status.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Role model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<Role> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Role model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<Role> models,
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

  Future<void> updateMany(List<Role> models,
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
