// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_availability_detail_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _ProductAvailabilityDetailBean
    implements Bean<ProductAvailabilityDetail> {
  final availabilityId = IntField('availability_id');
  final productId = IntField('product_id');
  final productName = StrField('product_name');
  final availabilityStatus = StrField('availability_status');
  final createdAt = DateTimeField('created_at');
  final updatedAt = DateTimeField('updated_at');
  final reason = StrField('reason');
  final notes = StrField('notes');
  final quantity = StrField('quantity');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        availabilityId.name: availabilityId,
        productId.name: productId,
        productName.name: productName,
        availabilityStatus.name: availabilityStatus,
        createdAt.name: createdAt,
        updatedAt.name: updatedAt,
        reason.name: reason,
        notes.name: notes,
        quantity.name: quantity,
      };
  ProductAvailabilityDetail fromMap(Map map) {
    ProductAvailabilityDetail model = ProductAvailabilityDetail();
    model.availabilityId = adapter.parseValue(map['availability_id']);
    model.productId = adapter.parseValue(map['product_id']);
    model.productName = adapter.parseValue(map['product_name']);
    model.availabilityStatus = adapter.parseValue(map['availability_status']);
    model.createdAt = adapter.parseValue(map['created_at']);
    model.updatedAt = adapter.parseValue(map['updated_at']);
    model.reason = adapter.parseValue(map['reason']);
    model.notes = adapter.parseValue(map['notes']);
    model.quantity = adapter.parseValue(map['quantity']);

    return model;
  }

  List<SetColumn> toSetColumns(ProductAvailabilityDetail model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(availabilityId.set(model.availabilityId));
      ret.add(productId.set(model.productId));
      ret.add(productName.set(model.productName));
      ret.add(availabilityStatus.set(model.availabilityStatus));
      ret.add(createdAt.set(model.createdAt));
      ret.add(updatedAt.set(model.updatedAt));
      ret.add(reason.set(model.reason));
      ret.add(notes.set(model.notes));
      ret.add(quantity.set(model.quantity));
    } else if (only != null) {
      if (only.contains(availabilityId.name))
        ret.add(availabilityId.set(model.availabilityId));
      if (only.contains(productId.name))
        ret.add(productId.set(model.productId));
      if (only.contains(productName.name))
        ret.add(productName.set(model.productName));
      if (only.contains(availabilityStatus.name))
        ret.add(availabilityStatus.set(model.availabilityStatus));
      if (only.contains(createdAt.name))
        ret.add(createdAt.set(model.createdAt));
      if (only.contains(updatedAt.name))
        ret.add(updatedAt.set(model.updatedAt));
      if (only.contains(reason.name)) ret.add(reason.set(model.reason));
      if (only.contains(notes.name)) ret.add(notes.set(model.notes));
      if (only.contains(quantity.name)) ret.add(quantity.set(model.quantity));
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
      if (model.createdAt != null) {
        ret.add(createdAt.set(model.createdAt));
      }
      if (model.updatedAt != null) {
        ret.add(updatedAt.set(model.updatedAt));
      }
      if (model.reason != null) {
        ret.add(reason.set(model.reason));
      }
      if (model.notes != null) {
        ret.add(notes.set(model.notes));
      }
      if (model.quantity != null) {
        ret.add(quantity.set(model.quantity));
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
    st.addDateTime(createdAt.name, isNullable: true);
    st.addDateTime(updatedAt.name, isNullable: true);
    st.addStr(reason.name, isNullable: true);
    st.addStr(notes.name, isNullable: true);
    st.addStr(quantity.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(ProductAvailabilityDetail model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<ProductAvailabilityDetail> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(ProductAvailabilityDetail model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<ProductAvailabilityDetail> models,
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

  Future<void> updateMany(List<ProductAvailabilityDetail> models,
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
