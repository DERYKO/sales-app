// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _BrandBean implements Bean<Brand> {
  final id = IntField('id');
  final category = StrField('category');
  final brand = StrField('brand');
  final companyId = IntField('company_id');
  final company = StrField('company');
  final iscompetitor = StrField('iscompetitor');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        category.name: category,
        brand.name: brand,
        companyId.name: companyId,
        company.name: company,
        iscompetitor.name: iscompetitor,
      };
  Brand fromMap(Map map) {
    Brand model = Brand();
    model.id = adapter.parseValue(map['id']);
    model.category = adapter.parseValue(map['category']);
    model.brand = adapter.parseValue(map['brand']);
    model.companyId = adapter.parseValue(map['company_id']);
    model.company = adapter.parseValue(map['company']);
    model.iscompetitor = adapter.parseValue(map['iscompetitor']);

    return model;
  }

  List<SetColumn> toSetColumns(Brand model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(id.set(model.id));
      ret.add(category.set(model.category));
      ret.add(brand.set(model.brand));
      ret.add(companyId.set(model.companyId));
      ret.add(company.set(model.company));
      ret.add(iscompetitor.set(model.iscompetitor));
    } else if (only != null) {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(category.name)) ret.add(category.set(model.category));
      if (only.contains(brand.name)) ret.add(brand.set(model.brand));
      if (only.contains(companyId.name))
        ret.add(companyId.set(model.companyId));
      if (only.contains(company.name)) ret.add(company.set(model.company));
      if (only.contains(iscompetitor.name))
        ret.add(iscompetitor.set(model.iscompetitor));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.category != null) {
        ret.add(category.set(model.category));
      }
      if (model.brand != null) {
        ret.add(brand.set(model.brand));
      }
      if (model.companyId != null) {
        ret.add(companyId.set(model.companyId));
      }
      if (model.company != null) {
        ret.add(company.set(model.company));
      }
      if (model.iscompetitor != null) {
        ret.add(iscompetitor.set(model.iscompetitor));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, isNullable: false);
    st.addStr(category.name, isNullable: true);
    st.addStr(brand.name, isNullable: true);
    st.addInt(companyId.name, isNullable: true);
    st.addStr(company.name, isNullable: true);
    st.addStr(iscompetitor.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Brand model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<Brand> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Brand model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<Brand> models,
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

  Future<int> update(Brand model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Brand> models,
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

  Future<Brand> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Brand> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
