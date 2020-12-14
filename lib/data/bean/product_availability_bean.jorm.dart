// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_availability_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _ProductAvailabilityBean implements Bean<ProductAvailability> {
  final id = IntField('id');
  final visitid = StrField('visitid');
  final repId = IntField('rep_id');
  final outletId = IntField('outlet_id');
  final latitude = StrField('latitude');
  final longitude = StrField('longitude');
  final entryTime = DateTimeField('entry_time');
  final createdAt = DateTimeField('created_at');
  final updatedAt = DateTimeField('updated_at');
  final fromServer = BoolField('from_server');
  final synced = BoolField('synced');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        visitid.name: visitid,
        repId.name: repId,
        outletId.name: outletId,
        latitude.name: latitude,
        longitude.name: longitude,
        entryTime.name: entryTime,
        createdAt.name: createdAt,
        updatedAt.name: updatedAt,
        fromServer.name: fromServer,
        synced.name: synced,
      };
  ProductAvailability fromMap(Map map) {
    ProductAvailability model = ProductAvailability();
    model.id = adapter.parseValue(map['id']);
    model.visitid = adapter.parseValue(map['visitid']);
    model.repId = adapter.parseValue(map['rep_id']);
    model.outletId = adapter.parseValue(map['outlet_id']);
    model.latitude = adapter.parseValue(map['latitude']);
    model.longitude = adapter.parseValue(map['longitude']);
    model.entryTime = adapter.parseValue(map['entry_time']);
    model.createdAt = adapter.parseValue(map['created_at']);
    model.updatedAt = adapter.parseValue(map['updated_at']);
    model.fromServer = adapter.parseValue(map['from_server']);
    model.synced = adapter.parseValue(map['synced']);

    return model;
  }

  List<SetColumn> toSetColumns(ProductAvailability model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(visitid.set(model.visitid));
      ret.add(repId.set(model.repId));
      ret.add(outletId.set(model.outletId));
      ret.add(latitude.set(model.latitude));
      ret.add(longitude.set(model.longitude));
      ret.add(entryTime.set(model.entryTime));
      ret.add(createdAt.set(model.createdAt));
      ret.add(updatedAt.set(model.updatedAt));
      ret.add(fromServer.set(model.fromServer));
      ret.add(synced.set(model.synced));
    } else if (only != null) {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(visitid.name)) ret.add(visitid.set(model.visitid));
      if (only.contains(repId.name)) ret.add(repId.set(model.repId));
      if (only.contains(outletId.name)) ret.add(outletId.set(model.outletId));
      if (only.contains(latitude.name)) ret.add(latitude.set(model.latitude));
      if (only.contains(longitude.name))
        ret.add(longitude.set(model.longitude));
      if (only.contains(entryTime.name))
        ret.add(entryTime.set(model.entryTime));
      if (only.contains(createdAt.name))
        ret.add(createdAt.set(model.createdAt));
      if (only.contains(updatedAt.name))
        ret.add(updatedAt.set(model.updatedAt));
      if (only.contains(fromServer.name))
        ret.add(fromServer.set(model.fromServer));
      if (only.contains(synced.name)) ret.add(synced.set(model.synced));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.visitid != null) {
        ret.add(visitid.set(model.visitid));
      }
      if (model.repId != null) {
        ret.add(repId.set(model.repId));
      }
      if (model.outletId != null) {
        ret.add(outletId.set(model.outletId));
      }
      if (model.latitude != null) {
        ret.add(latitude.set(model.latitude));
      }
      if (model.longitude != null) {
        ret.add(longitude.set(model.longitude));
      }
      if (model.entryTime != null) {
        ret.add(entryTime.set(model.entryTime));
      }
      if (model.createdAt != null) {
        ret.add(createdAt.set(model.createdAt));
      }
      if (model.updatedAt != null) {
        ret.add(updatedAt.set(model.updatedAt));
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
    st.addInt(id.name, primary: true, autoIncrement: true, isNullable: false);
    st.addStr(visitid.name, isNullable: true);
    st.addInt(repId.name, isNullable: true);
    st.addInt(outletId.name, isNullable: true);
    st.addStr(latitude.name, isNullable: true);
    st.addStr(longitude.name, isNullable: true);
    st.addDateTime(entryTime.name, isNullable: true);
    st.addDateTime(createdAt.name, isNullable: true);
    st.addDateTime(updatedAt.name, isNullable: true);
    st.addBool(fromServer.name, isNullable: true);
    st.addBool(synced.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(ProductAvailability model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      ProductAvailability newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<ProductAvailability> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(ProductAvailability model,
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
      ProductAvailability newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<ProductAvailability> models,
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

  Future<int> update(ProductAvailability model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<ProductAvailability> models,
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

  Future<ProductAvailability> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<ProductAvailability> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
