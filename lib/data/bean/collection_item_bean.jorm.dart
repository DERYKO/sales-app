// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_item_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _CollectionItemBean implements Bean<CollectionItem> {
  final collectionId = IntField('collection_id');
  final invoiceId = IntField('invoice_id');
  final amount = DoubleField('amount');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        collectionId.name: collectionId,
        invoiceId.name: invoiceId,
        amount.name: amount,
      };
  CollectionItem fromMap(Map map) {
    CollectionItem model = CollectionItem();
    model.collectionId = adapter.parseValue(map['collection_id']);
    model.invoiceId = adapter.parseValue(map['invoice_id']);
    model.amount = adapter.parseValue(map['amount']);

    return model;
  }

  List<SetColumn> toSetColumns(CollectionItem model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(collectionId.set(model.collectionId));
      ret.add(invoiceId.set(model.invoiceId));
      ret.add(amount.set(model.amount));
    } else if (only != null) {
      if (only.contains(collectionId.name))
        ret.add(collectionId.set(model.collectionId));
      if (only.contains(invoiceId.name))
        ret.add(invoiceId.set(model.invoiceId));
      if (only.contains(amount.name)) ret.add(amount.set(model.amount));
    } else /* if (onlyNonNull) */ {
      if (model.collectionId != null) {
        ret.add(collectionId.set(model.collectionId));
      }
      if (model.invoiceId != null) {
        ret.add(invoiceId.set(model.invoiceId));
      }
      if (model.amount != null) {
        ret.add(amount.set(model.amount));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(collectionId.name, isNullable: true);
    st.addInt(invoiceId.name, isNullable: true);
    st.addDouble(amount.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(CollectionItem model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<CollectionItem> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(CollectionItem model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<CollectionItem> models,
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

  Future<void> updateMany(List<CollectionItem> models,
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
