// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _OrderBean implements Bean<Order> {
  final id = IntField('id');
  final sellingTotalCost = DoubleField('selling_total_cost');
  final salerId = IntField('saler_id');
  final shopId = IntField('shop_id');
  final visitId = StrField('visit_id');
  final printedAt = DateTimeField('printed_at');
  final newShop = IntField('new_shop');
  final orderId = IntField('order_id');
  final creditNote = StrField('credit_note');
  final entryType = StrField('entry_type');
  final appVersion = StrField('app_version');
  final lpoPhoto = StrField('lpo_photo');
  final lponumber = StrField('lponumber');
  final chequePhoto = StrField('cheque_photo');
  final paymentAmount = DoubleField('payment_amount');
  final paymentReference = StrField('payment_reference');
  final paymentMethod = StrField('payment_method');
  final paymentStatus = StrField('payment_status');
  final totalCost = DoubleField('total_cost');
  final callStatus = StrField('call_status');
  final channel = StrField('channel');
  final orderType = StrField('order_type');
  final battery = StrField('battery');
  final notes = StrField('notes');
  final paymentId = StrField('payment_id');
  final maturityDate = DateTimeField('maturity_date');
  final nextPayment = DateTimeField('next_payment');
  final expectedDelivery = DateTimeField('expected_delivery');
  final orderTime = DateTimeField('order_time');
  final latitude = DoubleField('latitude');
  final longitude = DoubleField('longitude');
  final synced = BoolField('synced');
  final fromServer = BoolField('from_server');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        sellingTotalCost.name: sellingTotalCost,
        salerId.name: salerId,
        shopId.name: shopId,
        visitId.name: visitId,
        printedAt.name: printedAt,
        newShop.name: newShop,
        orderId.name: orderId,
        creditNote.name: creditNote,
        entryType.name: entryType,
        appVersion.name: appVersion,
        lpoPhoto.name: lpoPhoto,
        lponumber.name: lponumber,
        chequePhoto.name: chequePhoto,
        paymentAmount.name: paymentAmount,
        paymentReference.name: paymentReference,
        paymentMethod.name: paymentMethod,
        paymentStatus.name: paymentStatus,
        totalCost.name: totalCost,
        callStatus.name: callStatus,
        channel.name: channel,
        orderType.name: orderType,
        battery.name: battery,
        notes.name: notes,
        paymentId.name: paymentId,
        maturityDate.name: maturityDate,
        nextPayment.name: nextPayment,
        expectedDelivery.name: expectedDelivery,
        orderTime.name: orderTime,
        latitude.name: latitude,
        longitude.name: longitude,
        synced.name: synced,
        fromServer.name: fromServer,
      };
  Order fromMap(Map map) {
    Order model = Order();
    model.id = adapter.parseValue(map['id']);
    model.sellingTotalCost = adapter.parseValue(map['selling_total_cost']);
    model.salerId = adapter.parseValue(map['saler_id']);
    model.shopId = adapter.parseValue(map['shop_id']);
    model.visitId = adapter.parseValue(map['visit_id']);
    model.printedAt = adapter.parseValue(map['printed_at']);
    model.newShop = adapter.parseValue(map['new_shop']);
    model.orderId = adapter.parseValue(map['order_id']);
    model.creditNote = adapter.parseValue(map['credit_note']);
    model.entryType = adapter.parseValue(map['entry_type']);
    model.appVersion = adapter.parseValue(map['app_version']);
    model.lpoPhoto = adapter.parseValue(map['lpo_photo']);
    model.lponumber = adapter.parseValue(map['lponumber']);
    model.chequePhoto = adapter.parseValue(map['cheque_photo']);
    model.paymentAmount = adapter.parseValue(map['payment_amount']);
    model.paymentReference = adapter.parseValue(map['payment_reference']);
    model.paymentMethod = adapter.parseValue(map['payment_method']);
    model.paymentStatus = adapter.parseValue(map['payment_status']);
    model.totalCost = adapter.parseValue(map['total_cost']);
    model.callStatus = adapter.parseValue(map['call_status']);
    model.channel = adapter.parseValue(map['channel']);
    model.orderType = adapter.parseValue(map['order_type']);
    model.battery = adapter.parseValue(map['battery']);
    model.notes = adapter.parseValue(map['notes']);
    model.paymentId = adapter.parseValue(map['payment_id']);
    model.maturityDate = adapter.parseValue(map['maturity_date']);
    model.nextPayment = adapter.parseValue(map['next_payment']);
    model.expectedDelivery = adapter.parseValue(map['expected_delivery']);
    model.orderTime = adapter.parseValue(map['order_time']);
    model.latitude = adapter.parseValue(map['latitude']);
    model.longitude = adapter.parseValue(map['longitude']);
    model.synced = adapter.parseValue(map['synced']);
    model.fromServer = adapter.parseValue(map['from_server']);

    return model;
  }

  List<SetColumn> toSetColumns(Order model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(sellingTotalCost.set(model.sellingTotalCost));
      ret.add(salerId.set(model.salerId));
      ret.add(shopId.set(model.shopId));
      ret.add(visitId.set(model.visitId));
      ret.add(printedAt.set(model.printedAt));
      ret.add(newShop.set(model.newShop));
      ret.add(orderId.set(model.orderId));
      ret.add(creditNote.set(model.creditNote));
      ret.add(entryType.set(model.entryType));
      ret.add(appVersion.set(model.appVersion));
      ret.add(lpoPhoto.set(model.lpoPhoto));
      ret.add(lponumber.set(model.lponumber));
      ret.add(chequePhoto.set(model.chequePhoto));
      ret.add(paymentAmount.set(model.paymentAmount));
      ret.add(paymentReference.set(model.paymentReference));
      ret.add(paymentMethod.set(model.paymentMethod));
      ret.add(paymentStatus.set(model.paymentStatus));
      ret.add(totalCost.set(model.totalCost));
      ret.add(callStatus.set(model.callStatus));
      ret.add(channel.set(model.channel));
      ret.add(orderType.set(model.orderType));
      ret.add(battery.set(model.battery));
      ret.add(notes.set(model.notes));
      ret.add(paymentId.set(model.paymentId));
      ret.add(maturityDate.set(model.maturityDate));
      ret.add(nextPayment.set(model.nextPayment));
      ret.add(expectedDelivery.set(model.expectedDelivery));
      ret.add(orderTime.set(model.orderTime));
      ret.add(latitude.set(model.latitude));
      ret.add(longitude.set(model.longitude));
      ret.add(synced.set(model.synced));
      ret.add(fromServer.set(model.fromServer));
    } else if (only != null) {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(sellingTotalCost.name))
        ret.add(sellingTotalCost.set(model.sellingTotalCost));
      if (only.contains(salerId.name)) ret.add(salerId.set(model.salerId));
      if (only.contains(shopId.name)) ret.add(shopId.set(model.shopId));
      if (only.contains(visitId.name)) ret.add(visitId.set(model.visitId));
      if (only.contains(printedAt.name))
        ret.add(printedAt.set(model.printedAt));
      if (only.contains(newShop.name)) ret.add(newShop.set(model.newShop));
      if (only.contains(orderId.name)) ret.add(orderId.set(model.orderId));
      if (only.contains(creditNote.name))
        ret.add(creditNote.set(model.creditNote));
      if (only.contains(entryType.name))
        ret.add(entryType.set(model.entryType));
      if (only.contains(appVersion.name))
        ret.add(appVersion.set(model.appVersion));
      if (only.contains(lpoPhoto.name)) ret.add(lpoPhoto.set(model.lpoPhoto));
      if (only.contains(lponumber.name))
        ret.add(lponumber.set(model.lponumber));
      if (only.contains(chequePhoto.name))
        ret.add(chequePhoto.set(model.chequePhoto));
      if (only.contains(paymentAmount.name))
        ret.add(paymentAmount.set(model.paymentAmount));
      if (only.contains(paymentReference.name))
        ret.add(paymentReference.set(model.paymentReference));
      if (only.contains(paymentMethod.name))
        ret.add(paymentMethod.set(model.paymentMethod));
      if (only.contains(paymentStatus.name))
        ret.add(paymentStatus.set(model.paymentStatus));
      if (only.contains(totalCost.name))
        ret.add(totalCost.set(model.totalCost));
      if (only.contains(callStatus.name))
        ret.add(callStatus.set(model.callStatus));
      if (only.contains(channel.name)) ret.add(channel.set(model.channel));
      if (only.contains(orderType.name))
        ret.add(orderType.set(model.orderType));
      if (only.contains(battery.name)) ret.add(battery.set(model.battery));
      if (only.contains(notes.name)) ret.add(notes.set(model.notes));
      if (only.contains(paymentId.name))
        ret.add(paymentId.set(model.paymentId));
      if (only.contains(maturityDate.name))
        ret.add(maturityDate.set(model.maturityDate));
      if (only.contains(nextPayment.name))
        ret.add(nextPayment.set(model.nextPayment));
      if (only.contains(expectedDelivery.name))
        ret.add(expectedDelivery.set(model.expectedDelivery));
      if (only.contains(orderTime.name))
        ret.add(orderTime.set(model.orderTime));
      if (only.contains(latitude.name)) ret.add(latitude.set(model.latitude));
      if (only.contains(longitude.name))
        ret.add(longitude.set(model.longitude));
      if (only.contains(synced.name)) ret.add(synced.set(model.synced));
      if (only.contains(fromServer.name))
        ret.add(fromServer.set(model.fromServer));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.sellingTotalCost != null) {
        ret.add(sellingTotalCost.set(model.sellingTotalCost));
      }
      if (model.salerId != null) {
        ret.add(salerId.set(model.salerId));
      }
      if (model.shopId != null) {
        ret.add(shopId.set(model.shopId));
      }
      if (model.visitId != null) {
        ret.add(visitId.set(model.visitId));
      }
      if (model.printedAt != null) {
        ret.add(printedAt.set(model.printedAt));
      }
      if (model.newShop != null) {
        ret.add(newShop.set(model.newShop));
      }
      if (model.orderId != null) {
        ret.add(orderId.set(model.orderId));
      }
      if (model.creditNote != null) {
        ret.add(creditNote.set(model.creditNote));
      }
      if (model.entryType != null) {
        ret.add(entryType.set(model.entryType));
      }
      if (model.appVersion != null) {
        ret.add(appVersion.set(model.appVersion));
      }
      if (model.lpoPhoto != null) {
        ret.add(lpoPhoto.set(model.lpoPhoto));
      }
      if (model.lponumber != null) {
        ret.add(lponumber.set(model.lponumber));
      }
      if (model.chequePhoto != null) {
        ret.add(chequePhoto.set(model.chequePhoto));
      }
      if (model.paymentAmount != null) {
        ret.add(paymentAmount.set(model.paymentAmount));
      }
      if (model.paymentReference != null) {
        ret.add(paymentReference.set(model.paymentReference));
      }
      if (model.paymentMethod != null) {
        ret.add(paymentMethod.set(model.paymentMethod));
      }
      if (model.paymentStatus != null) {
        ret.add(paymentStatus.set(model.paymentStatus));
      }
      if (model.totalCost != null) {
        ret.add(totalCost.set(model.totalCost));
      }
      if (model.callStatus != null) {
        ret.add(callStatus.set(model.callStatus));
      }
      if (model.channel != null) {
        ret.add(channel.set(model.channel));
      }
      if (model.orderType != null) {
        ret.add(orderType.set(model.orderType));
      }
      if (model.battery != null) {
        ret.add(battery.set(model.battery));
      }
      if (model.notes != null) {
        ret.add(notes.set(model.notes));
      }
      if (model.paymentId != null) {
        ret.add(paymentId.set(model.paymentId));
      }
      if (model.maturityDate != null) {
        ret.add(maturityDate.set(model.maturityDate));
      }
      if (model.nextPayment != null) {
        ret.add(nextPayment.set(model.nextPayment));
      }
      if (model.expectedDelivery != null) {
        ret.add(expectedDelivery.set(model.expectedDelivery));
      }
      if (model.orderTime != null) {
        ret.add(orderTime.set(model.orderTime));
      }
      if (model.latitude != null) {
        ret.add(latitude.set(model.latitude));
      }
      if (model.longitude != null) {
        ret.add(longitude.set(model.longitude));
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
    st.addDouble(sellingTotalCost.name, isNullable: true);
    st.addInt(salerId.name, isNullable: true);
    st.addInt(shopId.name, isNullable: true);
    st.addStr(visitId.name, isNullable: true);
    st.addDateTime(printedAt.name, isNullable: true);
    st.addInt(newShop.name, isNullable: true);
    st.addInt(orderId.name, isNullable: true);
    st.addStr(creditNote.name, isNullable: true);
    st.addStr(entryType.name, isNullable: true);
    st.addStr(appVersion.name, isNullable: true);
    st.addStr(lpoPhoto.name, isNullable: true);
    st.addStr(lponumber.name, isNullable: true);
    st.addStr(chequePhoto.name, isNullable: true);
    st.addDouble(paymentAmount.name, isNullable: true);
    st.addStr(paymentReference.name, isNullable: true);
    st.addStr(paymentMethod.name, isNullable: true);
    st.addStr(paymentStatus.name, isNullable: true);
    st.addDouble(totalCost.name, isNullable: true);
    st.addStr(callStatus.name, isNullable: true);
    st.addStr(channel.name, isNullable: true);
    st.addStr(orderType.name, isNullable: true);
    st.addStr(battery.name, isNullable: true);
    st.addStr(notes.name, isNullable: true);
    st.addStr(paymentId.name, isNullable: true);
    st.addDateTime(maturityDate.name, isNullable: true);
    st.addDateTime(nextPayment.name, isNullable: true);
    st.addDateTime(expectedDelivery.name, isNullable: true);
    st.addDateTime(orderTime.name, isNullable: true);
    st.addDouble(latitude.name, isNullable: true);
    st.addDouble(longitude.name, isNullable: true);
    st.addBool(synced.name, isNullable: true);
    st.addBool(fromServer.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Order model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      Order newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<Order> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Order model,
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
      Order newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<Order> models,
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

  Future<int> update(Order model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Order> models,
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

  Future<Order> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Order> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
