// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'availability_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _AvailabilityBean implements Bean<Availability> {
  final recordId = IntField('record_id');
  final entryTime = DateTimeField('entry_time');
  final shopName = StrField('shop_name');
  final shopId = StrField('shop_id');
  final visitId = StrField('visit_id');
  final latitude = DoubleField('latitude');
  final longitude = DoubleField('longitude');
  final synced = BoolField('synced');
  final fromServer = BoolField('from_server');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        recordId.name: recordId,
        entryTime.name: entryTime,
        shopName.name: shopName,
        shopId.name: shopId,
        visitId.name: visitId,
        latitude.name: latitude,
        longitude.name: longitude,
        synced.name: synced,
        fromServer.name: fromServer,
      };
  Availability fromMap(Map map) {
    Availability model = Availability();
    model.recordId = adapter.parseValue(map['record_id']);
    model.entryTime = adapter.parseValue(map['entry_time']);
    model.shopName = adapter.parseValue(map['shop_name']);
    model.shopId = adapter.parseValue(map['shop_id']);
    model.visitId = adapter.parseValue(map['visit_id']);
    model.latitude = adapter.parseValue(map['latitude']);
    model.longitude = adapter.parseValue(map['longitude']);
    model.synced = adapter.parseValue(map['synced']);
    model.fromServer = adapter.parseValue(map['from_server']);

    return model;
  }

  List<SetColumn> toSetColumns(Availability model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.recordId != null) {
        ret.add(recordId.set(model.recordId));
      }
      ret.add(entryTime.set(model.entryTime));
      ret.add(shopName.set(model.shopName));
      ret.add(shopId.set(model.shopId));
      ret.add(visitId.set(model.visitId));
      ret.add(latitude.set(model.latitude));
      ret.add(longitude.set(model.longitude));
      ret.add(synced.set(model.synced));
      ret.add(fromServer.set(model.fromServer));
    } else if (only != null) {
      if (model.recordId != null) {
        if (only.contains(recordId.name)) ret.add(recordId.set(model.recordId));
      }
      if (only.contains(entryTime.name))
        ret.add(entryTime.set(model.entryTime));
      if (only.contains(shopName.name)) ret.add(shopName.set(model.shopName));
      if (only.contains(shopId.name)) ret.add(shopId.set(model.shopId));
      if (only.contains(visitId.name)) ret.add(visitId.set(model.visitId));
      if (only.contains(latitude.name)) ret.add(latitude.set(model.latitude));
      if (only.contains(longitude.name))
        ret.add(longitude.set(model.longitude));
      if (only.contains(synced.name)) ret.add(synced.set(model.synced));
      if (only.contains(fromServer.name))
        ret.add(fromServer.set(model.fromServer));
    } else /* if (onlyNonNull) */ {
      if (model.recordId != null) {
        ret.add(recordId.set(model.recordId));
      }
      if (model.entryTime != null) {
        ret.add(entryTime.set(model.entryTime));
      }
      if (model.shopName != null) {
        ret.add(shopName.set(model.shopName));
      }
      if (model.shopId != null) {
        ret.add(shopId.set(model.shopId));
      }
      if (model.visitId != null) {
        ret.add(visitId.set(model.visitId));
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
    st.addInt(recordId.name,
        primary: true, autoIncrement: true, isNullable: false);
    st.addDateTime(entryTime.name, isNullable: true);
    st.addStr(shopName.name, isNullable: true);
    st.addStr(shopId.name, isNullable: true);
    st.addStr(visitId.name, isNullable: true);
    st.addDouble(latitude.name, isNullable: true);
    st.addDouble(longitude.name, isNullable: true);
    st.addBool(synced.name, isNullable: true);
    st.addBool(fromServer.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Availability model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(recordId.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      Availability newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<Availability> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Availability model,
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
            .where(this.recordId.eq(model.recordId))
            .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
        retId = adapter.update(update);
      }
    } else {
      final Upsert upsert = upserter
          .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
          .id(recordId.name);
      retId = await adapter.upsert(upsert);
    }
    if (cascade) {
      Availability newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<Availability> models,
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

  Future<int> update(Availability model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.recordId.eq(model.recordId))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Availability> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(this.recordId.eq(model.recordId));
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<Availability> find(int recordId,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.recordId.eq(recordId));
    return await findOne(find);
  }

  Future<int> remove(int recordId) async {
    final Remove remove = remover.where(this.recordId.eq(recordId));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Availability> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.recordId.eq(model.recordId));
    }
    return adapter.remove(remove);
  }
}
