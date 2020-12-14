// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_order_detail_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _DeliveryOrderDetailBean implements Bean<DeliveryOrderDetail> {
  final id = IntField('id');
  final orderId = IntField('order_id');
  final productDescription = StrField('product_description');
  final productId = IntField('product_id');
  final quantity = IntField('quantity');
  final productPackaging = StrField('product_packaging');
  final sellingTotalcost = StrField('selling_totalcost');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        orderId.name: orderId,
        productDescription.name: productDescription,
        productId.name: productId,
        quantity.name: quantity,
        productPackaging.name: productPackaging,
        sellingTotalcost.name: sellingTotalcost,
      };
  DeliveryOrderDetail fromMap(Map map) {
    DeliveryOrderDetail model = DeliveryOrderDetail();
    model.id = adapter.parseValue(map['id']);
    model.orderId = adapter.parseValue(map['order_id']);
    model.productDescription = adapter.parseValue(map['product_description']);
    model.productId = adapter.parseValue(map['product_id']);
    model.quantity = adapter.parseValue(map['quantity']);
    model.productPackaging = adapter.parseValue(map['product_packaging']);
    model.sellingTotalcost = adapter.parseValue(map['selling_totalcost']);

    return model;
  }

  List<SetColumn> toSetColumns(DeliveryOrderDetail model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(orderId.set(model.orderId));
      ret.add(productDescription.set(model.productDescription));
      ret.add(productId.set(model.productId));
      ret.add(quantity.set(model.quantity));
      ret.add(productPackaging.set(model.productPackaging));
      ret.add(sellingTotalcost.set(model.sellingTotalcost));
    } else if (only != null) {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(orderId.name)) ret.add(orderId.set(model.orderId));
      if (only.contains(productDescription.name))
        ret.add(productDescription.set(model.productDescription));
      if (only.contains(productId.name))
        ret.add(productId.set(model.productId));
      if (only.contains(quantity.name)) ret.add(quantity.set(model.quantity));
      if (only.contains(productPackaging.name))
        ret.add(productPackaging.set(model.productPackaging));
      if (only.contains(sellingTotalcost.name))
        ret.add(sellingTotalcost.set(model.sellingTotalcost));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.orderId != null) {
        ret.add(orderId.set(model.orderId));
      }
      if (model.productDescription != null) {
        ret.add(productDescription.set(model.productDescription));
      }
      if (model.productId != null) {
        ret.add(productId.set(model.productId));
      }
      if (model.quantity != null) {
        ret.add(quantity.set(model.quantity));
      }
      if (model.productPackaging != null) {
        ret.add(productPackaging.set(model.productPackaging));
      }
      if (model.sellingTotalcost != null) {
        ret.add(sellingTotalcost.set(model.sellingTotalcost));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, autoIncrement: true, isNullable: false);
    st.addInt(orderId.name, isNullable: true);
    st.addStr(productDescription.name, isNullable: true);
    st.addInt(productId.name, isNullable: true);
    st.addInt(quantity.name, isNullable: true);
    st.addStr(productPackaging.name, isNullable: true);
    st.addStr(sellingTotalcost.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(DeliveryOrderDetail model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      DeliveryOrderDetail newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<DeliveryOrderDetail> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(DeliveryOrderDetail model,
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
      DeliveryOrderDetail newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<DeliveryOrderDetail> models,
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

  Future<int> update(DeliveryOrderDetail model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<DeliveryOrderDetail> models,
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

  Future<DeliveryOrderDetail> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<DeliveryOrderDetail> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
