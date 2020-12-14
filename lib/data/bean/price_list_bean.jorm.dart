// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_list_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _PriceListBean implements Bean<PriceList> {
  final pricelistId = IntField('pricelist_id');
  final productId = IntField('product_id');
  final pricelistName = StrField('pricelist_name');
  final productCode = StrField('product_code');
  final packetsBuying = StrField('packets_buying');
  final cartonBuying = StrField('carton_buying');
  final pricePkts = StrField('price_pkts');
  final priceCrtns = StrField('price_crtns');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        pricelistId.name: pricelistId,
        productId.name: productId,
        pricelistName.name: pricelistName,
        productCode.name: productCode,
        packetsBuying.name: packetsBuying,
        cartonBuying.name: cartonBuying,
        pricePkts.name: pricePkts,
        priceCrtns.name: priceCrtns,
      };
  PriceList fromMap(Map map) {
    PriceList model = PriceList();
    model.pricelistId = adapter.parseValue(map['pricelist_id']);
    model.productId = adapter.parseValue(map['product_id']);
    model.pricelistName = adapter.parseValue(map['pricelist_name']);
    model.productCode = adapter.parseValue(map['product_code']);
    model.packetsBuying = adapter.parseValue(map['packets_buying']);
    model.cartonBuying = adapter.parseValue(map['carton_buying']);
    model.pricePkts = adapter.parseValue(map['price_pkts']);
    model.priceCrtns = adapter.parseValue(map['price_crtns']);

    return model;
  }

  List<SetColumn> toSetColumns(PriceList model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(pricelistId.set(model.pricelistId));
      ret.add(productId.set(model.productId));
      ret.add(pricelistName.set(model.pricelistName));
      ret.add(productCode.set(model.productCode));
      ret.add(packetsBuying.set(model.packetsBuying));
      ret.add(cartonBuying.set(model.cartonBuying));
      ret.add(pricePkts.set(model.pricePkts));
      ret.add(priceCrtns.set(model.priceCrtns));
    } else if (only != null) {
      if (only.contains(pricelistId.name))
        ret.add(pricelistId.set(model.pricelistId));
      if (only.contains(productId.name))
        ret.add(productId.set(model.productId));
      if (only.contains(pricelistName.name))
        ret.add(pricelistName.set(model.pricelistName));
      if (only.contains(productCode.name))
        ret.add(productCode.set(model.productCode));
      if (only.contains(packetsBuying.name))
        ret.add(packetsBuying.set(model.packetsBuying));
      if (only.contains(cartonBuying.name))
        ret.add(cartonBuying.set(model.cartonBuying));
      if (only.contains(pricePkts.name))
        ret.add(pricePkts.set(model.pricePkts));
      if (only.contains(priceCrtns.name))
        ret.add(priceCrtns.set(model.priceCrtns));
    } else /* if (onlyNonNull) */ {
      if (model.pricelistId != null) {
        ret.add(pricelistId.set(model.pricelistId));
      }
      if (model.productId != null) {
        ret.add(productId.set(model.productId));
      }
      if (model.pricelistName != null) {
        ret.add(pricelistName.set(model.pricelistName));
      }
      if (model.productCode != null) {
        ret.add(productCode.set(model.productCode));
      }
      if (model.packetsBuying != null) {
        ret.add(packetsBuying.set(model.packetsBuying));
      }
      if (model.cartonBuying != null) {
        ret.add(cartonBuying.set(model.cartonBuying));
      }
      if (model.pricePkts != null) {
        ret.add(pricePkts.set(model.pricePkts));
      }
      if (model.priceCrtns != null) {
        ret.add(priceCrtns.set(model.priceCrtns));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(pricelistId.name, isNullable: true);
    st.addInt(productId.name, isNullable: true);
    st.addStr(pricelistName.name, isNullable: true);
    st.addStr(productCode.name, isNullable: true);
    st.addStr(packetsBuying.name, isNullable: true);
    st.addStr(cartonBuying.name, isNullable: true);
    st.addStr(pricePkts.name, isNullable: true);
    st.addStr(priceCrtns.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(PriceList model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<PriceList> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(PriceList model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<PriceList> models,
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

  Future<void> updateMany(List<PriceList> models,
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
