// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_route_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _ShopRouteBean implements Bean<ShopRoute> {
  final shopId = IntField('shop_id');
  final routeId = IntField('route_id');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        shopId.name: shopId,
        routeId.name: routeId,
      };
  ShopRoute fromMap(Map map) {
    ShopRoute model = ShopRoute();
    model.shopId = adapter.parseValue(map['shop_id']);
    model.routeId = adapter.parseValue(map['route_id']);

    return model;
  }

  List<SetColumn> toSetColumns(ShopRoute model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(shopId.set(model.shopId));
      ret.add(routeId.set(model.routeId));
    } else if (only != null) {
      if (only.contains(shopId.name)) ret.add(shopId.set(model.shopId));
      if (only.contains(routeId.name)) ret.add(routeId.set(model.routeId));
    } else /* if (onlyNonNull) */ {
      if (model.shopId != null) {
        ret.add(shopId.set(model.shopId));
      }
      if (model.routeId != null) {
        ret.add(routeId.set(model.routeId));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(shopId.name, isNullable: false);
    st.addInt(routeId.name, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(ShopRoute model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<ShopRoute> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(ShopRoute model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<ShopRoute> models,
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

  Future<void> updateMany(List<ShopRoute> models,
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
