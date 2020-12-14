// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _PerformanceBean implements Bean<Performance> {
  final id = IntField('id');
  final productDesc = StrField('product_desc');
  final target = StrField('target');
  final achieved = StrField('achieved');
  final perfomance = StrField('perfomance');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        productDesc.name: productDesc,
        target.name: target,
        achieved.name: achieved,
        perfomance.name: perfomance,
      };
  Performance fromMap(Map map) {
    Performance model = Performance();
    model.id = adapter.parseValue(map['id']);
    model.productDesc = adapter.parseValue(map['product_desc']);
    model.target = adapter.parseValue(map['target']);
    model.achieved = adapter.parseValue(map['achieved']);
    model.perfomance = adapter.parseValue(map['perfomance']);

    return model;
  }

  List<SetColumn> toSetColumns(Performance model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(productDesc.set(model.productDesc));
      ret.add(target.set(model.target));
      ret.add(achieved.set(model.achieved));
      ret.add(perfomance.set(model.perfomance));
    } else if (only != null) {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(productDesc.name))
        ret.add(productDesc.set(model.productDesc));
      if (only.contains(target.name)) ret.add(target.set(model.target));
      if (only.contains(achieved.name)) ret.add(achieved.set(model.achieved));
      if (only.contains(perfomance.name))
        ret.add(perfomance.set(model.perfomance));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.productDesc != null) {
        ret.add(productDesc.set(model.productDesc));
      }
      if (model.target != null) {
        ret.add(target.set(model.target));
      }
      if (model.achieved != null) {
        ret.add(achieved.set(model.achieved));
      }
      if (model.perfomance != null) {
        ret.add(perfomance.set(model.perfomance));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, autoIncrement: true, isNullable: false);
    st.addStr(productDesc.name, isNullable: true);
    st.addStr(target.name, isNullable: true);
    st.addStr(achieved.name, isNullable: true);
    st.addStr(perfomance.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Performance model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      Performance newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<Performance> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Performance model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    var retId;
    if (isForeignKeyEnabled) {
      final Insert insert = Insert(tableName, ignoreIfExist: true)
          .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
      retId = await adapter.insert(insert);
      if (retId == null) {
        final Update update = updater
            .where(this.id.eq(model.id))
            .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
        retId = adapter.update(update);
      }
    } else {
      final Upsert upsert = upserter
          .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
          .id(id.name);
      retId = await adapter.upsert(upsert);
    }
    if (cascade) {
      Performance newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<Performance> models,
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

  Future<int> update(Performance model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Performance> models,
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

  Future<Performance> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Performance> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
