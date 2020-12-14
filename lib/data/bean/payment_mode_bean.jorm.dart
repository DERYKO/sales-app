// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_mode_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _PaymentModeBean implements Bean<PaymentMode> {
  final id = IntField('id');
  final paymentMode = StrField('payment_mode');
  final slug = StrField('slug');
  final modeDescription = StrField('mode_description');
  final status = StrField('status');
  final createdAt = DateTimeField('created_at');
  final updatedAt = DateTimeField('updated_at');
  final deletedAt = DateTimeField('deleted_at');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        paymentMode.name: paymentMode,
        slug.name: slug,
        modeDescription.name: modeDescription,
        status.name: status,
        createdAt.name: createdAt,
        updatedAt.name: updatedAt,
        deletedAt.name: deletedAt,
      };
  PaymentMode fromMap(Map map) {
    PaymentMode model = PaymentMode();
    model.id = adapter.parseValue(map['id']);
    model.paymentMode = adapter.parseValue(map['payment_mode']);
    model.slug = adapter.parseValue(map['slug']);
    model.modeDescription = adapter.parseValue(map['mode_description']);
    model.status = adapter.parseValue(map['status']);
    model.createdAt = adapter.parseValue(map['created_at']);
    model.updatedAt = adapter.parseValue(map['updated_at']);
    model.deletedAt = adapter.parseValue(map['deleted_at']);

    return model;
  }

  List<SetColumn> toSetColumns(PaymentMode model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(id.set(model.id));
      ret.add(paymentMode.set(model.paymentMode));
      ret.add(slug.set(model.slug));
      ret.add(modeDescription.set(model.modeDescription));
      ret.add(status.set(model.status));
      ret.add(createdAt.set(model.createdAt));
      ret.add(updatedAt.set(model.updatedAt));
      ret.add(deletedAt.set(model.deletedAt));
    } else if (only != null) {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(paymentMode.name))
        ret.add(paymentMode.set(model.paymentMode));
      if (only.contains(slug.name)) ret.add(slug.set(model.slug));
      if (only.contains(modeDescription.name))
        ret.add(modeDescription.set(model.modeDescription));
      if (only.contains(status.name)) ret.add(status.set(model.status));
      if (only.contains(createdAt.name))
        ret.add(createdAt.set(model.createdAt));
      if (only.contains(updatedAt.name))
        ret.add(updatedAt.set(model.updatedAt));
      if (only.contains(deletedAt.name))
        ret.add(deletedAt.set(model.deletedAt));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.paymentMode != null) {
        ret.add(paymentMode.set(model.paymentMode));
      }
      if (model.slug != null) {
        ret.add(slug.set(model.slug));
      }
      if (model.modeDescription != null) {
        ret.add(modeDescription.set(model.modeDescription));
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
      if (model.deletedAt != null) {
        ret.add(deletedAt.set(model.deletedAt));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, isNullable: false);
    st.addStr(paymentMode.name, isNullable: true);
    st.addStr(slug.name, isNullable: true);
    st.addStr(modeDescription.name, isNullable: true);
    st.addStr(status.name, isNullable: true);
    st.addDateTime(createdAt.name, isNullable: true);
    st.addDateTime(updatedAt.name, isNullable: true);
    st.addDateTime(deletedAt.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(PaymentMode model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<PaymentMode> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(PaymentMode model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<PaymentMode> models,
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

  Future<int> update(PaymentMode model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<PaymentMode> models,
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

  Future<PaymentMode> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<PaymentMode> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
