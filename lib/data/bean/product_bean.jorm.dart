// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _ProductBean implements Bean<Product> {
  final productId = IntField('product_id');
  final companyId = IntField('company_id');
  final productRef = StrField('product_ref');
  final focusProduct = IntField('focus_product');
  final iscompetitor = StrField('iscompetitor');
  final companyName = StrField('company_name');
  final productDiv = StrField('product_div');
  final productValcode = StrField('product_valcode');
  final productCategory = StrField('product_category');
  final productCode = StrField('product_code');
  final productDesc = StrField('product_desc');
  final productName = StrField('product_name');
  final productPackaging = StrField('product_packaging');
  final taxCode = StrField('tax_code');
  final crtQnty = IntField('crt_qnty');
  final productUnit = StrField('product_unit');
  final priceCrtns = StrField('price_crtns');
  final pricePkts = StrField('price_pkts');
  final productStatus = StrField('product_status');
  final createdAt = StrField('created_at');
  final updatedAt = StrField('updated_at');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        productId.name: productId,
        companyId.name: companyId,
        productRef.name: productRef,
        focusProduct.name: focusProduct,
        iscompetitor.name: iscompetitor,
        companyName.name: companyName,
        productDiv.name: productDiv,
        productValcode.name: productValcode,
        productCategory.name: productCategory,
        productCode.name: productCode,
        productDesc.name: productDesc,
        productName.name: productName,
        productPackaging.name: productPackaging,
        taxCode.name: taxCode,
        crtQnty.name: crtQnty,
        productUnit.name: productUnit,
        priceCrtns.name: priceCrtns,
        pricePkts.name: pricePkts,
        productStatus.name: productStatus,
        createdAt.name: createdAt,
        updatedAt.name: updatedAt,
      };
  Product fromMap(Map map) {
    Product model = Product();
    model.productId = adapter.parseValue(map['product_id']);
    model.companyId = adapter.parseValue(map['company_id']);
    model.productRef = adapter.parseValue(map['product_ref']);
    model.focusProduct = adapter.parseValue(map['focus_product']);
    model.iscompetitor = adapter.parseValue(map['iscompetitor']);
    model.companyName = adapter.parseValue(map['company_name']);
    model.productDiv = adapter.parseValue(map['product_div']);
    model.productValcode = adapter.parseValue(map['product_valcode']);
    model.productCategory = adapter.parseValue(map['product_category']);
    model.productCode = adapter.parseValue(map['product_code']);
    model.productDesc = adapter.parseValue(map['product_desc']);
    model.productName = adapter.parseValue(map['product_name']);
    model.productPackaging = adapter.parseValue(map['product_packaging']);
    model.taxCode = adapter.parseValue(map['tax_code']);
    model.crtQnty = adapter.parseValue(map['crt_qnty']);
    model.productUnit = adapter.parseValue(map['product_unit']);
    model.priceCrtns = adapter.parseValue(map['price_crtns']);
    model.pricePkts = adapter.parseValue(map['price_pkts']);
    model.productStatus = adapter.parseValue(map['product_status']);
    model.createdAt = adapter.parseValue(map['created_at']);
    model.updatedAt = adapter.parseValue(map['updated_at']);

    return model;
  }

  List<SetColumn> toSetColumns(Product model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(productId.set(model.productId));
      ret.add(companyId.set(model.companyId));
      ret.add(productRef.set(model.productRef));
      ret.add(focusProduct.set(model.focusProduct));
      ret.add(iscompetitor.set(model.iscompetitor));
      ret.add(companyName.set(model.companyName));
      ret.add(productDiv.set(model.productDiv));
      ret.add(productValcode.set(model.productValcode));
      ret.add(productCategory.set(model.productCategory));
      ret.add(productCode.set(model.productCode));
      ret.add(productDesc.set(model.productDesc));
      ret.add(productName.set(model.productName));
      ret.add(productPackaging.set(model.productPackaging));
      ret.add(taxCode.set(model.taxCode));
      ret.add(crtQnty.set(model.crtQnty));
      ret.add(productUnit.set(model.productUnit));
      ret.add(priceCrtns.set(model.priceCrtns));
      ret.add(pricePkts.set(model.pricePkts));
      ret.add(productStatus.set(model.productStatus));
      ret.add(createdAt.set(model.createdAt));
      ret.add(updatedAt.set(model.updatedAt));
    } else if (only != null) {
      if (only.contains(productId.name))
        ret.add(productId.set(model.productId));
      if (only.contains(companyId.name))
        ret.add(companyId.set(model.companyId));
      if (only.contains(productRef.name))
        ret.add(productRef.set(model.productRef));
      if (only.contains(focusProduct.name))
        ret.add(focusProduct.set(model.focusProduct));
      if (only.contains(iscompetitor.name))
        ret.add(iscompetitor.set(model.iscompetitor));
      if (only.contains(companyName.name))
        ret.add(companyName.set(model.companyName));
      if (only.contains(productDiv.name))
        ret.add(productDiv.set(model.productDiv));
      if (only.contains(productValcode.name))
        ret.add(productValcode.set(model.productValcode));
      if (only.contains(productCategory.name))
        ret.add(productCategory.set(model.productCategory));
      if (only.contains(productCode.name))
        ret.add(productCode.set(model.productCode));
      if (only.contains(productDesc.name))
        ret.add(productDesc.set(model.productDesc));
      if (only.contains(productName.name))
        ret.add(productName.set(model.productName));
      if (only.contains(productPackaging.name))
        ret.add(productPackaging.set(model.productPackaging));
      if (only.contains(taxCode.name)) ret.add(taxCode.set(model.taxCode));
      if (only.contains(crtQnty.name)) ret.add(crtQnty.set(model.crtQnty));
      if (only.contains(productUnit.name))
        ret.add(productUnit.set(model.productUnit));
      if (only.contains(priceCrtns.name))
        ret.add(priceCrtns.set(model.priceCrtns));
      if (only.contains(pricePkts.name))
        ret.add(pricePkts.set(model.pricePkts));
      if (only.contains(productStatus.name))
        ret.add(productStatus.set(model.productStatus));
      if (only.contains(createdAt.name))
        ret.add(createdAt.set(model.createdAt));
      if (only.contains(updatedAt.name))
        ret.add(updatedAt.set(model.updatedAt));
    } else /* if (onlyNonNull) */ {
      if (model.productId != null) {
        ret.add(productId.set(model.productId));
      }
      if (model.companyId != null) {
        ret.add(companyId.set(model.companyId));
      }
      if (model.productRef != null) {
        ret.add(productRef.set(model.productRef));
      }
      if (model.focusProduct != null) {
        ret.add(focusProduct.set(model.focusProduct));
      }
      if (model.iscompetitor != null) {
        ret.add(iscompetitor.set(model.iscompetitor));
      }
      if (model.companyName != null) {
        ret.add(companyName.set(model.companyName));
      }
      if (model.productDiv != null) {
        ret.add(productDiv.set(model.productDiv));
      }
      if (model.productValcode != null) {
        ret.add(productValcode.set(model.productValcode));
      }
      if (model.productCategory != null) {
        ret.add(productCategory.set(model.productCategory));
      }
      if (model.productCode != null) {
        ret.add(productCode.set(model.productCode));
      }
      if (model.productDesc != null) {
        ret.add(productDesc.set(model.productDesc));
      }
      if (model.productName != null) {
        ret.add(productName.set(model.productName));
      }
      if (model.productPackaging != null) {
        ret.add(productPackaging.set(model.productPackaging));
      }
      if (model.taxCode != null) {
        ret.add(taxCode.set(model.taxCode));
      }
      if (model.crtQnty != null) {
        ret.add(crtQnty.set(model.crtQnty));
      }
      if (model.productUnit != null) {
        ret.add(productUnit.set(model.productUnit));
      }
      if (model.priceCrtns != null) {
        ret.add(priceCrtns.set(model.priceCrtns));
      }
      if (model.pricePkts != null) {
        ret.add(pricePkts.set(model.pricePkts));
      }
      if (model.productStatus != null) {
        ret.add(productStatus.set(model.productStatus));
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
    st.addInt(productId.name, primary: true, isNullable: false);
    st.addInt(companyId.name, isNullable: true);
    st.addStr(productRef.name, isNullable: true);
    st.addInt(focusProduct.name, isNullable: false);
    st.addStr(iscompetitor.name, isNullable: true);
    st.addStr(companyName.name, isNullable: true);
    st.addStr(productDiv.name, isNullable: true);
    st.addStr(productValcode.name, isNullable: true);
    st.addStr(productCategory.name, isNullable: true);
    st.addStr(productCode.name, isNullable: true);
    st.addStr(productDesc.name, isNullable: true);
    st.addStr(productName.name, isNullable: true);
    st.addStr(productPackaging.name, isNullable: true);
    st.addStr(taxCode.name, isNullable: true);
    st.addInt(crtQnty.name, isNullable: true);
    st.addStr(productUnit.name, isNullable: true);
    st.addStr(priceCrtns.name, isNullable: true);
    st.addStr(pricePkts.name, isNullable: true);
    st.addStr(productStatus.name, isNullable: true);
    st.addStr(createdAt.name, isNullable: true);
    st.addStr(updatedAt.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Product model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<Product> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Product model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<Product> models,
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

  Future<int> update(Product model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.productId.eq(model.productId))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Product> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(this.productId.eq(model.productId));
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<Product> find(int productId,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.productId.eq(productId));
    return await findOne(find);
  }

  Future<int> remove(int productId) async {
    final Remove remove = remover.where(this.productId.eq(productId));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Product> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.productId.eq(model.productId));
    }
    return adapter.remove(remove);
  }
}
