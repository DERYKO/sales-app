// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skip_record_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _SkipRecordBean implements Bean<SkipRecord> {
  final skipReason = StrField('skip_reason');
  final latitude = DoubleField('latitude');
  final visitId = StrField('visit_id');
  final nextVisitDate = DateTimeField('next_visit_date');
  final callStatus = StrField('call_status');
  final routeId = StrField('route_id');
  final longitude = DoubleField('longitude');
  final skipNotes = StrField('skip_notes');
  final routeType = StrField('route_type');
  final battery = StrField('battery');
  final newShop = IntField('new_shop');
  final orderTime = StrField('order_time');
  final salerId = IntField('saler_id');
  final shopId = IntField('shop_id');
  final fromServer = BoolField('from_server');
  final synced = BoolField('synced');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        skipReason.name: skipReason,
        latitude.name: latitude,
        visitId.name: visitId,
        nextVisitDate.name: nextVisitDate,
        callStatus.name: callStatus,
        routeId.name: routeId,
        longitude.name: longitude,
        skipNotes.name: skipNotes,
        routeType.name: routeType,
        battery.name: battery,
        newShop.name: newShop,
        orderTime.name: orderTime,
        salerId.name: salerId,
        shopId.name: shopId,
        fromServer.name: fromServer,
        synced.name: synced,
      };
  SkipRecord fromMap(Map map) {
    SkipRecord model = SkipRecord();
    model.skipReason = adapter.parseValue(map['skip_reason']);
    model.latitude = adapter.parseValue(map['latitude']);
    model.visitId = adapter.parseValue(map['visit_id']);
    model.nextVisitDate = adapter.parseValue(map['next_visit_date']);
    model.callStatus = adapter.parseValue(map['call_status']);
    model.routeId = adapter.parseValue(map['route_id']);
    model.longitude = adapter.parseValue(map['longitude']);
    model.skipNotes = adapter.parseValue(map['skip_notes']);
    model.routeType = adapter.parseValue(map['route_type']);
    model.battery = adapter.parseValue(map['battery']);
    model.newShop = adapter.parseValue(map['new_shop']);
    model.orderTime = adapter.parseValue(map['order_time']);
    model.salerId = adapter.parseValue(map['saler_id']);
    model.shopId = adapter.parseValue(map['shop_id']);
    model.fromServer = adapter.parseValue(map['from_server']);
    model.synced = adapter.parseValue(map['synced']);

    return model;
  }

  List<SetColumn> toSetColumns(SkipRecord model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(skipReason.set(model.skipReason));
      ret.add(latitude.set(model.latitude));
      ret.add(visitId.set(model.visitId));
      ret.add(nextVisitDate.set(model.nextVisitDate));
      ret.add(callStatus.set(model.callStatus));
      ret.add(routeId.set(model.routeId));
      ret.add(longitude.set(model.longitude));
      ret.add(skipNotes.set(model.skipNotes));
      ret.add(routeType.set(model.routeType));
      ret.add(battery.set(model.battery));
      ret.add(newShop.set(model.newShop));
      ret.add(orderTime.set(model.orderTime));
      ret.add(salerId.set(model.salerId));
      ret.add(shopId.set(model.shopId));
      ret.add(fromServer.set(model.fromServer));
      ret.add(synced.set(model.synced));
    } else if (only != null) {
      if (only.contains(skipReason.name))
        ret.add(skipReason.set(model.skipReason));
      if (only.contains(latitude.name)) ret.add(latitude.set(model.latitude));
      if (only.contains(visitId.name)) ret.add(visitId.set(model.visitId));
      if (only.contains(nextVisitDate.name))
        ret.add(nextVisitDate.set(model.nextVisitDate));
      if (only.contains(callStatus.name))
        ret.add(callStatus.set(model.callStatus));
      if (only.contains(routeId.name)) ret.add(routeId.set(model.routeId));
      if (only.contains(longitude.name))
        ret.add(longitude.set(model.longitude));
      if (only.contains(skipNotes.name))
        ret.add(skipNotes.set(model.skipNotes));
      if (only.contains(routeType.name))
        ret.add(routeType.set(model.routeType));
      if (only.contains(battery.name)) ret.add(battery.set(model.battery));
      if (only.contains(newShop.name)) ret.add(newShop.set(model.newShop));
      if (only.contains(orderTime.name))
        ret.add(orderTime.set(model.orderTime));
      if (only.contains(salerId.name)) ret.add(salerId.set(model.salerId));
      if (only.contains(shopId.name)) ret.add(shopId.set(model.shopId));
      if (only.contains(fromServer.name))
        ret.add(fromServer.set(model.fromServer));
      if (only.contains(synced.name)) ret.add(synced.set(model.synced));
    } else /* if (onlyNonNull) */ {
      if (model.skipReason != null) {
        ret.add(skipReason.set(model.skipReason));
      }
      if (model.latitude != null) {
        ret.add(latitude.set(model.latitude));
      }
      if (model.visitId != null) {
        ret.add(visitId.set(model.visitId));
      }
      if (model.nextVisitDate != null) {
        ret.add(nextVisitDate.set(model.nextVisitDate));
      }
      if (model.callStatus != null) {
        ret.add(callStatus.set(model.callStatus));
      }
      if (model.routeId != null) {
        ret.add(routeId.set(model.routeId));
      }
      if (model.longitude != null) {
        ret.add(longitude.set(model.longitude));
      }
      if (model.skipNotes != null) {
        ret.add(skipNotes.set(model.skipNotes));
      }
      if (model.routeType != null) {
        ret.add(routeType.set(model.routeType));
      }
      if (model.battery != null) {
        ret.add(battery.set(model.battery));
      }
      if (model.newShop != null) {
        ret.add(newShop.set(model.newShop));
      }
      if (model.orderTime != null) {
        ret.add(orderTime.set(model.orderTime));
      }
      if (model.salerId != null) {
        ret.add(salerId.set(model.salerId));
      }
      if (model.shopId != null) {
        ret.add(shopId.set(model.shopId));
      }
      if (model.fromServer != null) {
        ret.add(fromServer.set(model.fromServer));
      }
      if (model.synced != null) {
        ret.add(synced.set(model.synced));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addStr(skipReason.name, isNullable: true);
    st.addDouble(latitude.name, isNullable: true);
    st.addStr(visitId.name, isNullable: true);
    st.addDateTime(nextVisitDate.name, isNullable: true);
    st.addStr(callStatus.name, isNullable: true);
    st.addStr(routeId.name, isNullable: true);
    st.addDouble(longitude.name, isNullable: true);
    st.addStr(skipNotes.name, isNullable: true);
    st.addStr(routeType.name, isNullable: true);
    st.addStr(battery.name, isNullable: true);
    st.addInt(newShop.name, isNullable: true);
    st.addStr(orderTime.name, primary: true, isNullable: false);
    st.addInt(salerId.name, isNullable: true);
    st.addInt(shopId.name, isNullable: true);
    st.addBool(fromServer.name, isNullable: true);
    st.addBool(synced.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(SkipRecord model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<SkipRecord> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(SkipRecord model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<SkipRecord> models,
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

  Future<int> update(SkipRecord model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.orderTime.eq(model.orderTime))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<SkipRecord> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(this.orderTime.eq(model.orderTime));
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<SkipRecord> find(String orderTime,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.orderTime.eq(orderTime));
    return await findOne(find);
  }

  Future<int> remove(String orderTime) async {
    final Remove remove = remover.where(this.orderTime.eq(orderTime));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<SkipRecord> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.orderTime.eq(model.orderTime));
    }
    return adapter.remove(remove);
  }
}
