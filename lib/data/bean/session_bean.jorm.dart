// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _SessionBean implements Bean<Session> {
  final sessionId = StrField('session_id');
  final batteryLevel = IntField('battery_level');
  final photo = StrField('photo');
  final customerId = IntField('customer_id');
  final startTime = DateTimeField('start_time');
  final endTime = DateTimeField('end_time');
  final latitude = DoubleField('latitude');
  final longitude = DoubleField('longitude');
  final syncedStart = BoolField('synced_start');
  final syncedEnd = BoolField('synced_end');
  final fromServer = BoolField('from_server');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        sessionId.name: sessionId,
        batteryLevel.name: batteryLevel,
        photo.name: photo,
        customerId.name: customerId,
        startTime.name: startTime,
        endTime.name: endTime,
        latitude.name: latitude,
        longitude.name: longitude,
        syncedStart.name: syncedStart,
        syncedEnd.name: syncedEnd,
        fromServer.name: fromServer,
      };
  Session fromMap(Map map) {
    Session model = Session();
    model.sessionId = adapter.parseValue(map['session_id']);
    model.batteryLevel = adapter.parseValue(map['battery_level']);
    model.photo = adapter.parseValue(map['photo']);
    model.customerId = adapter.parseValue(map['customer_id']);
    model.startTime = adapter.parseValue(map['start_time']);
    model.endTime = adapter.parseValue(map['end_time']);
    model.latitude = adapter.parseValue(map['latitude']);
    model.longitude = adapter.parseValue(map['longitude']);
    model.syncedStart = adapter.parseValue(map['synced_start']);
    model.syncedEnd = adapter.parseValue(map['synced_end']);
    model.fromServer = adapter.parseValue(map['from_server']);

    return model;
  }

  List<SetColumn> toSetColumns(Session model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(sessionId.set(model.sessionId));
      ret.add(batteryLevel.set(model.batteryLevel));
      ret.add(photo.set(model.photo));
      ret.add(customerId.set(model.customerId));
      ret.add(startTime.set(model.startTime));
      ret.add(endTime.set(model.endTime));
      ret.add(latitude.set(model.latitude));
      ret.add(longitude.set(model.longitude));
      ret.add(syncedStart.set(model.syncedStart));
      ret.add(syncedEnd.set(model.syncedEnd));
      ret.add(fromServer.set(model.fromServer));
    } else if (only != null) {
      if (only.contains(sessionId.name))
        ret.add(sessionId.set(model.sessionId));
      if (only.contains(batteryLevel.name))
        ret.add(batteryLevel.set(model.batteryLevel));
      if (only.contains(photo.name)) ret.add(photo.set(model.photo));
      if (only.contains(customerId.name))
        ret.add(customerId.set(model.customerId));
      if (only.contains(startTime.name))
        ret.add(startTime.set(model.startTime));
      if (only.contains(endTime.name)) ret.add(endTime.set(model.endTime));
      if (only.contains(latitude.name)) ret.add(latitude.set(model.latitude));
      if (only.contains(longitude.name))
        ret.add(longitude.set(model.longitude));
      if (only.contains(syncedStart.name))
        ret.add(syncedStart.set(model.syncedStart));
      if (only.contains(syncedEnd.name))
        ret.add(syncedEnd.set(model.syncedEnd));
      if (only.contains(fromServer.name))
        ret.add(fromServer.set(model.fromServer));
    } else /* if (onlyNonNull) */ {
      if (model.sessionId != null) {
        ret.add(sessionId.set(model.sessionId));
      }
      if (model.batteryLevel != null) {
        ret.add(batteryLevel.set(model.batteryLevel));
      }
      if (model.photo != null) {
        ret.add(photo.set(model.photo));
      }
      if (model.customerId != null) {
        ret.add(customerId.set(model.customerId));
      }
      if (model.startTime != null) {
        ret.add(startTime.set(model.startTime));
      }
      if (model.endTime != null) {
        ret.add(endTime.set(model.endTime));
      }
      if (model.latitude != null) {
        ret.add(latitude.set(model.latitude));
      }
      if (model.longitude != null) {
        ret.add(longitude.set(model.longitude));
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
    st.addStr(sessionId.name, primary: true, isNullable: false);
    st.addInt(batteryLevel.name, isNullable: true);
    st.addStr(photo.name, isNullable: true);
    st.addInt(customerId.name, isNullable: true);
    st.addDateTime(startTime.name, isNullable: true);
    st.addDateTime(endTime.name, isNullable: true);
    st.addDouble(latitude.name, isNullable: true);
    st.addDouble(longitude.name, isNullable: true);
    st.addBool(syncedStart.name, isNullable: true);
    st.addBool(syncedEnd.name, isNullable: true);
    st.addBool(fromServer.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Session model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<Session> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Session model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<Session> models,
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

  Future<int> update(Session model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.sessionId.eq(model.sessionId))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Session> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(this.sessionId.eq(model.sessionId));
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<Session> find(String sessionId,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.sessionId.eq(sessionId));
    return await findOne(find);
  }

  Future<int> remove(String sessionId) async {
    final Remove remove = remover.where(this.sessionId.eq(sessionId));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Session> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.sessionId.eq(model.sessionId));
    }
    return adapter.remove(remove);
  }
}
