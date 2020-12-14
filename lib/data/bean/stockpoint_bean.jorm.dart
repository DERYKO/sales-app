// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stockpoint_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _StockpointBean implements Bean<Stockpoint> {
  final id = IntField('id');
  final shopName = StrField('shop_name');
  final shopCatName = StrField('shop_cat_name');
  final shopCatId = IntField('shop_cat_id');
  final locationName = StrField('location_name');
  final shopPhoneno = StrField('shop_phoneno');
  final contactPerson = StrField('contact_person');
  final photo = StrField('photo');
  final verified = StrField('verified');
  final status = IntField('status');
  final createdAt = StrField('created_at');
  final slatitude = StrField('slatitude');
  final slongitude = StrField('slongitude');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        shopName.name: shopName,
        shopCatName.name: shopCatName,
        shopCatId.name: shopCatId,
        locationName.name: locationName,
        shopPhoneno.name: shopPhoneno,
        contactPerson.name: contactPerson,
        photo.name: photo,
        verified.name: verified,
        status.name: status,
        createdAt.name: createdAt,
        slatitude.name: slatitude,
        slongitude.name: slongitude,
      };
  Stockpoint fromMap(Map map) {
    Stockpoint model = Stockpoint();
    model.id = adapter.parseValue(map['id']);
    model.shopName = adapter.parseValue(map['shop_name']);
    model.shopCatName = adapter.parseValue(map['shop_cat_name']);
    model.shopCatId = adapter.parseValue(map['shop_cat_id']);
    model.locationName = adapter.parseValue(map['location_name']);
    model.shopPhoneno = adapter.parseValue(map['shop_phoneno']);
    model.contactPerson = adapter.parseValue(map['contact_person']);
    model.photo = adapter.parseValue(map['photo']);
    model.verified = adapter.parseValue(map['verified']);
    model.status = adapter.parseValue(map['status']);
    model.createdAt = adapter.parseValue(map['created_at']);
    model.slatitude = adapter.parseValue(map['slatitude']);
    model.slongitude = adapter.parseValue(map['slongitude']);

    return model;
  }

  List<SetColumn> toSetColumns(Stockpoint model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(id.set(model.id));
      ret.add(shopName.set(model.shopName));
      ret.add(shopCatName.set(model.shopCatName));
      ret.add(shopCatId.set(model.shopCatId));
      ret.add(locationName.set(model.locationName));
      ret.add(shopPhoneno.set(model.shopPhoneno));
      ret.add(contactPerson.set(model.contactPerson));
      ret.add(photo.set(model.photo));
      ret.add(verified.set(model.verified));
      ret.add(status.set(model.status));
      ret.add(createdAt.set(model.createdAt));
      ret.add(slatitude.set(model.slatitude));
      ret.add(slongitude.set(model.slongitude));
    } else if (only != null) {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(shopName.name)) ret.add(shopName.set(model.shopName));
      if (only.contains(shopCatName.name))
        ret.add(shopCatName.set(model.shopCatName));
      if (only.contains(shopCatId.name))
        ret.add(shopCatId.set(model.shopCatId));
      if (only.contains(locationName.name))
        ret.add(locationName.set(model.locationName));
      if (only.contains(shopPhoneno.name))
        ret.add(shopPhoneno.set(model.shopPhoneno));
      if (only.contains(contactPerson.name))
        ret.add(contactPerson.set(model.contactPerson));
      if (only.contains(photo.name)) ret.add(photo.set(model.photo));
      if (only.contains(verified.name)) ret.add(verified.set(model.verified));
      if (only.contains(status.name)) ret.add(status.set(model.status));
      if (only.contains(createdAt.name))
        ret.add(createdAt.set(model.createdAt));
      if (only.contains(slatitude.name))
        ret.add(slatitude.set(model.slatitude));
      if (only.contains(slongitude.name))
        ret.add(slongitude.set(model.slongitude));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.shopName != null) {
        ret.add(shopName.set(model.shopName));
      }
      if (model.shopCatName != null) {
        ret.add(shopCatName.set(model.shopCatName));
      }
      if (model.shopCatId != null) {
        ret.add(shopCatId.set(model.shopCatId));
      }
      if (model.locationName != null) {
        ret.add(locationName.set(model.locationName));
      }
      if (model.shopPhoneno != null) {
        ret.add(shopPhoneno.set(model.shopPhoneno));
      }
      if (model.contactPerson != null) {
        ret.add(contactPerson.set(model.contactPerson));
      }
      if (model.photo != null) {
        ret.add(photo.set(model.photo));
      }
      if (model.verified != null) {
        ret.add(verified.set(model.verified));
      }
      if (model.status != null) {
        ret.add(status.set(model.status));
      }
      if (model.createdAt != null) {
        ret.add(createdAt.set(model.createdAt));
      }
      if (model.slatitude != null) {
        ret.add(slatitude.set(model.slatitude));
      }
      if (model.slongitude != null) {
        ret.add(slongitude.set(model.slongitude));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, isNullable: false);
    st.addStr(shopName.name, isNullable: true);
    st.addStr(shopCatName.name, isNullable: true);
    st.addInt(shopCatId.name, isNullable: true);
    st.addStr(locationName.name, isNullable: true);
    st.addStr(shopPhoneno.name, isNullable: true);
    st.addStr(contactPerson.name, isNullable: true);
    st.addStr(photo.name, isNullable: true);
    st.addStr(verified.name, isNullable: true);
    st.addInt(status.name, isNullable: true);
    st.addStr(createdAt.name, isNullable: true);
    st.addStr(slatitude.name, isNullable: true);
    st.addStr(slongitude.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Stockpoint model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<Stockpoint> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Stockpoint model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<Stockpoint> models,
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

  Future<int> update(Stockpoint model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Stockpoint> models,
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

  Future<Stockpoint> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Stockpoint> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
