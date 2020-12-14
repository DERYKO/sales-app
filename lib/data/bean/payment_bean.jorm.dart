// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _PaymentBean implements Bean<Payment> {
  final collectionId = IntField('collection_id');
  final outletId = StrField('outlet_id');
  final shopName = StrField('shop_name');
  final paymentMethod = StrField('payment_method');
  final amountPaid = StrField('amount_paid');
  final paymentRef = StrField('payment_ref');
  final chequePhoto = StrField('cheque_photo');
  final recordTime = DateTimeField('record_time');
  final banked = DateTimeField('banked');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        collectionId.name: collectionId,
        outletId.name: outletId,
        shopName.name: shopName,
        paymentMethod.name: paymentMethod,
        amountPaid.name: amountPaid,
        paymentRef.name: paymentRef,
        chequePhoto.name: chequePhoto,
        recordTime.name: recordTime,
        banked.name: banked,
      };
  Payment fromMap(Map map) {
    Payment model = Payment();
    model.collectionId = adapter.parseValue(map['collection_id']);
    model.outletId = adapter.parseValue(map['outlet_id']);
    model.shopName = adapter.parseValue(map['shop_name']);
    model.paymentMethod = adapter.parseValue(map['payment_method']);
    model.amountPaid = adapter.parseValue(map['amount_paid']);
    model.paymentRef = adapter.parseValue(map['payment_ref']);
    model.chequePhoto = adapter.parseValue(map['cheque_photo']);
    model.recordTime = adapter.parseValue(map['record_time']);
    model.banked = adapter.parseValue(map['banked']);

    return model;
  }

  List<SetColumn> toSetColumns(Payment model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(collectionId.set(model.collectionId));
      ret.add(outletId.set(model.outletId));
      ret.add(shopName.set(model.shopName));
      ret.add(paymentMethod.set(model.paymentMethod));
      ret.add(amountPaid.set(model.amountPaid));
      ret.add(paymentRef.set(model.paymentRef));
      ret.add(chequePhoto.set(model.chequePhoto));
      ret.add(recordTime.set(model.recordTime));
      ret.add(banked.set(model.banked));
    } else if (only != null) {
      if (only.contains(collectionId.name))
        ret.add(collectionId.set(model.collectionId));
      if (only.contains(outletId.name)) ret.add(outletId.set(model.outletId));
      if (only.contains(shopName.name)) ret.add(shopName.set(model.shopName));
      if (only.contains(paymentMethod.name))
        ret.add(paymentMethod.set(model.paymentMethod));
      if (only.contains(amountPaid.name))
        ret.add(amountPaid.set(model.amountPaid));
      if (only.contains(paymentRef.name))
        ret.add(paymentRef.set(model.paymentRef));
      if (only.contains(chequePhoto.name))
        ret.add(chequePhoto.set(model.chequePhoto));
      if (only.contains(recordTime.name))
        ret.add(recordTime.set(model.recordTime));
      if (only.contains(banked.name)) ret.add(banked.set(model.banked));
    } else /* if (onlyNonNull) */ {
      if (model.collectionId != null) {
        ret.add(collectionId.set(model.collectionId));
      }
      if (model.outletId != null) {
        ret.add(outletId.set(model.outletId));
      }
      if (model.shopName != null) {
        ret.add(shopName.set(model.shopName));
      }
      if (model.paymentMethod != null) {
        ret.add(paymentMethod.set(model.paymentMethod));
      }
      if (model.amountPaid != null) {
        ret.add(amountPaid.set(model.amountPaid));
      }
      if (model.paymentRef != null) {
        ret.add(paymentRef.set(model.paymentRef));
      }
      if (model.chequePhoto != null) {
        ret.add(chequePhoto.set(model.chequePhoto));
      }
      if (model.recordTime != null) {
        ret.add(recordTime.set(model.recordTime));
      }
      if (model.banked != null) {
        ret.add(banked.set(model.banked));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(collectionId.name, primary: true, isNullable: false);
    st.addStr(outletId.name, isNullable: true);
    st.addStr(shopName.name, isNullable: true);
    st.addStr(paymentMethod.name, isNullable: true);
    st.addStr(amountPaid.name, isNullable: true);
    st.addStr(paymentRef.name, isNullable: true);
    st.addStr(chequePhoto.name, isNullable: true);
    st.addDateTime(recordTime.name, isNullable: true);
    st.addDateTime(banked.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Payment model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<Payment> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Payment model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<Payment> models,
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

  Future<int> update(Payment model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.collectionId.eq(model.collectionId))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Payment> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(this.collectionId.eq(model.collectionId));
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<Payment> find(int collectionId,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.collectionId.eq(collectionId));
    return await findOne(find);
  }

  Future<int> remove(int collectionId) async {
    final Remove remove = remover.where(this.collectionId.eq(collectionId));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Payment> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.collectionId.eq(model.collectionId));
    }
    return adapter.remove(remove);
  }
}
