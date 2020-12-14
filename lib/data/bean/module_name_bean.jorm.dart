// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_name_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _ModuleNameBean implements Bean<ModuleName> {
  final id = IntField('id');
  final moduleId = IntField('module_id');
  final moduleName = StrField('module_name');
  final createdAt = DateTimeField('created_at');
  final updatedAt = DateTimeField('updated_at');
  final modulecat = StrField('modulecat');
  final key = StrField('key');
  final applabel = StrField('applabel');
  final status = StrField('status');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        moduleId.name: moduleId,
        moduleName.name: moduleName,
        createdAt.name: createdAt,
        updatedAt.name: updatedAt,
        modulecat.name: modulecat,
        key.name: key,
        applabel.name: applabel,
        status.name: status,
      };
  ModuleName fromMap(Map map) {
    ModuleName model = ModuleName();
    model.id = adapter.parseValue(map['id']);
    model.moduleId = adapter.parseValue(map['module_id']);
    model.moduleName = adapter.parseValue(map['module_name']);
    model.createdAt = adapter.parseValue(map['created_at']);
    model.updatedAt = adapter.parseValue(map['updated_at']);
    model.modulecat = adapter.parseValue(map['modulecat']);
    model.key = adapter.parseValue(map['key']);
    model.applabel = adapter.parseValue(map['applabel']);
    model.status = adapter.parseValue(map['status']);

    return model;
  }

  List<SetColumn> toSetColumns(ModuleName model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(id.set(model.id));
      ret.add(moduleId.set(model.moduleId));
      ret.add(moduleName.set(model.moduleName));
      ret.add(createdAt.set(model.createdAt));
      ret.add(updatedAt.set(model.updatedAt));
      ret.add(modulecat.set(model.modulecat));
      ret.add(key.set(model.key));
      ret.add(applabel.set(model.applabel));
      ret.add(status.set(model.status));
    } else if (only != null) {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(moduleId.name)) ret.add(moduleId.set(model.moduleId));
      if (only.contains(moduleName.name))
        ret.add(moduleName.set(model.moduleName));
      if (only.contains(createdAt.name))
        ret.add(createdAt.set(model.createdAt));
      if (only.contains(updatedAt.name))
        ret.add(updatedAt.set(model.updatedAt));
      if (only.contains(modulecat.name))
        ret.add(modulecat.set(model.modulecat));
      if (only.contains(key.name)) ret.add(key.set(model.key));
      if (only.contains(applabel.name)) ret.add(applabel.set(model.applabel));
      if (only.contains(status.name)) ret.add(status.set(model.status));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.moduleId != null) {
        ret.add(moduleId.set(model.moduleId));
      }
      if (model.moduleName != null) {
        ret.add(moduleName.set(model.moduleName));
      }
      if (model.createdAt != null) {
        ret.add(createdAt.set(model.createdAt));
      }
      if (model.updatedAt != null) {
        ret.add(updatedAt.set(model.updatedAt));
      }
      if (model.modulecat != null) {
        ret.add(modulecat.set(model.modulecat));
      }
      if (model.key != null) {
        ret.add(key.set(model.key));
      }
      if (model.applabel != null) {
        ret.add(applabel.set(model.applabel));
      }
      if (model.status != null) {
        ret.add(status.set(model.status));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, isNullable: false);
    st.addInt(moduleId.name, isNullable: true);
    st.addStr(moduleName.name, isNullable: true);
    st.addDateTime(createdAt.name, isNullable: true);
    st.addDateTime(updatedAt.name, isNullable: true);
    st.addStr(modulecat.name, isNullable: true);
    st.addStr(key.name, isNullable: true);
    st.addStr(applabel.name, isNullable: true);
    st.addStr(status.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(ModuleName model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<ModuleName> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(ModuleName model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<ModuleName> models,
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

  Future<int> update(ModuleName model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<ModuleName> models,
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

  Future<ModuleName> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<ModuleName> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
