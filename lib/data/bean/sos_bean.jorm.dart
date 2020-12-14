// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sos_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _SosBean implements Bean<Sos> {
  final id = IntField('id');
  final shopId = IntField('shop_id');
  final shopName = StrField('shop_name');
  final repId = IntField('rep_id');
  final productCategory = StrField('product_category');
  final totalFacings = StrField('total_facings');
  final facings = StrField('facings');
  final totalLength = StrField('total_length');
  final photo = StrField('photo');
  final sosNotes = StrField('sos_notes');
  final entryTime = DateTimeField('entry_time');
  final synced = BoolField('synced');
  final fromServer = BoolField('from_server');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        shopId.name: shopId,
        shopName.name: shopName,
        repId.name: repId,
        productCategory.name: productCategory,
        totalFacings.name: totalFacings,
        facings.name: facings,
        totalLength.name: totalLength,
        photo.name: photo,
        sosNotes.name: sosNotes,
        entryTime.name: entryTime,
        synced.name: synced,
        fromServer.name: fromServer,
      };
  Sos fromMap(Map map) {
    Sos model = Sos();
    model.id = adapter.parseValue(map['id']);
    model.shopId = adapter.parseValue(map['shop_id']);
    model.shopName = adapter.parseValue(map['shop_name']);
    model.repId = adapter.parseValue(map['rep_id']);
    model.productCategory = adapter.parseValue(map['product_category']);
    model.totalFacings = adapter.parseValue(map['total_facings']);
    model.facings = adapter.parseValue(map['facings']);
    model.totalLength = adapter.parseValue(map['total_length']);
    model.photo = adapter.parseValue(map['photo']);
    model.sosNotes = adapter.parseValue(map['sos_notes']);
    model.entryTime = adapter.parseValue(map['entry_time']);
    model.synced = adapter.parseValue(map['synced']);
    model.fromServer = adapter.parseValue(map['from_server']);

    return model;
  }

  List<SetColumn> toSetColumns(Sos model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(shopId.set(model.shopId));
      ret.add(shopName.set(model.shopName));
      ret.add(repId.set(model.repId));
      ret.add(productCategory.set(model.productCategory));
      ret.add(totalFacings.set(model.totalFacings));
      ret.add(facings.set(model.facings));
      ret.add(totalLength.set(model.totalLength));
      ret.add(photo.set(model.photo));
      ret.add(sosNotes.set(model.sosNotes));
      ret.add(entryTime.set(model.entryTime));
      ret.add(synced.set(model.synced));
      ret.add(fromServer.set(model.fromServer));
    } else if (only != null) {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(shopId.name)) ret.add(shopId.set(model.shopId));
      if (only.contains(shopName.name)) ret.add(shopName.set(model.shopName));
      if (only.contains(repId.name)) ret.add(repId.set(model.repId));
      if (only.contains(productCategory.name))
        ret.add(productCategory.set(model.productCategory));
      if (only.contains(totalFacings.name))
        ret.add(totalFacings.set(model.totalFacings));
      if (only.contains(facings.name)) ret.add(facings.set(model.facings));
      if (only.contains(totalLength.name))
        ret.add(totalLength.set(model.totalLength));
      if (only.contains(photo.name)) ret.add(photo.set(model.photo));
      if (only.contains(sosNotes.name)) ret.add(sosNotes.set(model.sosNotes));
      if (only.contains(entryTime.name))
        ret.add(entryTime.set(model.entryTime));
      if (only.contains(synced.name)) ret.add(synced.set(model.synced));
      if (only.contains(fromServer.name))
        ret.add(fromServer.set(model.fromServer));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.shopId != null) {
        ret.add(shopId.set(model.shopId));
      }
      if (model.shopName != null) {
        ret.add(shopName.set(model.shopName));
      }
      if (model.repId != null) {
        ret.add(repId.set(model.repId));
      }
      if (model.productCategory != null) {
        ret.add(productCategory.set(model.productCategory));
      }
      if (model.totalFacings != null) {
        ret.add(totalFacings.set(model.totalFacings));
      }
      if (model.facings != null) {
        ret.add(facings.set(model.facings));
      }
      if (model.totalLength != null) {
        ret.add(totalLength.set(model.totalLength));
      }
      if (model.photo != null) {
        ret.add(photo.set(model.photo));
      }
      if (model.sosNotes != null) {
        ret.add(sosNotes.set(model.sosNotes));
      }
      if (model.entryTime != null) {
        ret.add(entryTime.set(model.entryTime));
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
    st.addInt(shopId.name, isNullable: true);
    st.addStr(shopName.name, isNullable: true);
    st.addInt(repId.name, isNullable: true);
    st.addStr(productCategory.name, isNullable: true);
    st.addStr(totalFacings.name, isNullable: true);
    st.addStr(facings.name, isNullable: true);
    st.addStr(totalLength.name, isNullable: true);
    st.addStr(photo.name, isNullable: true);
    st.addStr(sosNotes.name, isNullable: true);
    st.addDateTime(entryTime.name, isNullable: true);
    st.addBool(synced.name, isNullable: false);
    st.addBool(fromServer.name, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Sos model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      Sos newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<Sos> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Sos model,
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
      Sos newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<Sos> models,
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

  Future<int> update(Sos model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Sos> models,
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

  Future<Sos> find(int id, {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Sos> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
