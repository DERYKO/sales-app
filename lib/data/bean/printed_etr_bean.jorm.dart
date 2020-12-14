// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'printed_etr_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _PrintedEtrBean implements Bean<PrintedEtr> {
  final orderId = IntField('order_id');
  final printedAt = DateTimeField('printed_at');
  final printedBy = IntField('printed_by');
  final synced = BoolField('synced');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        orderId.name: orderId,
        printedAt.name: printedAt,
        printedBy.name: printedBy,
        synced.name: synced,
      };
  PrintedEtr fromMap(Map map) {
    PrintedEtr model = PrintedEtr();
    model.orderId = adapter.parseValue(map['order_id']);
    model.printedAt = adapter.parseValue(map['printed_at']);
    model.printedBy = adapter.parseValue(map['printed_by']);
    model.synced = adapter.parseValue(map['synced']);

    return model;
  }

  List<SetColumn> toSetColumns(PrintedEtr model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(orderId.set(model.orderId));
      ret.add(printedAt.set(model.printedAt));
      ret.add(printedBy.set(model.printedBy));
      ret.add(synced.set(model.synced));
    } else if (only != null) {
      if (only.contains(orderId.name)) ret.add(orderId.set(model.orderId));
      if (only.contains(printedAt.name))
        ret.add(printedAt.set(model.printedAt));
      if (only.contains(printedBy.name))
        ret.add(printedBy.set(model.printedBy));
      if (only.contains(synced.name)) ret.add(synced.set(model.synced));
    } else /* if (onlyNonNull) */ {
      if (model.orderId != null) {
        ret.add(orderId.set(model.orderId));
      }
      if (model.printedAt != null) {
        ret.add(printedAt.set(model.printedAt));
      }
      if (model.printedBy != null) {
        ret.add(printedBy.set(model.printedBy));
      }
      if (model.synced != null) {
        ret.add(synced.set(model.synced));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(orderId.name, primary: true, isNullable: false);
    st.addDateTime(printedAt.name, isNullable: true);
    st.addInt(printedBy.name, isNullable: true);
    st.addBool(synced.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(PrintedEtr model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<PrintedEtr> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(PrintedEtr model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<PrintedEtr> models,
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

  Future<int> update(PrintedEtr model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.orderId.eq(model.orderId))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<PrintedEtr> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(this.orderId.eq(model.orderId));
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<PrintedEtr> find(int orderId,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.orderId.eq(orderId));
    return await findOne(find);
  }

  Future<int> remove(int orderId) async {
    final Remove remove = remover.where(this.orderId.eq(orderId));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<PrintedEtr> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.orderId.eq(model.orderId));
    }
    return adapter.remove(remove);
  }
}
