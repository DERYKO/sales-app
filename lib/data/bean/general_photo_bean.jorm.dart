// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_photo_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _GeneralPhotoBean implements Bean<GeneralPhoto> {
  final id = IntField('id');
  final salerId = IntField('saler_id');
  final shopId = IntField('shop_id');
  final imageCategory = StrField('image_category');
  final imageNotes = StrField('image_notes');
  final visitid = StrField('visitid');
  final imagePhoto = StrField('image_photo');
  final activityId = IntField('activity_id');
  final productCategory = StrField('product_category');
  final brandName = StrField('brand_name');
  final longitude = StrField('longitude');
  final latitude = StrField('latitude');
  final imageAddress = StrField('image_address');
  final imageTime = DateTimeField('image_time');
  final createdAt = DateTimeField('created_at');
  final updatedAt = DateTimeField('updated_at');
  final synced = BoolField('synced');
  final fromServer = BoolField('from_server');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        salerId.name: salerId,
        shopId.name: shopId,
        imageCategory.name: imageCategory,
        imageNotes.name: imageNotes,
        visitid.name: visitid,
        imagePhoto.name: imagePhoto,
        activityId.name: activityId,
        productCategory.name: productCategory,
        brandName.name: brandName,
        longitude.name: longitude,
        latitude.name: latitude,
        imageAddress.name: imageAddress,
        imageTime.name: imageTime,
        createdAt.name: createdAt,
        updatedAt.name: updatedAt,
        synced.name: synced,
        fromServer.name: fromServer,
      };
  GeneralPhoto fromMap(Map map) {
    GeneralPhoto model = GeneralPhoto();
    model.id = adapter.parseValue(map['id']);
    model.salerId = adapter.parseValue(map['saler_id']);
    model.shopId = adapter.parseValue(map['shop_id']);
    model.imageCategory = adapter.parseValue(map['image_category']);
    model.imageNotes = adapter.parseValue(map['image_notes']);
    model.visitid = adapter.parseValue(map['visitid']);
    model.imagePhoto = adapter.parseValue(map['image_photo']);
    model.activityId = adapter.parseValue(map['activity_id']);
    model.productCategory = adapter.parseValue(map['product_category']);
    model.brandName = adapter.parseValue(map['brand_name']);
    model.longitude = adapter.parseValue(map['longitude']);
    model.latitude = adapter.parseValue(map['latitude']);
    model.imageAddress = adapter.parseValue(map['image_address']);
    model.imageTime = adapter.parseValue(map['image_time']);
    model.createdAt = adapter.parseValue(map['created_at']);
    model.updatedAt = adapter.parseValue(map['updated_at']);
    model.synced = adapter.parseValue(map['synced']);
    model.fromServer = adapter.parseValue(map['from_server']);

    return model;
  }

  List<SetColumn> toSetColumns(GeneralPhoto model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(salerId.set(model.salerId));
      ret.add(shopId.set(model.shopId));
      ret.add(imageCategory.set(model.imageCategory));
      ret.add(imageNotes.set(model.imageNotes));
      ret.add(visitid.set(model.visitid));
      ret.add(imagePhoto.set(model.imagePhoto));
      ret.add(activityId.set(model.activityId));
      ret.add(productCategory.set(model.productCategory));
      ret.add(brandName.set(model.brandName));
      ret.add(longitude.set(model.longitude));
      ret.add(latitude.set(model.latitude));
      ret.add(imageAddress.set(model.imageAddress));
      ret.add(imageTime.set(model.imageTime));
      ret.add(createdAt.set(model.createdAt));
      ret.add(updatedAt.set(model.updatedAt));
      ret.add(synced.set(model.synced));
      ret.add(fromServer.set(model.fromServer));
    } else if (only != null) {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(salerId.name)) ret.add(salerId.set(model.salerId));
      if (only.contains(shopId.name)) ret.add(shopId.set(model.shopId));
      if (only.contains(imageCategory.name))
        ret.add(imageCategory.set(model.imageCategory));
      if (only.contains(imageNotes.name))
        ret.add(imageNotes.set(model.imageNotes));
      if (only.contains(visitid.name)) ret.add(visitid.set(model.visitid));
      if (only.contains(imagePhoto.name))
        ret.add(imagePhoto.set(model.imagePhoto));
      if (only.contains(activityId.name))
        ret.add(activityId.set(model.activityId));
      if (only.contains(productCategory.name))
        ret.add(productCategory.set(model.productCategory));
      if (only.contains(brandName.name))
        ret.add(brandName.set(model.brandName));
      if (only.contains(longitude.name))
        ret.add(longitude.set(model.longitude));
      if (only.contains(latitude.name)) ret.add(latitude.set(model.latitude));
      if (only.contains(imageAddress.name))
        ret.add(imageAddress.set(model.imageAddress));
      if (only.contains(imageTime.name))
        ret.add(imageTime.set(model.imageTime));
      if (only.contains(createdAt.name))
        ret.add(createdAt.set(model.createdAt));
      if (only.contains(updatedAt.name))
        ret.add(updatedAt.set(model.updatedAt));
      if (only.contains(synced.name)) ret.add(synced.set(model.synced));
      if (only.contains(fromServer.name))
        ret.add(fromServer.set(model.fromServer));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.salerId != null) {
        ret.add(salerId.set(model.salerId));
      }
      if (model.shopId != null) {
        ret.add(shopId.set(model.shopId));
      }
      if (model.imageCategory != null) {
        ret.add(imageCategory.set(model.imageCategory));
      }
      if (model.imageNotes != null) {
        ret.add(imageNotes.set(model.imageNotes));
      }
      if (model.visitid != null) {
        ret.add(visitid.set(model.visitid));
      }
      if (model.imagePhoto != null) {
        ret.add(imagePhoto.set(model.imagePhoto));
      }
      if (model.activityId != null) {
        ret.add(activityId.set(model.activityId));
      }
      if (model.productCategory != null) {
        ret.add(productCategory.set(model.productCategory));
      }
      if (model.brandName != null) {
        ret.add(brandName.set(model.brandName));
      }
      if (model.longitude != null) {
        ret.add(longitude.set(model.longitude));
      }
      if (model.latitude != null) {
        ret.add(latitude.set(model.latitude));
      }
      if (model.imageAddress != null) {
        ret.add(imageAddress.set(model.imageAddress));
      }
      if (model.imageTime != null) {
        ret.add(imageTime.set(model.imageTime));
      }
      if (model.createdAt != null) {
        ret.add(createdAt.set(model.createdAt));
      }
      if (model.updatedAt != null) {
        ret.add(updatedAt.set(model.updatedAt));
      }
      if (model.synced != null) {
        ret.add(synced.set(model.synced));
      }
      if (model.fromServer != null) {
        ret.add(fromServer.set(model.fromServer));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, autoIncrement: true, isNullable: false);
    st.addInt(salerId.name, isNullable: true);
    st.addInt(shopId.name, isNullable: true);
    st.addStr(imageCategory.name, isNullable: true);
    st.addStr(imageNotes.name, isNullable: true);
    st.addStr(visitid.name, isNullable: true);
    st.addStr(imagePhoto.name, isNullable: true);
    st.addInt(activityId.name, isNullable: true);
    st.addStr(productCategory.name, isNullable: true);
    st.addStr(brandName.name, isNullable: true);
    st.addStr(longitude.name, isNullable: true);
    st.addStr(latitude.name, isNullable: true);
    st.addStr(imageAddress.name, isNullable: true);
    st.addDateTime(imageTime.name, isNullable: true);
    st.addDateTime(createdAt.name, isNullable: true);
    st.addDateTime(updatedAt.name, isNullable: true);
    st.addBool(synced.name, isNullable: false);
    st.addBool(fromServer.name, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(GeneralPhoto model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      GeneralPhoto newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<GeneralPhoto> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(GeneralPhoto model,
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
      GeneralPhoto newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<GeneralPhoto> models,
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

  Future<int> update(GeneralPhoto model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<GeneralPhoto> models,
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

  Future<GeneralPhoto> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<GeneralPhoto> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
