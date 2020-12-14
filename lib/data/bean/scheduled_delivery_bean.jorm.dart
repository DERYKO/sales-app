// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_delivery_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _ScheduledDeliveryBean implements Bean<ScheduledDelivery> {
  final id = IntField('id');
  final scheduledTime = DateTimeField('scheduled_time');
  final dispatchTime = DateTimeField('dispatch_time');
  final dispatchLat = StrField('dispatch_lat');
  final dispatchLon = StrField('dispatch_lon');
  final returnTime = DateTimeField('return_time');
  final returnLat = StrField('return_lat');
  final returnLon = StrField('return_lon');
  final syncedStart = BoolField('synced_start');
  final syncedEnd = BoolField('synced_end');
  final fromServer = BoolField('from_server');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        scheduledTime.name: scheduledTime,
        dispatchTime.name: dispatchTime,
        dispatchLat.name: dispatchLat,
        dispatchLon.name: dispatchLon,
        returnTime.name: returnTime,
        returnLat.name: returnLat,
        returnLon.name: returnLon,
        syncedStart.name: syncedStart,
        syncedEnd.name: syncedEnd,
        fromServer.name: fromServer,
      };
  ScheduledDelivery fromMap(Map map) {
    ScheduledDelivery model = ScheduledDelivery();
    model.id = adapter.parseValue(map['id']);
    model.scheduledTime = adapter.parseValue(map['scheduled_time']);
    model.dispatchTime = adapter.parseValue(map['dispatch_time']);
    model.dispatchLat = adapter.parseValue(map['dispatch_lat']);
    model.dispatchLon = adapter.parseValue(map['dispatch_lon']);
    model.returnTime = adapter.parseValue(map['return_time']);
    model.returnLat = adapter.parseValue(map['return_lat']);
    model.returnLon = adapter.parseValue(map['return_lon']);
    model.syncedStart = adapter.parseValue(map['synced_start']);
    model.syncedEnd = adapter.parseValue(map['synced_end']);
    model.fromServer = adapter.parseValue(map['from_server']);

    return model;
  }

  List<SetColumn> toSetColumns(ScheduledDelivery model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(scheduledTime.set(model.scheduledTime));
      ret.add(dispatchTime.set(model.dispatchTime));
      ret.add(dispatchLat.set(model.dispatchLat));
      ret.add(dispatchLon.set(model.dispatchLon));
      ret.add(returnTime.set(model.returnTime));
      ret.add(returnLat.set(model.returnLat));
      ret.add(returnLon.set(model.returnLon));
      ret.add(syncedStart.set(model.syncedStart));
      ret.add(syncedEnd.set(model.syncedEnd));
      ret.add(fromServer.set(model.fromServer));
    } else if (only != null) {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(scheduledTime.name))
        ret.add(scheduledTime.set(model.scheduledTime));
      if (only.contains(dispatchTime.name))
        ret.add(dispatchTime.set(model.dispatchTime));
      if (only.contains(dispatchLat.name))
        ret.add(dispatchLat.set(model.dispatchLat));
      if (only.contains(dispatchLon.name))
        ret.add(dispatchLon.set(model.dispatchLon));
      if (only.contains(returnTime.name))
        ret.add(returnTime.set(model.returnTime));
      if (only.contains(returnLat.name))
        ret.add(returnLat.set(model.returnLat));
      if (only.contains(returnLon.name))
        ret.add(returnLon.set(model.returnLon));
      if (only.contains(syncedStart.name))
        ret.add(syncedStart.set(model.syncedStart));
      if (only.contains(syncedEnd.name))
        ret.add(syncedEnd.set(model.syncedEnd));
      if (only.contains(fromServer.name))
        ret.add(fromServer.set(model.fromServer));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.scheduledTime != null) {
        ret.add(scheduledTime.set(model.scheduledTime));
      }
      if (model.dispatchTime != null) {
        ret.add(dispatchTime.set(model.dispatchTime));
      }
      if (model.dispatchLat != null) {
        ret.add(dispatchLat.set(model.dispatchLat));
      }
      if (model.dispatchLon != null) {
        ret.add(dispatchLon.set(model.dispatchLon));
      }
      if (model.returnTime != null) {
        ret.add(returnTime.set(model.returnTime));
      }
      if (model.returnLat != null) {
        ret.add(returnLat.set(model.returnLat));
      }
      if (model.returnLon != null) {
        ret.add(returnLon.set(model.returnLon));
      }
      if (model.syncedStart != null) {
        ret.add(syncedStart.set(model.syncedStart));
      }
      if (model.syncedEnd != null) {
        ret.add(syncedEnd.set(model.syncedEnd));
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
    st.addDateTime(scheduledTime.name, isNullable: true);
    st.addDateTime(dispatchTime.name, isNullable: true);
    st.addStr(dispatchLat.name, isNullable: true);
    st.addStr(dispatchLon.name, isNullable: true);
    st.addDateTime(returnTime.name, isNullable: true);
    st.addStr(returnLat.name, isNullable: true);
    st.addStr(returnLon.name, isNullable: true);
    st.addBool(syncedStart.name, isNullable: false);
    st.addBool(syncedEnd.name, isNullable: false);
    st.addBool(fromServer.name, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(ScheduledDelivery model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      ScheduledDelivery newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<ScheduledDelivery> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(ScheduledDelivery model,
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
      ScheduledDelivery newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<ScheduledDelivery> models,
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

  Future<int> update(ScheduledDelivery model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<ScheduledDelivery> models,
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

  Future<ScheduledDelivery> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<ScheduledDelivery> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
