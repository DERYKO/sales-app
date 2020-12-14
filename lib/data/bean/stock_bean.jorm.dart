// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _StockBean implements Bean<Stock> {
  final id = IntField('id');
  final entryType = StrField('entry_type');
  final supplierId = IntField('supplier_id');
  final salerId = IntField('saler_id');
  final comment = StrField('comment');
  final totalCost = StrField('total_cost');
  final paymentMethod = StrField('payment_method');
  final reference = StrField('reference');
  final entryTime = StrField('entry_time');
  final latitude = StrField('latitude');
  final longitude = StrField('longitude');
  final photo = StrField('photo');
  final synced = BoolField('synced');
  final fromServer = BoolField('from_server');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        entryType.name: entryType,
        supplierId.name: supplierId,
        salerId.name: salerId,
        comment.name: comment,
        totalCost.name: totalCost,
        paymentMethod.name: paymentMethod,
        reference.name: reference,
        entryTime.name: entryTime,
        latitude.name: latitude,
        longitude.name: longitude,
        photo.name: photo,
        synced.name: synced,
        fromServer.name: fromServer,
      };
  Stock fromMap(Map map) {
    Stock model = Stock();
    model.id = adapter.parseValue(map['id']);
    model.entryType = adapter.parseValue(map['entry_type']);
    model.supplierId = adapter.parseValue(map['supplier_id']);
    model.salerId = adapter.parseValue(map['saler_id']);
    model.comment = adapter.parseValue(map['comment']);
    model.totalCost = adapter.parseValue(map['total_cost']);
    model.paymentMethod = adapter.parseValue(map['payment_method']);
    model.reference = adapter.parseValue(map['reference']);
    model.entryTime = adapter.parseValue(map['entry_time']);
    model.latitude = adapter.parseValue(map['latitude']);
    model.longitude = adapter.parseValue(map['longitude']);
    model.photo = adapter.parseValue(map['photo']);
    model.synced = adapter.parseValue(map['synced']);
    model.fromServer = adapter.parseValue(map['from_server']);

    return model;
  }

  List<SetColumn> toSetColumns(Stock model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(entryType.set(model.entryType));
      ret.add(supplierId.set(model.supplierId));
      ret.add(salerId.set(model.salerId));
      ret.add(comment.set(model.comment));
      ret.add(totalCost.set(model.totalCost));
      ret.add(paymentMethod.set(model.paymentMethod));
      ret.add(reference.set(model.reference));
      ret.add(entryTime.set(model.entryTime));
      ret.add(latitude.set(model.latitude));
      ret.add(longitude.set(model.longitude));
      ret.add(photo.set(model.photo));
      ret.add(synced.set(model.synced));
      ret.add(fromServer.set(model.fromServer));
    } else if (only != null) {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(entryType.name))
        ret.add(entryType.set(model.entryType));
      if (only.contains(supplierId.name))
        ret.add(supplierId.set(model.supplierId));
      if (only.contains(salerId.name)) ret.add(salerId.set(model.salerId));
      if (only.contains(comment.name)) ret.add(comment.set(model.comment));
      if (only.contains(totalCost.name))
        ret.add(totalCost.set(model.totalCost));
      if (only.contains(paymentMethod.name))
        ret.add(paymentMethod.set(model.paymentMethod));
      if (only.contains(reference.name))
        ret.add(reference.set(model.reference));
      if (only.contains(entryTime.name))
        ret.add(entryTime.set(model.entryTime));
      if (only.contains(latitude.name)) ret.add(latitude.set(model.latitude));
      if (only.contains(longitude.name))
        ret.add(longitude.set(model.longitude));
      if (only.contains(photo.name)) ret.add(photo.set(model.photo));
      if (only.contains(synced.name)) ret.add(synced.set(model.synced));
      if (only.contains(fromServer.name))
        ret.add(fromServer.set(model.fromServer));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.entryType != null) {
        ret.add(entryType.set(model.entryType));
      }
      if (model.supplierId != null) {
        ret.add(supplierId.set(model.supplierId));
      }
      if (model.salerId != null) {
        ret.add(salerId.set(model.salerId));
      }
      if (model.comment != null) {
        ret.add(comment.set(model.comment));
      }
      if (model.totalCost != null) {
        ret.add(totalCost.set(model.totalCost));
      }
      if (model.paymentMethod != null) {
        ret.add(paymentMethod.set(model.paymentMethod));
      }
      if (model.reference != null) {
        ret.add(reference.set(model.reference));
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
      if (model.photo != null) {
        ret.add(photo.set(model.photo));
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
    st.addStr(entryType.name, isNullable: false);
    st.addInt(supplierId.name, isNullable: false);
    st.addInt(salerId.name, isNullable: false);
    st.addStr(comment.name, isNullable: true);
    st.addStr(totalCost.name, isNullable: false);
    st.addStr(paymentMethod.name, isNullable: false);
    st.addStr(reference.name, isNullable: false);
    st.addStr(entryTime.name, isNullable: false);
    st.addStr(latitude.name, isNullable: false);
    st.addStr(longitude.name, isNullable: false);
    st.addStr(photo.name, isNullable: true);
    st.addBool(synced.name, isNullable: false);
    st.addBool(fromServer.name, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Stock model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      Stock newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<Stock> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Stock model,
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
      Stock newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<Stock> models,
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

  Future<int> update(Stock model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Stock> models,
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

  Future<Stock> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Stock> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
