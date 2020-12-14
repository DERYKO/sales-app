// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posm_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _PosmBean implements Bean<Posm> {
  final id = IntField('id');
  final shopName = StrField('shop_name');
  final name = StrField('name');
  final shopId = IntField('shop_id');
  final visitId = StrField('visit_id');
  final itemId = IntField('item_id');
  final productName = StrField('product_name');
  final itemname = StrField('itemname');
  final availability = StrField('availability');
  final stocked = StrField('stocked');
  final visibility = StrField('visibility');
  final notes = StrField('notes');
  final entryTime = DateTimeField('entry_time');
  final latitude = DoubleField('latitude');
  final longitude = DoubleField('longitude');
  final synced = BoolField('synced');
  final fromServer = BoolField('from_server');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        shopName.name: shopName,
        name.name: name,
        shopId.name: shopId,
        visitId.name: visitId,
        itemId.name: itemId,
        productName.name: productName,
        itemname.name: itemname,
        availability.name: availability,
        stocked.name: stocked,
        visibility.name: visibility,
        notes.name: notes,
        entryTime.name: entryTime,
        latitude.name: latitude,
        longitude.name: longitude,
        synced.name: synced,
        fromServer.name: fromServer,
      };
  Posm fromMap(Map map) {
    Posm model = Posm();
    model.id = adapter.parseValue(map['id']);
    model.shopName = adapter.parseValue(map['shop_name']);
    model.name = adapter.parseValue(map['name']);
    model.shopId = adapter.parseValue(map['shop_id']);
    model.visitId = adapter.parseValue(map['visit_id']);
    model.itemId = adapter.parseValue(map['item_id']);
    model.productName = adapter.parseValue(map['product_name']);
    model.itemname = adapter.parseValue(map['itemname']);
    model.availability = adapter.parseValue(map['availability']);
    model.stocked = adapter.parseValue(map['stocked']);
    model.visibility = adapter.parseValue(map['visibility']);
    model.notes = adapter.parseValue(map['notes']);
    model.entryTime = adapter.parseValue(map['entry_time']);
    model.latitude = adapter.parseValue(map['latitude']);
    model.longitude = adapter.parseValue(map['longitude']);
    model.synced = adapter.parseValue(map['synced']);
    model.fromServer = adapter.parseValue(map['from_server']);

    return model;
  }

  List<SetColumn> toSetColumns(Posm model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(shopName.set(model.shopName));
      ret.add(name.set(model.name));
      ret.add(shopId.set(model.shopId));
      ret.add(visitId.set(model.visitId));
      ret.add(itemId.set(model.itemId));
      ret.add(productName.set(model.productName));
      ret.add(itemname.set(model.itemname));
      ret.add(availability.set(model.availability));
      ret.add(stocked.set(model.stocked));
      ret.add(visibility.set(model.visibility));
      ret.add(notes.set(model.notes));
      ret.add(entryTime.set(model.entryTime));
      ret.add(latitude.set(model.latitude));
      ret.add(longitude.set(model.longitude));
      ret.add(synced.set(model.synced));
      ret.add(fromServer.set(model.fromServer));
    } else if (only != null) {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(shopName.name)) ret.add(shopName.set(model.shopName));
      if (only.contains(name.name)) ret.add(name.set(model.name));
      if (only.contains(shopId.name)) ret.add(shopId.set(model.shopId));
      if (only.contains(visitId.name)) ret.add(visitId.set(model.visitId));
      if (only.contains(itemId.name)) ret.add(itemId.set(model.itemId));
      if (only.contains(productName.name))
        ret.add(productName.set(model.productName));
      if (only.contains(itemname.name)) ret.add(itemname.set(model.itemname));
      if (only.contains(availability.name))
        ret.add(availability.set(model.availability));
      if (only.contains(stocked.name)) ret.add(stocked.set(model.stocked));
      if (only.contains(visibility.name))
        ret.add(visibility.set(model.visibility));
      if (only.contains(notes.name)) ret.add(notes.set(model.notes));
      if (only.contains(entryTime.name))
        ret.add(entryTime.set(model.entryTime));
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
      if (model.shopName != null) {
        ret.add(shopName.set(model.shopName));
      }
      if (model.name != null) {
        ret.add(name.set(model.name));
      }
      if (model.shopId != null) {
        ret.add(shopId.set(model.shopId));
      }
      if (model.visitId != null) {
        ret.add(visitId.set(model.visitId));
      }
      if (model.itemId != null) {
        ret.add(itemId.set(model.itemId));
      }
      if (model.productName != null) {
        ret.add(productName.set(model.productName));
      }
      if (model.itemname != null) {
        ret.add(itemname.set(model.itemname));
      }
      if (model.availability != null) {
        ret.add(availability.set(model.availability));
      }
      if (model.stocked != null) {
        ret.add(stocked.set(model.stocked));
      }
      if (model.visibility != null) {
        ret.add(visibility.set(model.visibility));
      }
      if (model.notes != null) {
        ret.add(notes.set(model.notes));
      }
      if (model.entryTime != null) {
        ret.add(entryTime.set(model.entryTime));
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
    st.addStr(shopName.name, isNullable: true);
    st.addStr(name.name, isNullable: true);
    st.addInt(shopId.name, isNullable: true);
    st.addStr(visitId.name, isNullable: true);
    st.addInt(itemId.name, isNullable: true);
    st.addStr(productName.name, isNullable: true);
    st.addStr(itemname.name, isNullable: true);
    st.addStr(availability.name, isNullable: true);
    st.addStr(stocked.name, isNullable: true);
    st.addStr(visibility.name, isNullable: true);
    st.addStr(notes.name, isNullable: true);
    st.addDateTime(entryTime.name, isNullable: true);
    st.addDouble(latitude.name, isNullable: true);
    st.addDouble(longitude.name, isNullable: true);
    st.addBool(synced.name, isNullable: true);
    st.addBool(fromServer.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Posm model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      Posm newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<Posm> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Posm model,
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
      Posm newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<Posm> models,
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

  Future<int> update(Posm model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Posm> models,
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

  Future<Posm> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Posm> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
