// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'availability_item_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _AvailabilityItemBean implements Bean<AvailabilityItem> {
  final availabilityId = IntField('availability_id');
  final productId = IntField('product_id');
  final productName = StrField('product_name');
  final availabilityStatus = StrField('availability_status');
  final availabilityReason = StrField('availability_reason');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        availabilityId.name: availabilityId,
        productId.name: productId,
        productName.name: productName,
        availabilityStatus.name: availabilityStatus,
        availabilityReason.name: availabilityReason,
      };
  AvailabilityItem fromMap(Map map) {
    AvailabilityItem model = AvailabilityItem();
    model.availabilityId = adapter.parseValue(map['availability_id']);
    model.productId = adapter.parseValue(map['product_id']);
    model.productName = adapter.parseValue(map['product_name']);
    model.availabilityStatus = adapter.parseValue(map['availability_status']);
    model.availabilityReason = adapter.parseValue(map['availability_reason']);

    return model;
  }

  List<SetColumn> toSetColumns(AvailabilityItem model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(availabilityId.set(model.availabilityId));
      ret.add(productId.set(model.productId));
      ret.add(productName.set(model.productName));
      ret.add(availabilityStatus.set(model.availabilityStatus));
      ret.add(availabilityReason.set(model.availabilityReason));
    } else if (only != null) {
      if (only.contains(availabilityId.name))
        ret.add(availabilityId.set(model.availabilityId));
      if (only.contains(productId.name))
        ret.add(productId.set(model.productId));
      if (only.contains(productName.name))
        ret.add(productName.set(model.productName));
      if (only.contains(availabilityStatus.name))
        ret.add(availabilityStatus.set(model.availabilityStatus));
      if (only.contains(availabilityReason.name))
        ret.add(availabilityReason.set(model.availabilityReason));
    } else /* if (onlyNonNull) */ {
      if (model.availabilityId != null) {
        ret.add(availabilityId.set(model.availabilityId));
      }
      if (model.productId != null) {
        ret.add(productId.set(model.productId));
      }
      if (model.productName != null) {
        ret.add(productName.set(model.productName));
      }
      if (model.availabilityStatus != null) {
        ret.add(availabilityStatus.set(model.availabilityStatus));
      }
      if (model.availabilityReason != null) {
        ret.add(availabilityReason.set(model.availabilityReason));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(availabilityId.name, isNullable: true);
    st.addInt(productId.name, isNullable: true);
    st.addStr(productName.name, isNullable: true);
    st.addStr(availabilityStatus.name, isNullable: true);
    st.addStr(availabilityReason.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(AvailabilityItem model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<AvailabilityItem> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(AvailabilityItem model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<AvailabilityItem> models,
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

  Future<void> updateMany(List<AvailabilityItem> models,
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
