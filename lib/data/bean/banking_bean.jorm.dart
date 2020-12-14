// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banking_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _BankingBean implements Bean<Banking> {
  final id = IntField('id');
  final userId = IntField('user_id');
  final entryType = StrField('entry_type');
  final collectionId = IntField('collection_id');
  final customerId = IntField('customer_id');
  final bankId = IntField('bank_id');
  final amount = StrField('amount');
  final slipPhoto = StrField('slip_photo');
  final bankName = StrField('bank_name');
  final accountNumber = IntField('account_number');
  final branchName = StrField('branch_name');
  final entryTime = DateTimeField('entry_time');
  final latitude = StrField('latitude');
  final longitude = StrField('longitude');
  final notes = StrField('notes');
  final synced = BoolField('synced');
  final fromServer = BoolField('from_server');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        userId.name: userId,
        entryType.name: entryType,
        collectionId.name: collectionId,
        customerId.name: customerId,
        bankId.name: bankId,
        amount.name: amount,
        slipPhoto.name: slipPhoto,
        bankName.name: bankName,
        accountNumber.name: accountNumber,
        branchName.name: branchName,
        entryTime.name: entryTime,
        latitude.name: latitude,
        longitude.name: longitude,
        notes.name: notes,
        synced.name: synced,
        fromServer.name: fromServer,
      };
  Banking fromMap(Map map) {
    Banking model = Banking();
    model.id = adapter.parseValue(map['id']);
    model.userId = adapter.parseValue(map['user_id']);
    model.entryType = adapter.parseValue(map['entry_type']);
    model.collectionId = adapter.parseValue(map['collection_id']);
    model.customerId = adapter.parseValue(map['customer_id']);
    model.bankId = adapter.parseValue(map['bank_id']);
    model.amount = adapter.parseValue(map['amount']);
    model.slipPhoto = adapter.parseValue(map['slip_photo']);
    model.bankName = adapter.parseValue(map['bank_name']);
    model.accountNumber = adapter.parseValue(map['account_number']);
    model.branchName = adapter.parseValue(map['branch_name']);
    model.entryTime = adapter.parseValue(map['entry_time']);
    model.latitude = adapter.parseValue(map['latitude']);
    model.longitude = adapter.parseValue(map['longitude']);
    model.notes = adapter.parseValue(map['notes']);
    model.synced = adapter.parseValue(map['synced']);
    model.fromServer = adapter.parseValue(map['from_server']);

    return model;
  }

  List<SetColumn> toSetColumns(Banking model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(userId.set(model.userId));
      ret.add(entryType.set(model.entryType));
      ret.add(collectionId.set(model.collectionId));
      ret.add(customerId.set(model.customerId));
      ret.add(bankId.set(model.bankId));
      ret.add(amount.set(model.amount));
      ret.add(slipPhoto.set(model.slipPhoto));
      ret.add(bankName.set(model.bankName));
      ret.add(accountNumber.set(model.accountNumber));
      ret.add(branchName.set(model.branchName));
      ret.add(entryTime.set(model.entryTime));
      ret.add(latitude.set(model.latitude));
      ret.add(longitude.set(model.longitude));
      ret.add(notes.set(model.notes));
      ret.add(synced.set(model.synced));
      ret.add(fromServer.set(model.fromServer));
    } else if (only != null) {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(userId.name)) ret.add(userId.set(model.userId));
      if (only.contains(entryType.name))
        ret.add(entryType.set(model.entryType));
      if (only.contains(collectionId.name))
        ret.add(collectionId.set(model.collectionId));
      if (only.contains(customerId.name))
        ret.add(customerId.set(model.customerId));
      if (only.contains(bankId.name)) ret.add(bankId.set(model.bankId));
      if (only.contains(amount.name)) ret.add(amount.set(model.amount));
      if (only.contains(slipPhoto.name))
        ret.add(slipPhoto.set(model.slipPhoto));
      if (only.contains(bankName.name)) ret.add(bankName.set(model.bankName));
      if (only.contains(accountNumber.name))
        ret.add(accountNumber.set(model.accountNumber));
      if (only.contains(branchName.name))
        ret.add(branchName.set(model.branchName));
      if (only.contains(entryTime.name))
        ret.add(entryTime.set(model.entryTime));
      if (only.contains(latitude.name)) ret.add(latitude.set(model.latitude));
      if (only.contains(longitude.name))
        ret.add(longitude.set(model.longitude));
      if (only.contains(notes.name)) ret.add(notes.set(model.notes));
      if (only.contains(synced.name)) ret.add(synced.set(model.synced));
      if (only.contains(fromServer.name))
        ret.add(fromServer.set(model.fromServer));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.userId != null) {
        ret.add(userId.set(model.userId));
      }
      if (model.entryType != null) {
        ret.add(entryType.set(model.entryType));
      }
      if (model.collectionId != null) {
        ret.add(collectionId.set(model.collectionId));
      }
      if (model.customerId != null) {
        ret.add(customerId.set(model.customerId));
      }
      if (model.bankId != null) {
        ret.add(bankId.set(model.bankId));
      }
      if (model.amount != null) {
        ret.add(amount.set(model.amount));
      }
      if (model.slipPhoto != null) {
        ret.add(slipPhoto.set(model.slipPhoto));
      }
      if (model.bankName != null) {
        ret.add(bankName.set(model.bankName));
      }
      if (model.accountNumber != null) {
        ret.add(accountNumber.set(model.accountNumber));
      }
      if (model.branchName != null) {
        ret.add(branchName.set(model.branchName));
      }
      if (model.entryTime != null) {
        ret.add(entryTime.set(model.entryTime));
      }
      if (model.latitude != null) {
        ret.add(latitude.set(model.latitude));
      }
      if (model.longitude != null) {
        ret.add(longitude.set(model.longitude));
      }
      if (model.notes != null) {
        ret.add(notes.set(model.notes));
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
    st.addInt(userId.name, isNullable: true);
    st.addStr(entryType.name, isNullable: true);
    st.addInt(collectionId.name, isNullable: true);
    st.addInt(customerId.name, isNullable: true);
    st.addInt(bankId.name, isNullable: true);
    st.addStr(amount.name, isNullable: true);
    st.addStr(slipPhoto.name, isNullable: true);
    st.addStr(bankName.name, isNullable: true);
    st.addInt(accountNumber.name, isNullable: true);
    st.addStr(branchName.name, isNullable: true);
    st.addDateTime(entryTime.name, isNullable: true);
    st.addStr(latitude.name, isNullable: true);
    st.addStr(longitude.name, isNullable: true);
    st.addStr(notes.name, isNullable: true);
    st.addBool(synced.name, isNullable: true);
    st.addBool(fromServer.name, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Banking model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      Banking newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<Banking> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Banking model,
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
      Banking newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<Banking> models,
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

  Future<int> update(Banking model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Banking> models,
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

  Future<Banking> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Banking> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
