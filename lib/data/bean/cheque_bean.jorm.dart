// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cheque_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _ChequeBean implements Bean<Cheque> {
  final outletId = StrField('outlet_id');
  final amountPaid = StrField('amount_paid');
  final paymentRef = StrField('payment_ref');
  final maturityDate = DateTimeField('maturity_date');
  final chequePhoto = StrField('cheque_photo');
  final nextPayment = StrField('next_payment');
  final notes = StrField('notes');
  final collectionId = IntField('collection_id');
  final latitude = StrField('latitude');
  final longitude = StrField('longitude');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        outletId.name: outletId,
        amountPaid.name: amountPaid,
        paymentRef.name: paymentRef,
        maturityDate.name: maturityDate,
        chequePhoto.name: chequePhoto,
        nextPayment.name: nextPayment,
        notes.name: notes,
        collectionId.name: collectionId,
        latitude.name: latitude,
        longitude.name: longitude,
      };
  Cheque fromMap(Map map) {
    Cheque model = Cheque();
    model.outletId = adapter.parseValue(map['outlet_id']);
    model.amountPaid = adapter.parseValue(map['amount_paid']);
    model.paymentRef = adapter.parseValue(map['payment_ref']);
    model.maturityDate = adapter.parseValue(map['maturity_date']);
    model.chequePhoto = adapter.parseValue(map['cheque_photo']);
    model.nextPayment = adapter.parseValue(map['next_payment']);
    model.notes = adapter.parseValue(map['notes']);
    model.collectionId = adapter.parseValue(map['collection_id']);
    model.latitude = adapter.parseValue(map['latitude']);
    model.longitude = adapter.parseValue(map['longitude']);

    return model;
  }

  List<SetColumn> toSetColumns(Cheque model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(outletId.set(model.outletId));
      ret.add(amountPaid.set(model.amountPaid));
      ret.add(paymentRef.set(model.paymentRef));
      ret.add(maturityDate.set(model.maturityDate));
      ret.add(chequePhoto.set(model.chequePhoto));
      ret.add(nextPayment.set(model.nextPayment));
      ret.add(notes.set(model.notes));
      ret.add(collectionId.set(model.collectionId));
      ret.add(latitude.set(model.latitude));
      ret.add(longitude.set(model.longitude));
    } else if (only != null) {
      if (only.contains(outletId.name)) ret.add(outletId.set(model.outletId));
      if (only.contains(amountPaid.name))
        ret.add(amountPaid.set(model.amountPaid));
      if (only.contains(paymentRef.name))
        ret.add(paymentRef.set(model.paymentRef));
      if (only.contains(maturityDate.name))
        ret.add(maturityDate.set(model.maturityDate));
      if (only.contains(chequePhoto.name))
        ret.add(chequePhoto.set(model.chequePhoto));
      if (only.contains(nextPayment.name))
        ret.add(nextPayment.set(model.nextPayment));
      if (only.contains(notes.name)) ret.add(notes.set(model.notes));
      if (only.contains(collectionId.name))
        ret.add(collectionId.set(model.collectionId));
      if (only.contains(latitude.name)) ret.add(latitude.set(model.latitude));
      if (only.contains(longitude.name))
        ret.add(longitude.set(model.longitude));
    } else /* if (onlyNonNull) */ {
      if (model.outletId != null) {
        ret.add(outletId.set(model.outletId));
      }
      if (model.amountPaid != null) {
        ret.add(amountPaid.set(model.amountPaid));
      }
      if (model.paymentRef != null) {
        ret.add(paymentRef.set(model.paymentRef));
      }
      if (model.maturityDate != null) {
        ret.add(maturityDate.set(model.maturityDate));
      }
      if (model.chequePhoto != null) {
        ret.add(chequePhoto.set(model.chequePhoto));
      }
      if (model.nextPayment != null) {
        ret.add(nextPayment.set(model.nextPayment));
      }
      if (model.notes != null) {
        ret.add(notes.set(model.notes));
      }
      if (model.collectionId != null) {
        ret.add(collectionId.set(model.collectionId));
      }
      if (model.latitude != null) {
        ret.add(latitude.set(model.latitude));
      }
      if (model.longitude != null) {
        ret.add(longitude.set(model.longitude));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addStr(outletId.name, primary: true, isNullable: false);
    st.addStr(amountPaid.name, isNullable: true);
    st.addStr(paymentRef.name, isNullable: true);
    st.addDateTime(maturityDate.name, isNullable: true);
    st.addStr(chequePhoto.name, isNullable: true);
    st.addStr(nextPayment.name, isNullable: true);
    st.addStr(notes.name, isNullable: true);
    st.addInt(collectionId.name, isNullable: true);
    st.addStr(latitude.name, isNullable: true);
    st.addStr(longitude.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Cheque model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<Cheque> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Cheque model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<Cheque> models,
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

  Future<int> update(Cheque model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.outletId.eq(model.outletId))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Cheque> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(this.outletId.eq(model.outletId));
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<Cheque> find(String outletId,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.outletId.eq(outletId));
    return await findOne(find);
  }

  Future<int> remove(String outletId) async {
    final Remove remove = remover.where(this.outletId.eq(outletId));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Cheque> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.outletId.eq(model.outletId));
    }
    return adapter.remove(remove);
  }
}
