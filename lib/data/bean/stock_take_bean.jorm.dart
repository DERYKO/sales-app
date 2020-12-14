// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_take_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _StockTakeBean implements Bean<StockTake> {
  final id = IntField('id');
  final visitid = StrField('visitid');
  final salerId = IntField('saler_id');
  final outletId = IntField('outlet_id');
  final entryTime = DateTimeField('entry_time');
  final stockphoto = StrField('stockphoto');
  final latitude = DoubleField('latitude');
  final longitude = DoubleField('longitude');
  final synced = BoolField('synced');
  final fromServer = BoolField('from_server');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        visitid.name: visitid,
        salerId.name: salerId,
        outletId.name: outletId,
        entryTime.name: entryTime,
        stockphoto.name: stockphoto,
        latitude.name: latitude,
        longitude.name: longitude,
        synced.name: synced,
        fromServer.name: fromServer,
      };
  StockTake fromMap(Map map) {
    StockTake model = StockTake();
    model.id = adapter.parseValue(map['id']);
    model.visitid = adapter.parseValue(map['visitid']);
    model.salerId = adapter.parseValue(map['saler_id']);
    model.outletId = adapter.parseValue(map['outlet_id']);
    model.entryTime = adapter.parseValue(map['entry_time']);
    model.stockphoto = adapter.parseValue(map['stockphoto']);
    model.latitude = adapter.parseValue(map['latitude']);
    model.longitude = adapter.parseValue(map['longitude']);
    model.synced = adapter.parseValue(map['synced']);
    model.fromServer = adapter.parseValue(map['from_server']);

    return model;
  }

  List<SetColumn> toSetColumns(StockTake model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(visitid.set(model.visitid));
      ret.add(salerId.set(model.salerId));
      ret.add(outletId.set(model.outletId));
      ret.add(entryTime.set(model.entryTime));
      ret.add(stockphoto.set(model.stockphoto));
      ret.add(latitude.set(model.latitude));
      ret.add(longitude.set(model.longitude));
      ret.add(synced.set(model.synced));
      ret.add(fromServer.set(model.fromServer));
    } else if (only != null) {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(visitid.name)) ret.add(visitid.set(model.visitid));
      if (only.contains(salerId.name)) ret.add(salerId.set(model.salerId));
      if (only.contains(outletId.name)) ret.add(outletId.set(model.outletId));
      if (only.contains(entryTime.name))
        ret.add(entryTime.set(model.entryTime));
      if (only.contains(stockphoto.name))
        ret.add(stockphoto.set(model.stockphoto));
      if (only.contains(latitude.name)) ret.add(latitude.set(model.latitude));
      if (only.contains(longitude.name))
        ret.add(longitude.set(model.longitude));
      if (only.contains(synced.name)) ret.add(synced.set(model.synced));
      if (only.contains(fromServer.name))
        ret.add(fromServer.set(model.fromServer));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.visitid != null) {
        ret.add(visitid.set(model.visitid));
      }
      if (model.salerId != null) {
        ret.add(salerId.set(model.salerId));
      }
      if (model.outletId != null) {
        ret.add(outletId.set(model.outletId));
      }
      if (model.entryTime != null) {
        ret.add(entryTime.set(model.entryTime));
      }
      if (model.stockphoto != null) {
        ret.add(stockphoto.set(model.stockphoto));
      }
      if (model.latitude != null) {
        ret.add(latitude.set(model.latitude));
      }
      if (model.longitude != null) {
        ret.add(longitude.set(model.longitude));
      }
      if (model.synced != null) {
        ret.add(synced.set(model.synced));
      }
      if (model.fromServer != null) {
        ret.add(fromServer.set(model.fromServer));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, autoIncrement: true, isNullable: false);
    st.addStr(visitid.name, isNullable: true);
    st.addInt(salerId.name, isNullable: true);
    st.addInt(outletId.name, isNullable: true);
    st.addDateTime(entryTime.name, isNullable: true);
    st.addStr(stockphoto.name, isNullable: true);
    st.addDouble(latitude.name, isNullable: true);
    st.addDouble(longitude.name, isNullable: true);
    st.addBool(synced.name, isNullable: true);
    st.addBool(fromServer.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(StockTake model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      StockTake newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<StockTake> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(StockTake model,
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
      StockTake newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<StockTake> models,
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

  Future<int> update(StockTake model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<StockTake> models,
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

  Future<StockTake> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<StockTake> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
