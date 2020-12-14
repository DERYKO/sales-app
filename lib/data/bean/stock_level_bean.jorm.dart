// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_level_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _StockLevelBean implements Bean<StockLevel> {
  final productId = IntField('product_id');
  final storeId = IntField('store_id');
  final category = StrField('category');
  final productName = StrField('product_name');
  final quantity = StrField('quantity');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        productId.name: productId,
        storeId.name: storeId,
        category.name: category,
        productName.name: productName,
        quantity.name: quantity,
      };
  StockLevel fromMap(Map map) {
    StockLevel model = StockLevel();
    model.productId = adapter.parseValue(map['product_id']);
    model.storeId = adapter.parseValue(map['store_id']);
    model.category = adapter.parseValue(map['category']);
    model.productName = adapter.parseValue(map['product_name']);
    model.quantity = adapter.parseValue(map['quantity']);

    return model;
  }

  List<SetColumn> toSetColumns(StockLevel model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(productId.set(model.productId));
      ret.add(storeId.set(model.storeId));
      ret.add(category.set(model.category));
      ret.add(productName.set(model.productName));
      ret.add(quantity.set(model.quantity));
    } else if (only != null) {
      if (only.contains(productId.name))
        ret.add(productId.set(model.productId));
      if (only.contains(storeId.name)) ret.add(storeId.set(model.storeId));
      if (only.contains(category.name)) ret.add(category.set(model.category));
      if (only.contains(productName.name))
        ret.add(productName.set(model.productName));
      if (only.contains(quantity.name)) ret.add(quantity.set(model.quantity));
    } else /* if (onlyNonNull) */ {
      if (model.productId != null) {
        ret.add(productId.set(model.productId));
      }
      if (model.storeId != null) {
        ret.add(storeId.set(model.storeId));
      }
      if (model.category != null) {
        ret.add(category.set(model.category));
      }
      if (model.productName != null) {
        ret.add(productName.set(model.productName));
      }
      if (model.quantity != null) {
        ret.add(quantity.set(model.quantity));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(productId.name, isNullable: false);
    st.addInt(storeId.name, isNullable: false);
    st.addStr(category.name, isNullable: false);
    st.addStr(productName.name, isNullable: false);
    st.addStr(quantity.name, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(StockLevel model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<StockLevel> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(StockLevel model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<StockLevel> models,
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

  Future<void> updateMany(List<StockLevel> models,
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
