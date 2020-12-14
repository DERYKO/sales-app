// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_item_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _StockItemBean implements Bean<StockItem> {
  final productId = IntField('product_id');
  final stockId = IntField('stock_id');
  final productName = StrField('product_name');
  final productDesc = StrField('product_desc');
  final unit = StrField('unit');
  final batchnumber = StrField('batchnumber');
  final quantity = IntField('quantity');
  final price = DoubleField('price');
  final crtQnty = IntField('crt_qnty');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        productId.name: productId,
        stockId.name: stockId,
        productName.name: productName,
        productDesc.name: productDesc,
        unit.name: unit,
        batchnumber.name: batchnumber,
        quantity.name: quantity,
        price.name: price,
        crtQnty.name: crtQnty,
      };
  StockItem fromMap(Map map) {
    StockItem model = StockItem();
    model.productId = adapter.parseValue(map['product_id']);
    model.stockId = adapter.parseValue(map['stock_id']);
    model.productName = adapter.parseValue(map['product_name']);
    model.productDesc = adapter.parseValue(map['product_desc']);
    model.unit = adapter.parseValue(map['unit']);
    model.batchnumber = adapter.parseValue(map['batchnumber']);
    model.quantity = adapter.parseValue(map['quantity']);
    model.price = adapter.parseValue(map['price']);
    model.crtQnty = adapter.parseValue(map['crt_qnty']);

    return model;
  }

  List<SetColumn> toSetColumns(StockItem model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(productId.set(model.productId));
      ret.add(stockId.set(model.stockId));
      ret.add(productName.set(model.productName));
      ret.add(productDesc.set(model.productDesc));
      ret.add(unit.set(model.unit));
      ret.add(batchnumber.set(model.batchnumber));
      ret.add(quantity.set(model.quantity));
      ret.add(price.set(model.price));
      ret.add(crtQnty.set(model.crtQnty));
    } else if (only != null) {
      if (only.contains(productId.name))
        ret.add(productId.set(model.productId));
      if (only.contains(stockId.name)) ret.add(stockId.set(model.stockId));
      if (only.contains(productName.name))
        ret.add(productName.set(model.productName));
      if (only.contains(productDesc.name))
        ret.add(productDesc.set(model.productDesc));
      if (only.contains(unit.name)) ret.add(unit.set(model.unit));
      if (only.contains(batchnumber.name))
        ret.add(batchnumber.set(model.batchnumber));
      if (only.contains(quantity.name)) ret.add(quantity.set(model.quantity));
      if (only.contains(price.name)) ret.add(price.set(model.price));
      if (only.contains(crtQnty.name)) ret.add(crtQnty.set(model.crtQnty));
    } else /* if (onlyNonNull) */ {
      if (model.productId != null) {
        ret.add(productId.set(model.productId));
      }
      if (model.stockId != null) {
        ret.add(stockId.set(model.stockId));
      }
      if (model.productName != null) {
        ret.add(productName.set(model.productName));
      }
      if (model.productDesc != null) {
        ret.add(productDesc.set(model.productDesc));
      }
      if (model.unit != null) {
        ret.add(unit.set(model.unit));
      }
      if (model.batchnumber != null) {
        ret.add(batchnumber.set(model.batchnumber));
      }
      if (model.quantity != null) {
        ret.add(quantity.set(model.quantity));
      }
      if (model.price != null) {
        ret.add(price.set(model.price));
      }
      if (model.crtQnty != null) {
        ret.add(crtQnty.set(model.crtQnty));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(productId.name, isNullable: false);
    st.addInt(stockId.name, isNullable: false);
    st.addStr(productName.name, isNullable: true);
    st.addStr(productDesc.name, isNullable: true);
    st.addStr(unit.name, isNullable: true);
    st.addStr(batchnumber.name, isNullable: true);
    st.addInt(quantity.name, isNullable: false);
    st.addDouble(price.name, isNullable: false);
    st.addInt(crtQnty.name, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(StockItem model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<StockItem> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(StockItem model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<StockItem> models,
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

  Future<void> updateMany(List<StockItem> models,
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
