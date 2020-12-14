// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_category_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _ShopCategoryBean implements Bean<ShopCategory> {
  final shopcatId = IntField('shopcat_id');
  final shopCatName = StrField('shop_cat_name');
  final status = StrField('status');
  final mapMarker = StrField('map_marker');
  final createdAt = StrField('created_at');
  final updatedAt = StrField('updated_at');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        shopcatId.name: shopcatId,
        shopCatName.name: shopCatName,
        status.name: status,
        mapMarker.name: mapMarker,
        createdAt.name: createdAt,
        updatedAt.name: updatedAt,
      };
  ShopCategory fromMap(Map map) {
    ShopCategory model = ShopCategory();
    model.shopcatId = adapter.parseValue(map['shopcat_id']);
    model.shopCatName = adapter.parseValue(map['shop_cat_name']);
    model.status = adapter.parseValue(map['status']);
    model.mapMarker = adapter.parseValue(map['map_marker']);
    model.createdAt = adapter.parseValue(map['created_at']);
    model.updatedAt = adapter.parseValue(map['updated_at']);

    return model;
  }

  List<SetColumn> toSetColumns(ShopCategory model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(shopcatId.set(model.shopcatId));
      ret.add(shopCatName.set(model.shopCatName));
      ret.add(status.set(model.status));
      ret.add(mapMarker.set(model.mapMarker));
      ret.add(createdAt.set(model.createdAt));
      ret.add(updatedAt.set(model.updatedAt));
    } else if (only != null) {
      if (only.contains(shopcatId.name))
        ret.add(shopcatId.set(model.shopcatId));
      if (only.contains(shopCatName.name))
        ret.add(shopCatName.set(model.shopCatName));
      if (only.contains(status.name)) ret.add(status.set(model.status));
      if (only.contains(mapMarker.name))
        ret.add(mapMarker.set(model.mapMarker));
      if (only.contains(createdAt.name))
        ret.add(createdAt.set(model.createdAt));
      if (only.contains(updatedAt.name))
        ret.add(updatedAt.set(model.updatedAt));
    } else /* if (onlyNonNull) */ {
      if (model.shopcatId != null) {
        ret.add(shopcatId.set(model.shopcatId));
      }
      if (model.shopCatName != null) {
        ret.add(shopCatName.set(model.shopCatName));
      }
      if (model.status != null) {
        ret.add(status.set(model.status));
      }
      if (model.mapMarker != null) {
        ret.add(mapMarker.set(model.mapMarker));
      }
      if (model.createdAt != null) {
        ret.add(createdAt.set(model.createdAt));
      }
      if (model.updatedAt != null) {
        ret.add(updatedAt.set(model.updatedAt));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(shopcatId.name, primary: true, isNullable: false);
    st.addStr(shopCatName.name, isNullable: true);
    st.addStr(status.name, isNullable: true);
    st.addStr(mapMarker.name, isNullable: true);
    st.addStr(createdAt.name, isNullable: true);
    st.addStr(updatedAt.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(ShopCategory model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<ShopCategory> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(ShopCategory model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<ShopCategory> models,
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

  Future<int> update(ShopCategory model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.shopcatId.eq(model.shopcatId))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<ShopCategory> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(this.shopcatId.eq(model.shopcatId));
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<ShopCategory> find(int shopcatId,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.shopcatId.eq(shopcatId));
    return await findOne(find);
  }

  Future<int> remove(int shopcatId) async {
    final Remove remove = remover.where(this.shopcatId.eq(shopcatId));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<ShopCategory> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.shopcatId.eq(model.shopcatId));
    }
    return adapter.remove(remove);
  }
}
