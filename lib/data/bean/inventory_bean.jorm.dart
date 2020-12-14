// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _InventoryBean implements Bean<Inventory> {
  final quantity = StrField('quantity');
  final productId = IntField('product_id');
  final storeId = IntField('store_id');
  final batchnumber = StrField('batchnumber');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        quantity.name: quantity,
        productId.name: productId,
        storeId.name: storeId,
        batchnumber.name: batchnumber,
      };
  Inventory fromMap(Map map) {
    Inventory model = Inventory();
    model.quantity = adapter.parseValue(map['quantity']);
    model.productId = adapter.parseValue(map['product_id']);
    model.storeId = adapter.parseValue(map['store_id']);
    model.batchnumber = adapter.parseValue(map['batchnumber']);

    return model;
  }

  List<SetColumn> toSetColumns(Inventory model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(quantity.set(model.quantity));
      ret.add(productId.set(model.productId));
      ret.add(storeId.set(model.storeId));
      ret.add(batchnumber.set(model.batchnumber));
    } else if (only != null) {
      if (only.contains(quantity.name)) ret.add(quantity.set(model.quantity));
      if (only.contains(productId.name))
        ret.add(productId.set(model.productId));
      if (only.contains(storeId.name)) ret.add(storeId.set(model.storeId));
      if (only.contains(batchnumber.name))
        ret.add(batchnumber.set(model.batchnumber));
    } else /* if (onlyNonNull) */ {
      if (model.quantity != null) {
        ret.add(quantity.set(model.quantity));
      }
      if (model.productId != null) {
        ret.add(productId.set(model.productId));
      }
      if (model.storeId != null) {
        ret.add(storeId.set(model.storeId));
      }
      if (model.batchnumber != null) {
        ret.add(batchnumber.set(model.batchnumber));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addStr(quantity.name, isNullable: false);
    st.addInt(productId.name, isNullable: false);
    st.addInt(storeId.name, isNullable: false);
    st.addStr(batchnumber.name, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Inventory model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<Inventory> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Inventory model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<Inventory> models,
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

  Future<void> updateMany(List<Inventory> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(null);
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }
}
