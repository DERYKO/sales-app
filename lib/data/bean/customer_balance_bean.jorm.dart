// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_balance_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _CustomerBalanceBean implements Bean<CustomerBalance> {
  final id = IntField('id');
  final shopId = IntField('shop_id');
  final shopName = StrField('shop_name');
  final orderId = IntField('order_id');
  final amount = StrField('amount');
  final amountpaid = StrField('amountpaid');
  final synced = BoolField('synced');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        shopId.name: shopId,
        shopName.name: shopName,
        orderId.name: orderId,
        amount.name: amount,
        amountpaid.name: amountpaid,
        synced.name: synced,
      };
  CustomerBalance fromMap(Map map) {
    CustomerBalance model = CustomerBalance();
    model.id = adapter.parseValue(map['id']);
    model.shopId = adapter.parseValue(map['shop_id']);
    model.shopName = adapter.parseValue(map['shop_name']);
    model.orderId = adapter.parseValue(map['order_id']);
    model.amount = adapter.parseValue(map['amount']);
    model.amountpaid = adapter.parseValue(map['amountpaid']);
    model.synced = adapter.parseValue(map['synced']);

    return model;
  }

  List<SetColumn> toSetColumns(CustomerBalance model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(shopId.set(model.shopId));
      ret.add(shopName.set(model.shopName));
      ret.add(orderId.set(model.orderId));
      ret.add(amount.set(model.amount));
      ret.add(amountpaid.set(model.amountpaid));
      ret.add(synced.set(model.synced));
    } else if (only != null) {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(shopId.name)) ret.add(shopId.set(model.shopId));
      if (only.contains(shopName.name)) ret.add(shopName.set(model.shopName));
      if (only.contains(orderId.name)) ret.add(orderId.set(model.orderId));
      if (only.contains(amount.name)) ret.add(amount.set(model.amount));
      if (only.contains(amountpaid.name))
        ret.add(amountpaid.set(model.amountpaid));
      if (only.contains(synced.name)) ret.add(synced.set(model.synced));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.shopId != null) {
        ret.add(shopId.set(model.shopId));
      }
      if (model.shopName != null) {
        ret.add(shopName.set(model.shopName));
      }
      if (model.orderId != null) {
        ret.add(orderId.set(model.orderId));
      }
      if (model.amount != null) {
        ret.add(amount.set(model.amount));
      }
      if (model.amountpaid != null) {
        ret.add(amountpaid.set(model.amountpaid));
      }
      if (model.synced != null) {
        ret.add(synced.set(model.synced));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, autoIncrement: true, isNullable: false);
    st.addInt(shopId.name, isNullable: true);
    st.addStr(shopName.name, isNullable: true);
    st.addInt(orderId.name, isNullable: true);
    st.addStr(amount.name, isNullable: true);
    st.addStr(amountpaid.name, isNullable: true);
    st.addBool(synced.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(CustomerBalance model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      CustomerBalance newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<CustomerBalance> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(CustomerBalance model,
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
      CustomerBalance newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<CustomerBalance> models,
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

  Future<int> update(CustomerBalance model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<CustomerBalance> models,
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

  Future<CustomerBalance> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<CustomerBalance> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
