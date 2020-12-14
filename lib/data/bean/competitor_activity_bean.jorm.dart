// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitor_activity_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _CompetitorActivityBean implements Bean<CompetitorActivity> {
  final id = IntField('id');
  final salerId = IntField('saler_id');
  final shopId = IntField('shop_id');
  final productName = StrField('product_name');
  final productSku = StrField('product_sku');
  final companyId = IntField('company_id');
  final mechanism = StrField('mechanism');
  final beforeValue = StrField('before_value');
  final afterValue = StrField('after_value');
  final competitor = StrField('competitor');
  final visitId = StrField('visit_id');
  final notes = StrField('notes');
  final photo = StrField('photo');
  final csku = IntField('csku');
  final entryTime = DateTimeField('entry_time');
  final latitude = StrField('latitude');
  final longitude = StrField('longitude');
  final createdAt = DateTimeField('created_at');
  final updatedAt = DateTimeField('updated_at');
  final synced = BoolField('synced');
  final fromServer = BoolField('from_server');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        salerId.name: salerId,
        shopId.name: shopId,
        productName.name: productName,
        productSku.name: productSku,
        companyId.name: companyId,
        mechanism.name: mechanism,
        beforeValue.name: beforeValue,
        afterValue.name: afterValue,
        competitor.name: competitor,
        visitId.name: visitId,
        notes.name: notes,
        photo.name: photo,
        csku.name: csku,
        entryTime.name: entryTime,
        latitude.name: latitude,
        longitude.name: longitude,
        createdAt.name: createdAt,
        updatedAt.name: updatedAt,
        synced.name: synced,
        fromServer.name: fromServer,
      };
  CompetitorActivity fromMap(Map map) {
    CompetitorActivity model = CompetitorActivity();
    model.id = adapter.parseValue(map['id']);
    model.salerId = adapter.parseValue(map['saler_id']);
    model.shopId = adapter.parseValue(map['shop_id']);
    model.productName = adapter.parseValue(map['product_name']);
    model.productSku = adapter.parseValue(map['product_sku']);
    model.companyId = adapter.parseValue(map['company_id']);
    model.mechanism = adapter.parseValue(map['mechanism']);
    model.beforeValue = adapter.parseValue(map['before_value']);
    model.afterValue = adapter.parseValue(map['after_value']);
    model.competitor = adapter.parseValue(map['competitor']);
    model.visitId = adapter.parseValue(map['visit_id']);
    model.notes = adapter.parseValue(map['notes']);
    model.photo = adapter.parseValue(map['photo']);
    model.csku = adapter.parseValue(map['csku']);
    model.entryTime = adapter.parseValue(map['entry_time']);
    model.latitude = adapter.parseValue(map['latitude']);
    model.longitude = adapter.parseValue(map['longitude']);
    model.createdAt = adapter.parseValue(map['created_at']);
    model.updatedAt = adapter.parseValue(map['updated_at']);
    model.synced = adapter.parseValue(map['synced']);
    model.fromServer = adapter.parseValue(map['from_server']);

    return model;
  }

  List<SetColumn> toSetColumns(CompetitorActivity model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(salerId.set(model.salerId));
      ret.add(shopId.set(model.shopId));
      ret.add(productName.set(model.productName));
      ret.add(productSku.set(model.productSku));
      ret.add(companyId.set(model.companyId));
      ret.add(mechanism.set(model.mechanism));
      ret.add(beforeValue.set(model.beforeValue));
      ret.add(afterValue.set(model.afterValue));
      ret.add(competitor.set(model.competitor));
      ret.add(visitId.set(model.visitId));
      ret.add(notes.set(model.notes));
      ret.add(photo.set(model.photo));
      ret.add(csku.set(model.csku));
      ret.add(entryTime.set(model.entryTime));
      ret.add(latitude.set(model.latitude));
      ret.add(longitude.set(model.longitude));
      ret.add(createdAt.set(model.createdAt));
      ret.add(updatedAt.set(model.updatedAt));
      ret.add(synced.set(model.synced));
      ret.add(fromServer.set(model.fromServer));
    } else if (only != null) {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(salerId.name)) ret.add(salerId.set(model.salerId));
      if (only.contains(shopId.name)) ret.add(shopId.set(model.shopId));
      if (only.contains(productName.name))
        ret.add(productName.set(model.productName));
      if (only.contains(productSku.name))
        ret.add(productSku.set(model.productSku));
      if (only.contains(companyId.name))
        ret.add(companyId.set(model.companyId));
      if (only.contains(mechanism.name))
        ret.add(mechanism.set(model.mechanism));
      if (only.contains(beforeValue.name))
        ret.add(beforeValue.set(model.beforeValue));
      if (only.contains(afterValue.name))
        ret.add(afterValue.set(model.afterValue));
      if (only.contains(competitor.name))
        ret.add(competitor.set(model.competitor));
      if (only.contains(visitId.name)) ret.add(visitId.set(model.visitId));
      if (only.contains(notes.name)) ret.add(notes.set(model.notes));
      if (only.contains(photo.name)) ret.add(photo.set(model.photo));
      if (only.contains(csku.name)) ret.add(csku.set(model.csku));
      if (only.contains(entryTime.name))
        ret.add(entryTime.set(model.entryTime));
      if (only.contains(latitude.name)) ret.add(latitude.set(model.latitude));
      if (only.contains(longitude.name))
        ret.add(longitude.set(model.longitude));
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
      if (model.salerId != null) {
        ret.add(salerId.set(model.salerId));
      }
      if (model.shopId != null) {
        ret.add(shopId.set(model.shopId));
      }
      if (model.productName != null) {
        ret.add(productName.set(model.productName));
      }
      if (model.productSku != null) {
        ret.add(productSku.set(model.productSku));
      }
      if (model.companyId != null) {
        ret.add(companyId.set(model.companyId));
      }
      if (model.mechanism != null) {
        ret.add(mechanism.set(model.mechanism));
      }
      if (model.beforeValue != null) {
        ret.add(beforeValue.set(model.beforeValue));
      }
      if (model.afterValue != null) {
        ret.add(afterValue.set(model.afterValue));
      }
      if (model.competitor != null) {
        ret.add(competitor.set(model.competitor));
      }
      if (model.visitId != null) {
        ret.add(visitId.set(model.visitId));
      }
      if (model.notes != null) {
        ret.add(notes.set(model.notes));
      }
      if (model.photo != null) {
        ret.add(photo.set(model.photo));
      }
      if (model.csku != null) {
        ret.add(csku.set(model.csku));
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
    st.addInt(salerId.name, isNullable: true);
    st.addInt(shopId.name, isNullable: true);
    st.addStr(productName.name, isNullable: true);
    st.addStr(productSku.name, isNullable: true);
    st.addInt(companyId.name, isNullable: true);
    st.addStr(mechanism.name, isNullable: true);
    st.addStr(beforeValue.name, isNullable: true);
    st.addStr(afterValue.name, isNullable: true);
    st.addStr(competitor.name, isNullable: true);
    st.addStr(visitId.name, isNullable: true);
    st.addStr(notes.name, isNullable: true);
    st.addStr(photo.name, isNullable: true);
    st.addInt(csku.name, isNullable: true);
    st.addDateTime(entryTime.name, isNullable: true);
    st.addStr(latitude.name, isNullable: true);
    st.addStr(longitude.name, isNullable: true);
    st.addDateTime(createdAt.name, isNullable: true);
    st.addDateTime(updatedAt.name, isNullable: true);
    st.addBool(synced.name, isNullable: false);
    st.addBool(fromServer.name, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(CompetitorActivity model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      CompetitorActivity newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<CompetitorActivity> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(CompetitorActivity model,
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
      CompetitorActivity newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<CompetitorActivity> models,
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

  Future<int> update(CompetitorActivity model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<CompetitorActivity> models,
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

  Future<CompetitorActivity> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<CompetitorActivity> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
