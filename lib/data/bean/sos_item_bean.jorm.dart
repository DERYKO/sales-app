// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sos_item_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _SosItemBean implements Bean<SosItem> {
  final productId = IntField('product_id');
  final sosId = IntField('sos_id');
  final productName = StrField('product_name');
  final facings = StrField('facings');
  final length = StrField('length');
  final position = StrField('position');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        productId.name: productId,
        sosId.name: sosId,
        productName.name: productName,
        facings.name: facings,
        length.name: length,
        position.name: position,
      };
  SosItem fromMap(Map map) {
    SosItem model = SosItem();
    model.productId = adapter.parseValue(map['product_id']);
    model.sosId = adapter.parseValue(map['sos_id']);
    model.productName = adapter.parseValue(map['product_name']);
    model.facings = adapter.parseValue(map['facings']);
    model.length = adapter.parseValue(map['length']);
    model.position = adapter.parseValue(map['position']);

    return model;
  }

  List<SetColumn> toSetColumns(SosItem model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(productId.set(model.productId));
      ret.add(sosId.set(model.sosId));
      ret.add(productName.set(model.productName));
      ret.add(facings.set(model.facings));
      ret.add(length.set(model.length));
      ret.add(position.set(model.position));
    } else if (only != null) {
      if (only.contains(productId.name))
        ret.add(productId.set(model.productId));
      if (only.contains(sosId.name)) ret.add(sosId.set(model.sosId));
      if (only.contains(productName.name))
        ret.add(productName.set(model.productName));
      if (only.contains(facings.name)) ret.add(facings.set(model.facings));
      if (only.contains(length.name)) ret.add(length.set(model.length));
      if (only.contains(position.name)) ret.add(position.set(model.position));
    } else /* if (onlyNonNull) */ {
      if (model.productId != null) {
        ret.add(productId.set(model.productId));
      }
      if (model.sosId != null) {
        ret.add(sosId.set(model.sosId));
      }
      if (model.productName != null) {
        ret.add(productName.set(model.productName));
      }
      if (model.facings != null) {
        ret.add(facings.set(model.facings));
      }
      if (model.length != null) {
        ret.add(length.set(model.length));
      }
      if (model.position != null) {
        ret.add(position.set(model.position));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(productId.name, isNullable: true);
    st.addInt(sosId.name, isNullable: true);
    st.addStr(productName.name, isNullable: true);
    st.addStr(facings.name, isNullable: true);
    st.addStr(length.name, isNullable: true);
    st.addStr(position.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(SosItem model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<SosItem> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(SosItem model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<SosItem> models,
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

  Future<void> updateMany(List<SosItem> models,
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
