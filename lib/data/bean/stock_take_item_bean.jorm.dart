// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_take_item_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _StockTakeItemBean implements Bean<StockTakeItem> {
  final stockTakeId = IntField('stock_take_id');
  final productId = IntField('product_id');
  final quantity = IntField('quantity');
  final packaging = StrField('packaging');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        stockTakeId.name: stockTakeId,
        productId.name: productId,
        quantity.name: quantity,
        packaging.name: packaging,
      };
  StockTakeItem fromMap(Map map) {
    StockTakeItem model = StockTakeItem();
    model.stockTakeId = adapter.parseValue(map['stock_take_id']);
    model.productId = adapter.parseValue(map['product_id']);
    model.quantity = adapter.parseValue(map['quantity']);
    model.packaging = adapter.parseValue(map['packaging']);

    return model;
  }

  List<SetColumn> toSetColumns(StockTakeItem model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(stockTakeId.set(model.stockTakeId));
      ret.add(productId.set(model.productId));
      ret.add(quantity.set(model.quantity));
      ret.add(packaging.set(model.packaging));
    } else if (only != null) {
      if (only.contains(stockTakeId.name))
        ret.add(stockTakeId.set(model.stockTakeId));
      if (only.contains(productId.name))
        ret.add(productId.set(model.productId));
      if (only.contains(quantity.name)) ret.add(quantity.set(model.quantity));
      if (only.contains(packaging.name))
        ret.add(packaging.set(model.packaging));
    } else /* if (onlyNonNull) */ {
      if (model.stockTakeId != null) {
        ret.add(stockTakeId.set(model.stockTakeId));
      }
      if (model.productId != null) {
        ret.add(productId.set(model.productId));
      }
      if (model.quantity != null) {
        ret.add(quantity.set(model.quantity));
      }
      if (model.packaging != null) {
        ret.add(packaging.set(model.packaging));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(stockTakeId.name, isNullable: true);
    st.addInt(productId.name, isNullable: true);
    st.addInt(quantity.name, isNullable: true);
    st.addStr(packaging.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(StockTakeItem model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<StockTakeItem> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(StockTakeItem model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<StockTakeItem> models,
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

  Future<void> updateMany(List<StockTakeItem> models,
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
