// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _DeliveryBean implements Bean<Delivery> {
  final id = IntField('id');
  final scheduledDeliveryId = IntField('scheduled_delivery_id');
  final orderId = IntField('order_id');
  final deliveryTime = DateTimeField('delivery_time');
  final orderTime = DateTimeField('order_time');
  final shopId = IntField('shop_id');
  final deliveryNotes = StrField('delivery_notes');
  final receivedsignature = StrField('receivedsignature');
  final shopName = StrField('shop_name');
  final shopLat = StrField('shop_lat');
  final shopLon = StrField('shop_lon');
  final photo = StrField('photo');
  final name = StrField('name');
  final synced = BoolField('synced');
  final fromServer = BoolField('from_server');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        scheduledDeliveryId.name: scheduledDeliveryId,
        orderId.name: orderId,
        deliveryTime.name: deliveryTime,
        orderTime.name: orderTime,
        shopId.name: shopId,
        deliveryNotes.name: deliveryNotes,
        receivedsignature.name: receivedsignature,
        shopName.name: shopName,
        shopLat.name: shopLat,
        shopLon.name: shopLon,
        photo.name: photo,
        name.name: name,
        synced.name: synced,
        fromServer.name: fromServer,
      };
  Delivery fromMap(Map map) {
    Delivery model = Delivery();
    model.id = adapter.parseValue(map['id']);
    model.scheduledDeliveryId =
        adapter.parseValue(map['scheduled_delivery_id']);
    model.orderId = adapter.parseValue(map['order_id']);
    model.deliveryTime = adapter.parseValue(map['delivery_time']);
    model.orderTime = adapter.parseValue(map['order_time']);
    model.shopId = adapter.parseValue(map['shop_id']);
    model.deliveryNotes = adapter.parseValue(map['delivery_notes']);
    model.receivedsignature = adapter.parseValue(map['receivedsignature']);
    model.shopName = adapter.parseValue(map['shop_name']);
    model.shopLat = adapter.parseValue(map['shop_lat']);
    model.shopLon = adapter.parseValue(map['shop_lon']);
    model.photo = adapter.parseValue(map['photo']);
    model.name = adapter.parseValue(map['name']);
    model.synced = adapter.parseValue(map['synced']);
    model.fromServer = adapter.parseValue(map['from_server']);

    return model;
  }

  List<SetColumn> toSetColumns(Delivery model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(scheduledDeliveryId.set(model.scheduledDeliveryId));
      ret.add(orderId.set(model.orderId));
      ret.add(deliveryTime.set(model.deliveryTime));
      ret.add(orderTime.set(model.orderTime));
      ret.add(shopId.set(model.shopId));
      ret.add(deliveryNotes.set(model.deliveryNotes));
      ret.add(receivedsignature.set(model.receivedsignature));
      ret.add(shopName.set(model.shopName));
      ret.add(shopLat.set(model.shopLat));
      ret.add(shopLon.set(model.shopLon));
      ret.add(photo.set(model.photo));
      ret.add(name.set(model.name));
      ret.add(synced.set(model.synced));
      ret.add(fromServer.set(model.fromServer));
    } else if (only != null) {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(scheduledDeliveryId.name))
        ret.add(scheduledDeliveryId.set(model.scheduledDeliveryId));
      if (only.contains(orderId.name)) ret.add(orderId.set(model.orderId));
      if (only.contains(deliveryTime.name))
        ret.add(deliveryTime.set(model.deliveryTime));
      if (only.contains(orderTime.name))
        ret.add(orderTime.set(model.orderTime));
      if (only.contains(shopId.name)) ret.add(shopId.set(model.shopId));
      if (only.contains(deliveryNotes.name))
        ret.add(deliveryNotes.set(model.deliveryNotes));
      if (only.contains(receivedsignature.name))
        ret.add(receivedsignature.set(model.receivedsignature));
      if (only.contains(shopName.name)) ret.add(shopName.set(model.shopName));
      if (only.contains(shopLat.name)) ret.add(shopLat.set(model.shopLat));
      if (only.contains(shopLon.name)) ret.add(shopLon.set(model.shopLon));
      if (only.contains(photo.name)) ret.add(photo.set(model.photo));
      if (only.contains(name.name)) ret.add(name.set(model.name));
      if (only.contains(synced.name)) ret.add(synced.set(model.synced));
      if (only.contains(fromServer.name))
        ret.add(fromServer.set(model.fromServer));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.scheduledDeliveryId != null) {
        ret.add(scheduledDeliveryId.set(model.scheduledDeliveryId));
      }
      if (model.orderId != null) {
        ret.add(orderId.set(model.orderId));
      }
      if (model.deliveryTime != null) {
        ret.add(deliveryTime.set(model.deliveryTime));
      }
      if (model.orderTime != null) {
        ret.add(orderTime.set(model.orderTime));
      }
      if (model.shopId != null) {
        ret.add(shopId.set(model.shopId));
      }
      if (model.deliveryNotes != null) {
        ret.add(deliveryNotes.set(model.deliveryNotes));
      }
      if (model.receivedsignature != null) {
        ret.add(receivedsignature.set(model.receivedsignature));
      }
      if (model.shopName != null) {
        ret.add(shopName.set(model.shopName));
      }
      if (model.shopLat != null) {
        ret.add(shopLat.set(model.shopLat));
      }
      if (model.shopLon != null) {
        ret.add(shopLon.set(model.shopLon));
      }
      if (model.photo != null) {
        ret.add(photo.set(model.photo));
      }
      if (model.name != null) {
        ret.add(name.set(model.name));
      }
      if (model.synced != null) {
        ret.add(synced.set(model.synced));
      }
      if (model.fromServer != null) {
        ret.add(fromServer.set(model.fromServer));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, autoIncrement: true, isNullable: false);
    st.addInt(scheduledDeliveryId.name, isNullable: true);
    st.addInt(orderId.name, isNullable: true);
    st.addDateTime(deliveryTime.name, isNullable: true);
    st.addDateTime(orderTime.name, isNullable: true);
    st.addInt(shopId.name, isNullable: true);
    st.addStr(deliveryNotes.name, isNullable: true);
    st.addStr(receivedsignature.name, isNullable: true);
    st.addStr(shopName.name, isNullable: true);
    st.addStr(shopLat.name, isNullable: true);
    st.addStr(shopLon.name, isNullable: true);
    st.addStr(photo.name, isNullable: true);
    st.addStr(name.name, isNullable: true);
    st.addBool(synced.name, isNullable: false);
    st.addBool(fromServer.name, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Delivery model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      Delivery newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<Delivery> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Delivery model,
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
      Delivery newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<Delivery> models,
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

  Future<int> update(Delivery model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Delivery> models,
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

  Future<Delivery> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Delivery> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
