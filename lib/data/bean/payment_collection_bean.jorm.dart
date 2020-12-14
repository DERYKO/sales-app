// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_collection_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _PaymentCollectionBean implements Bean<PaymentCollection> {
  final id = IntField('id');
  final shopId = IntField('shop_id');
  final salerId = IntField('saler_id');
  final appVersion = StrField('app_version');
  final battery = StrField('battery');
  final paymentAmount = DoubleField('payment_amount');
  final paymentMethod = StrField('payment_method');
  final paymentStatus = StrField('payment_status');
  final paymentId = StrField('payment_id');
  final paymentReference = StrField('payment_reference');
  final notes = StrField('notes');
  final chequePhoto = StrField('cheque_photo');
  final maturityDate = DateTimeField('maturity_date');
  final nextPayment = DateTimeField('next_payment');
  final paymentTime = DateTimeField('payment_time');
  final latitude = DoubleField('latitude');
  final longitude = DoubleField('longitude');
  final synced = BoolField('synced');
  final fromServer = BoolField('from_server');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        shopId.name: shopId,
        salerId.name: salerId,
        appVersion.name: appVersion,
        battery.name: battery,
        paymentAmount.name: paymentAmount,
        paymentMethod.name: paymentMethod,
        paymentStatus.name: paymentStatus,
        paymentId.name: paymentId,
        paymentReference.name: paymentReference,
        notes.name: notes,
        chequePhoto.name: chequePhoto,
        maturityDate.name: maturityDate,
        nextPayment.name: nextPayment,
        paymentTime.name: paymentTime,
        latitude.name: latitude,
        longitude.name: longitude,
        synced.name: synced,
        fromServer.name: fromServer,
      };
  PaymentCollection fromMap(Map map) {
    PaymentCollection model = PaymentCollection();
    model.id = adapter.parseValue(map['id']);
    model.shopId = adapter.parseValue(map['shop_id']);
    model.salerId = adapter.parseValue(map['saler_id']);
    model.appVersion = adapter.parseValue(map['app_version']);
    model.battery = adapter.parseValue(map['battery']);
    model.paymentAmount = adapter.parseValue(map['payment_amount']);
    model.paymentMethod = adapter.parseValue(map['payment_method']);
    model.paymentStatus = adapter.parseValue(map['payment_status']);
    model.paymentId = adapter.parseValue(map['payment_id']);
    model.paymentReference = adapter.parseValue(map['payment_reference']);
    model.notes = adapter.parseValue(map['notes']);
    model.chequePhoto = adapter.parseValue(map['cheque_photo']);
    model.maturityDate = adapter.parseValue(map['maturity_date']);
    model.nextPayment = adapter.parseValue(map['next_payment']);
    model.paymentTime = adapter.parseValue(map['payment_time']);
    model.latitude = adapter.parseValue(map['latitude']);
    model.longitude = adapter.parseValue(map['longitude']);
    model.synced = adapter.parseValue(map['synced']);
    model.fromServer = adapter.parseValue(map['from_server']);

    return model;
  }

  List<SetColumn> toSetColumns(PaymentCollection model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(shopId.set(model.shopId));
      ret.add(salerId.set(model.salerId));
      ret.add(appVersion.set(model.appVersion));
      ret.add(battery.set(model.battery));
      ret.add(paymentAmount.set(model.paymentAmount));
      ret.add(paymentMethod.set(model.paymentMethod));
      ret.add(paymentStatus.set(model.paymentStatus));
      ret.add(paymentId.set(model.paymentId));
      ret.add(paymentReference.set(model.paymentReference));
      ret.add(notes.set(model.notes));
      ret.add(chequePhoto.set(model.chequePhoto));
      ret.add(maturityDate.set(model.maturityDate));
      ret.add(nextPayment.set(model.nextPayment));
      ret.add(paymentTime.set(model.paymentTime));
      ret.add(latitude.set(model.latitude));
      ret.add(longitude.set(model.longitude));
      ret.add(synced.set(model.synced));
      ret.add(fromServer.set(model.fromServer));
    } else if (only != null) {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(shopId.name)) ret.add(shopId.set(model.shopId));
      if (only.contains(salerId.name)) ret.add(salerId.set(model.salerId));
      if (only.contains(appVersion.name))
        ret.add(appVersion.set(model.appVersion));
      if (only.contains(battery.name)) ret.add(battery.set(model.battery));
      if (only.contains(paymentAmount.name))
        ret.add(paymentAmount.set(model.paymentAmount));
      if (only.contains(paymentMethod.name))
        ret.add(paymentMethod.set(model.paymentMethod));
      if (only.contains(paymentStatus.name))
        ret.add(paymentStatus.set(model.paymentStatus));
      if (only.contains(paymentId.name))
        ret.add(paymentId.set(model.paymentId));
      if (only.contains(paymentReference.name))
        ret.add(paymentReference.set(model.paymentReference));
      if (only.contains(notes.name)) ret.add(notes.set(model.notes));
      if (only.contains(chequePhoto.name))
        ret.add(chequePhoto.set(model.chequePhoto));
      if (only.contains(maturityDate.name))
        ret.add(maturityDate.set(model.maturityDate));
      if (only.contains(nextPayment.name))
        ret.add(nextPayment.set(model.nextPayment));
      if (only.contains(paymentTime.name))
        ret.add(paymentTime.set(model.paymentTime));
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
      if (model.shopId != null) {
        ret.add(shopId.set(model.shopId));
      }
      if (model.salerId != null) {
        ret.add(salerId.set(model.salerId));
      }
      if (model.appVersion != null) {
        ret.add(appVersion.set(model.appVersion));
      }
      if (model.battery != null) {
        ret.add(battery.set(model.battery));
      }
      if (model.paymentAmount != null) {
        ret.add(paymentAmount.set(model.paymentAmount));
      }
      if (model.paymentMethod != null) {
        ret.add(paymentMethod.set(model.paymentMethod));
      }
      if (model.paymentStatus != null) {
        ret.add(paymentStatus.set(model.paymentStatus));
      }
      if (model.paymentId != null) {
        ret.add(paymentId.set(model.paymentId));
      }
      if (model.paymentReference != null) {
        ret.add(paymentReference.set(model.paymentReference));
      }
      if (model.notes != null) {
        ret.add(notes.set(model.notes));
      }
      if (model.chequePhoto != null) {
        ret.add(chequePhoto.set(model.chequePhoto));
      }
      if (model.maturityDate != null) {
        ret.add(maturityDate.set(model.maturityDate));
      }
      if (model.nextPayment != null) {
        ret.add(nextPayment.set(model.nextPayment));
      }
      if (model.paymentTime != null) {
        ret.add(paymentTime.set(model.paymentTime));
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
    st.addInt(shopId.name, isNullable: true);
    st.addInt(salerId.name, isNullable: true);
    st.addStr(appVersion.name, isNullable: true);
    st.addStr(battery.name, isNullable: true);
    st.addDouble(paymentAmount.name, isNullable: true);
    st.addStr(paymentMethod.name, isNullable: true);
    st.addStr(paymentStatus.name, isNullable: true);
    st.addStr(paymentId.name, isNullable: true);
    st.addStr(paymentReference.name, isNullable: true);
    st.addStr(notes.name, isNullable: true);
    st.addStr(chequePhoto.name, isNullable: true);
    st.addDateTime(maturityDate.name, isNullable: true);
    st.addDateTime(nextPayment.name, isNullable: true);
    st.addDateTime(paymentTime.name, isNullable: true);
    st.addDouble(latitude.name, isNullable: true);
    st.addDouble(longitude.name, isNullable: true);
    st.addBool(synced.name, isNullable: false);
    st.addBool(fromServer.name, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(PaymentCollection model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      PaymentCollection newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<PaymentCollection> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(PaymentCollection model,
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
      PaymentCollection newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<PaymentCollection> models,
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

  Future<int> update(PaymentCollection model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<PaymentCollection> models,
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

  Future<PaymentCollection> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<PaymentCollection> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
