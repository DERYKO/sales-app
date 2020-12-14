// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sod_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _SodBean implements Bean<Sod> {
  final id = IntField('id');
  final repId = IntField('rep_id');
  final shopId = IntField('shop_id');
  final brand = StrField('brand');
  final competitor = StrField('competitor');
  final displayType = StrField('display_type');
  final quantity = IntField('quantity');
  final photo = StrField('photo');
  final notes = StrField('notes');
  final visitid = StrField('visitid');
  final latitude = StrField('latitude');
  final longitude = StrField('longitude');
  final entryTime = DateTimeField('entry_time');
  final createdAt = DateTimeField('created_at');
  final updatedAt = DateTimeField('updated_at');
  final synced = BoolField('synced');
  final fromServer = BoolField('from_server');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        repId.name: repId,
        shopId.name: shopId,
        brand.name: brand,
        competitor.name: competitor,
        displayType.name: displayType,
        quantity.name: quantity,
        photo.name: photo,
        notes.name: notes,
        visitid.name: visitid,
        latitude.name: latitude,
        longitude.name: longitude,
        entryTime.name: entryTime,
        createdAt.name: createdAt,
        updatedAt.name: updatedAt,
        synced.name: synced,
        fromServer.name: fromServer,
      };
  Sod fromMap(Map map) {
    Sod model = Sod();
    model.id = adapter.parseValue(map['id']);
    model.repId = adapter.parseValue(map['rep_id']);
    model.shopId = adapter.parseValue(map['shop_id']);
    model.brand = adapter.parseValue(map['brand']);
    model.competitor = adapter.parseValue(map['competitor']);
    model.displayType = adapter.parseValue(map['display_type']);
    model.quantity = adapter.parseValue(map['quantity']);
    model.photo = adapter.parseValue(map['photo']);
    model.notes = adapter.parseValue(map['notes']);
    model.visitid = adapter.parseValue(map['visitid']);
    model.latitude = adapter.parseValue(map['latitude']);
    model.longitude = adapter.parseValue(map['longitude']);
    model.entryTime = adapter.parseValue(map['entry_time']);
    model.createdAt = adapter.parseValue(map['created_at']);
    model.updatedAt = adapter.parseValue(map['updated_at']);
    model.synced = adapter.parseValue(map['synced']);
    model.fromServer = adapter.parseValue(map['from_server']);

    return model;
  }

  List<SetColumn> toSetColumns(Sod model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(repId.set(model.repId));
      ret.add(shopId.set(model.shopId));
      ret.add(brand.set(model.brand));
      ret.add(competitor.set(model.competitor));
      ret.add(displayType.set(model.displayType));
      ret.add(quantity.set(model.quantity));
      ret.add(photo.set(model.photo));
      ret.add(notes.set(model.notes));
      ret.add(visitid.set(model.visitid));
      ret.add(latitude.set(model.latitude));
      ret.add(longitude.set(model.longitude));
      ret.add(entryTime.set(model.entryTime));
      ret.add(createdAt.set(model.createdAt));
      ret.add(updatedAt.set(model.updatedAt));
      ret.add(synced.set(model.synced));
      ret.add(fromServer.set(model.fromServer));
    } else if (only != null) {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(repId.name)) ret.add(repId.set(model.repId));
      if (only.contains(shopId.name)) ret.add(shopId.set(model.shopId));
      if (only.contains(brand.name)) ret.add(brand.set(model.brand));
      if (only.contains(competitor.name))
        ret.add(competitor.set(model.competitor));
      if (only.contains(displayType.name))
        ret.add(displayType.set(model.displayType));
      if (only.contains(quantity.name)) ret.add(quantity.set(model.quantity));
      if (only.contains(photo.name)) ret.add(photo.set(model.photo));
      if (only.contains(notes.name)) ret.add(notes.set(model.notes));
      if (only.contains(visitid.name)) ret.add(visitid.set(model.visitid));
      if (only.contains(latitude.name)) ret.add(latitude.set(model.latitude));
      if (only.contains(longitude.name))
        ret.add(longitude.set(model.longitude));
      if (only.contains(entryTime.name))
        ret.add(entryTime.set(model.entryTime));
      if (only.contains(createdAt.name))
        ret.add(createdAt.set(model.createdAt));
      if (only.contains(updatedAt.name))
        ret.add(updatedAt.set(model.updatedAt));
      if (only.contains(synced.name)) ret.add(synced.set(model.synced));
      if (only.contains(fromServer.name))
        ret.add(fromServer.set(model.fromServer));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.repId != null) {
        ret.add(repId.set(model.repId));
      }
      if (model.shopId != null) {
        ret.add(shopId.set(model.shopId));
      }
      if (model.brand != null) {
        ret.add(brand.set(model.brand));
      }
      if (model.competitor != null) {
        ret.add(competitor.set(model.competitor));
      }
      if (model.displayType != null) {
        ret.add(displayType.set(model.displayType));
      }
      if (model.quantity != null) {
        ret.add(quantity.set(model.quantity));
      }
      if (model.photo != null) {
        ret.add(photo.set(model.photo));
      }
      if (model.notes != null) {
        ret.add(notes.set(model.notes));
      }
      if (model.visitid != null) {
        ret.add(visitid.set(model.visitid));
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
    st.addInt(repId.name, isNullable: true);
    st.addInt(shopId.name, isNullable: true);
    st.addStr(brand.name, isNullable: true);
    st.addStr(competitor.name, isNullable: true);
    st.addStr(displayType.name, isNullable: true);
    st.addInt(quantity.name, isNullable: true);
    st.addStr(photo.name, isNullable: true);
    st.addStr(notes.name, isNullable: true);
    st.addStr(visitid.name, isNullable: true);
    st.addStr(latitude.name, isNullable: true);
    st.addStr(longitude.name, isNullable: true);
    st.addDateTime(entryTime.name, isNullable: true);
    st.addDateTime(createdAt.name, isNullable: true);
    st.addDateTime(updatedAt.name, isNullable: true);
    st.addBool(synced.name, isNullable: false);
    st.addBool(fromServer.name, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Sod model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      Sod newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<Sod> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Sod model,
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
      Sod newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<Sod> models,
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

  Future<int> update(Sod model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Sod> models,
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

  Future<Sod> find(int id, {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Sod> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
