// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _OrderItemBean implements Bean<OrderItem> {
  final orderitemId = IntField('orderitem_id');
  final orderId = IntField('order_id');
  final productId = IntField('product_id');
  final quantity = IntField('quantity');
  final ordered = StrField('ordered');
  final batchnumber = StrField('batchnumber');
  final cartonQuantity = IntField('carton_quantity');
  final orderQuantity = IntField('order_quantity');
  final distribution = IntField('distribution');
  final sellingPrice = StrField('selling_price');
  final productPackaging = StrField('product_packaging');
  final sellingTotalcost = StrField('selling_totalcost');
  final orderitemTotalcost = StrField('orderitem_totalcost');
  final itemTotalcost = StrField('item_totalcost');
  final orderitemStatus = IntField('orderitem_status');
  final changeReason = StrField('change_reason');
  final createdAt = DateTimeField('created_at');
  final updatedAt = DateTimeField('updated_at');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        orderitemId.name: orderitemId,
        orderId.name: orderId,
        productId.name: productId,
        quantity.name: quantity,
        ordered.name: ordered,
        batchnumber.name: batchnumber,
        cartonQuantity.name: cartonQuantity,
        orderQuantity.name: orderQuantity,
        distribution.name: distribution,
        sellingPrice.name: sellingPrice,
        productPackaging.name: productPackaging,
        sellingTotalcost.name: sellingTotalcost,
        orderitemTotalcost.name: orderitemTotalcost,
        itemTotalcost.name: itemTotalcost,
        orderitemStatus.name: orderitemStatus,
        changeReason.name: changeReason,
        createdAt.name: createdAt,
        updatedAt.name: updatedAt,
      };
  OrderItem fromMap(Map map) {
    OrderItem model = OrderItem();
    model.orderitemId = adapter.parseValue(map['orderitem_id']);
    model.orderId = adapter.parseValue(map['order_id']);
    model.productId = adapter.parseValue(map['product_id']);
    model.quantity = adapter.parseValue(map['quantity']);
    model.ordered = adapter.parseValue(map['ordered']);
    model.batchnumber = adapter.parseValue(map['batchnumber']);
    model.cartonQuantity = adapter.parseValue(map['carton_quantity']);
    model.orderQuantity = adapter.parseValue(map['order_quantity']);
    model.distribution = adapter.parseValue(map['distribution']);
    model.sellingPrice = adapter.parseValue(map['selling_price']);
    model.productPackaging = adapter.parseValue(map['product_packaging']);
    model.sellingTotalcost = adapter.parseValue(map['selling_totalcost']);
    model.orderitemTotalcost = adapter.parseValue(map['orderitem_totalcost']);
    model.itemTotalcost = adapter.parseValue(map['item_totalcost']);
    model.orderitemStatus = adapter.parseValue(map['orderitem_status']);
    model.changeReason = adapter.parseValue(map['change_reason']);
    model.createdAt = adapter.parseValue(map['created_at']);
    model.updatedAt = adapter.parseValue(map['updated_at']);

    return model;
  }

  List<SetColumn> toSetColumns(OrderItem model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(orderitemId.set(model.orderitemId));
      ret.add(orderId.set(model.orderId));
      ret.add(productId.set(model.productId));
      ret.add(quantity.set(model.quantity));
      ret.add(ordered.set(model.ordered));
      ret.add(batchnumber.set(model.batchnumber));
      ret.add(cartonQuantity.set(model.cartonQuantity));
      ret.add(orderQuantity.set(model.orderQuantity));
      ret.add(distribution.set(model.distribution));
      ret.add(sellingPrice.set(model.sellingPrice));
      ret.add(productPackaging.set(model.productPackaging));
      ret.add(sellingTotalcost.set(model.sellingTotalcost));
      ret.add(orderitemTotalcost.set(model.orderitemTotalcost));
      ret.add(itemTotalcost.set(model.itemTotalcost));
      ret.add(orderitemStatus.set(model.orderitemStatus));
      ret.add(changeReason.set(model.changeReason));
      ret.add(createdAt.set(model.createdAt));
      ret.add(updatedAt.set(model.updatedAt));
    } else if (only != null) {
      if (only.contains(orderitemId.name))
        ret.add(orderitemId.set(model.orderitemId));
      if (only.contains(orderId.name)) ret.add(orderId.set(model.orderId));
      if (only.contains(productId.name))
        ret.add(productId.set(model.productId));
      if (only.contains(quantity.name)) ret.add(quantity.set(model.quantity));
      if (only.contains(ordered.name)) ret.add(ordered.set(model.ordered));
      if (only.contains(batchnumber.name))
        ret.add(batchnumber.set(model.batchnumber));
      if (only.contains(cartonQuantity.name))
        ret.add(cartonQuantity.set(model.cartonQuantity));
      if (only.contains(orderQuantity.name))
        ret.add(orderQuantity.set(model.orderQuantity));
      if (only.contains(distribution.name))
        ret.add(distribution.set(model.distribution));
      if (only.contains(sellingPrice.name))
        ret.add(sellingPrice.set(model.sellingPrice));
      if (only.contains(productPackaging.name))
        ret.add(productPackaging.set(model.productPackaging));
      if (only.contains(sellingTotalcost.name))
        ret.add(sellingTotalcost.set(model.sellingTotalcost));
      if (only.contains(orderitemTotalcost.name))
        ret.add(orderitemTotalcost.set(model.orderitemTotalcost));
      if (only.contains(itemTotalcost.name))
        ret.add(itemTotalcost.set(model.itemTotalcost));
      if (only.contains(orderitemStatus.name))
        ret.add(orderitemStatus.set(model.orderitemStatus));
      if (only.contains(changeReason.name))
        ret.add(changeReason.set(model.changeReason));
      if (only.contains(createdAt.name))
        ret.add(createdAt.set(model.createdAt));
      if (only.contains(updatedAt.name))
        ret.add(updatedAt.set(model.updatedAt));
    } else /* if (onlyNonNull) */ {
      if (model.orderitemId != null) {
        ret.add(orderitemId.set(model.orderitemId));
      }
      if (model.orderId != null) {
        ret.add(orderId.set(model.orderId));
      }
      if (model.productId != null) {
        ret.add(productId.set(model.productId));
      }
      if (model.quantity != null) {
        ret.add(quantity.set(model.quantity));
      }
      if (model.ordered != null) {
        ret.add(ordered.set(model.ordered));
      }
      if (model.batchnumber != null) {
        ret.add(batchnumber.set(model.batchnumber));
      }
      if (model.cartonQuantity != null) {
        ret.add(cartonQuantity.set(model.cartonQuantity));
      }
      if (model.orderQuantity != null) {
        ret.add(orderQuantity.set(model.orderQuantity));
      }
      if (model.distribution != null) {
        ret.add(distribution.set(model.distribution));
      }
      if (model.sellingPrice != null) {
        ret.add(sellingPrice.set(model.sellingPrice));
      }
      if (model.productPackaging != null) {
        ret.add(productPackaging.set(model.productPackaging));
      }
      if (model.sellingTotalcost != null) {
        ret.add(sellingTotalcost.set(model.sellingTotalcost));
      }
      if (model.orderitemTotalcost != null) {
        ret.add(orderitemTotalcost.set(model.orderitemTotalcost));
      }
      if (model.itemTotalcost != null) {
        ret.add(itemTotalcost.set(model.itemTotalcost));
      }
      if (model.orderitemStatus != null) {
        ret.add(orderitemStatus.set(model.orderitemStatus));
      }
      if (model.changeReason != null) {
        ret.add(changeReason.set(model.changeReason));
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
    st.addInt(orderitemId.name, isNullable: true);
    st.addInt(orderId.name, isNullable: true);
    st.addInt(productId.name, isNullable: true);
    st.addInt(quantity.name, isNullable: true);
    st.addStr(ordered.name, isNullable: true);
    st.addStr(batchnumber.name, isNullable: true);
    st.addInt(cartonQuantity.name, isNullable: true);
    st.addInt(orderQuantity.name, isNullable: true);
    st.addInt(distribution.name, isNullable: true);
    st.addStr(sellingPrice.name, isNullable: true);
    st.addStr(productPackaging.name, isNullable: true);
    st.addStr(sellingTotalcost.name, isNullable: true);
    st.addStr(orderitemTotalcost.name, isNullable: true);
    st.addStr(itemTotalcost.name, isNullable: true);
    st.addInt(orderitemStatus.name, isNullable: true);
    st.addStr(changeReason.name, isNullable: true);
    st.addDateTime(createdAt.name, isNullable: true);
    st.addDateTime(updatedAt.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(OrderItem model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<OrderItem> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(OrderItem model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<OrderItem> models,
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

  Future<void> updateMany(List<OrderItem> models,
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
