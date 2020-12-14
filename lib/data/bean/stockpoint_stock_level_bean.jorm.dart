// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stockpoint_stock_level_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _StockpointStockLevelBean implements Bean<StockpointStockLevel> {
  final productId = IntField('product_id');
  final storeId = IntField('store_id');
  final category = StrField('category');
  final productDesc = StrField('product_desc');
  final quantity = StrField('quantity');
  final batchnumber = StrField('batchnumber');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        productId.name: productId,
        storeId.name: storeId,
        category.name: category,
        productDesc.name: productDesc,
        quantity.name: quantity,
        batchnumber.name: batchnumber,
      };
  StockpointStockLevel fromMap(Map map) {
    StockpointStockLevel model = StockpointStockLevel();
    model.productId = adapter.parseValue(map['product_id']);
    model.storeId = adapter.parseValue(map['store_id']);
    model.category = adapter.parseValue(map['category']);
    model.productDesc = adapter.parseValue(map['product_desc']);
    model.quantity = adapter.parseValue(map['quantity']);
    model.batchnumber = adapter.parseValue(map['batchnumber']);

    return model;
  }

  List<SetColumn> toSetColumns(StockpointStockLevel model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(productId.set(model.productId));
      ret.add(storeId.set(model.storeId));
      ret.add(category.set(model.category));
      ret.add(productDesc.set(model.productDesc));
      ret.add(quantity.set(model.quantity));
      ret.add(batchnumber.set(model.batchnumber));
    } else if (only != null) {
      if (only.contains(productId.name))
        ret.add(productId.set(model.productId));
      if (only.contains(storeId.name)) ret.add(storeId.set(model.storeId));
      if (only.contains(category.name)) ret.add(category.set(model.category));
      if (only.contains(productDesc.name))
        ret.add(productDesc.set(model.productDesc));
      if (only.contains(quantity.name)) ret.add(quantity.set(model.quantity));
      if (only.contains(batchnumber.name))
        ret.add(batchnumber.set(model.batchnumber));
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
      if (model.productDesc != null) {
        ret.add(productDesc.set(model.productDesc));
      }
      if (model.quantity != null) {
        ret.add(quantity.set(model.quantity));
      }
      if (model.batchnumber != null) {
        ret.add(batchnumber.set(model.batchnumber));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(productId.name, primary: true, isNullable: false);
    st.addInt(storeId.name, isNullable: true);
    st.addStr(category.name, isNullable: true);
    st.addStr(productDesc.name, isNullable: true);
    st.addStr(quantity.name, isNullable: true);
    st.addStr(batchnumber.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(StockpointStockLevel model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<StockpointStockLevel> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(StockpointStockLevel model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<StockpointStockLevel> models,
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

  Future<int> update(StockpointStockLevel model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.productId.eq(model.productId))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<StockpointStockLevel> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(this.productId.eq(model.productId));
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<StockpointStockLevel> find(int productId,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.productId.eq(productId));
    return await findOne(find);
  }

  Future<int> remove(int productId) async {
    final Remove remove = remover.where(this.productId.eq(productId));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<StockpointStockLevel> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.productId.eq(model.productId));
    }
    return adapter.remove(remove);
  }
}
