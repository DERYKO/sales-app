// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _BankBean implements Bean<Bank> {
  final id = IntField('id');
  final bankName = StrField('bank_name');
  final bankCode = StrField('bank_code');
  final accountNumber = IntField('account_number');
  final accountName = StrField('account_name');
  final branchName = StrField('branch_name');
  final status = StrField('status');
  final createdAt = DateTimeField('created_at');
  final updatedAt = DateTimeField('updated_at');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        bankName.name: bankName,
        bankCode.name: bankCode,
        accountNumber.name: accountNumber,
        accountName.name: accountName,
        branchName.name: branchName,
        status.name: status,
        createdAt.name: createdAt,
        updatedAt.name: updatedAt,
      };
  Bank fromMap(Map map) {
    Bank model = Bank();
    model.id = adapter.parseValue(map['id']);
    model.bankName = adapter.parseValue(map['bank_name']);
    model.bankCode = adapter.parseValue(map['bank_code']);
    model.accountNumber = adapter.parseValue(map['account_number']);
    model.accountName = adapter.parseValue(map['account_name']);
    model.branchName = adapter.parseValue(map['branch_name']);
    model.status = adapter.parseValue(map['status']);
    model.createdAt = adapter.parseValue(map['created_at']);
    model.updatedAt = adapter.parseValue(map['updated_at']);

    return model;
  }

  List<SetColumn> toSetColumns(Bank model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(bankName.set(model.bankName));
      ret.add(bankCode.set(model.bankCode));
      ret.add(accountNumber.set(model.accountNumber));
      ret.add(accountName.set(model.accountName));
      ret.add(branchName.set(model.branchName));
      ret.add(status.set(model.status));
      ret.add(createdAt.set(model.createdAt));
      ret.add(updatedAt.set(model.updatedAt));
    } else if (only != null) {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(bankName.name)) ret.add(bankName.set(model.bankName));
      if (only.contains(bankCode.name)) ret.add(bankCode.set(model.bankCode));
      if (only.contains(accountNumber.name))
        ret.add(accountNumber.set(model.accountNumber));
      if (only.contains(accountName.name))
        ret.add(accountName.set(model.accountName));
      if (only.contains(branchName.name))
        ret.add(branchName.set(model.branchName));
      if (only.contains(status.name)) ret.add(status.set(model.status));
      if (only.contains(createdAt.name))
        ret.add(createdAt.set(model.createdAt));
      if (only.contains(updatedAt.name))
        ret.add(updatedAt.set(model.updatedAt));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.bankName != null) {
        ret.add(bankName.set(model.bankName));
      }
      if (model.bankCode != null) {
        ret.add(bankCode.set(model.bankCode));
      }
      if (model.accountNumber != null) {
        ret.add(accountNumber.set(model.accountNumber));
      }
      if (model.accountName != null) {
        ret.add(accountName.set(model.accountName));
      }
      if (model.branchName != null) {
        ret.add(branchName.set(model.branchName));
      }
      if (model.status != null) {
        ret.add(status.set(model.status));
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
    st.addInt(id.name, primary: true, autoIncrement: true, isNullable: false);
    st.addStr(bankName.name, isNullable: true);
    st.addStr(bankCode.name, isNullable: true);
    st.addInt(accountNumber.name, isNullable: true);
    st.addStr(accountName.name, isNullable: true);
    st.addStr(branchName.name, isNullable: true);
    st.addStr(status.name, isNullable: true);
    st.addDateTime(createdAt.name, isNullable: true);
    st.addDateTime(updatedAt.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Bank model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      Bank newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<Bank> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Bank model,
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
      Bank newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<Bank> models,
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

  Future<int> update(Bank model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Bank> models,
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

  Future<Bank> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Bank> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
