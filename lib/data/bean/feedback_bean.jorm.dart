// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _FeedbackBean implements Bean<Feedback> {
  final id = IntField('id');
  final feedId = IntField('feed_id');
  final category = StrField('category');
  final repId = IntField('rep_id');
  final assignedid = IntField('assignedid');
  final visitId = StrField('visit_id');
  final productId = IntField('product_id');
  final brand = StrField('brand');
  final quantity = IntField('quantity');
  final batchnumber = StrField('batchnumber');
  final notes = StrField('notes');
  final photo = StrField('photo');
  final priorityLevel = StrField('priority_level');
  final outletId = IntField('outlet_id');
  final lat = StrField('lat');
  final lon = StrField('lon');
  final entryTime = DateTimeField('entry_time');
  final assignedTo = IntField('assigned_to');
  final status = StrField('status');
  final createdAt = DateTimeField('created_at');
  final updatedAt = DateTimeField('updated_at');
  final synced = BoolField('synced');
  final fromServer = BoolField('from_server');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        feedId.name: feedId,
        category.name: category,
        repId.name: repId,
        assignedid.name: assignedid,
        visitId.name: visitId,
        productId.name: productId,
        brand.name: brand,
        quantity.name: quantity,
        batchnumber.name: batchnumber,
        notes.name: notes,
        photo.name: photo,
        priorityLevel.name: priorityLevel,
        outletId.name: outletId,
        lat.name: lat,
        lon.name: lon,
        entryTime.name: entryTime,
        assignedTo.name: assignedTo,
        status.name: status,
        createdAt.name: createdAt,
        updatedAt.name: updatedAt,
        synced.name: synced,
        fromServer.name: fromServer,
      };
  Feedback fromMap(Map map) {
    Feedback model = Feedback();
    model.id = adapter.parseValue(map['id']);
    model.feedId = adapter.parseValue(map['feed_id']);
    model.category = adapter.parseValue(map['category']);
    model.repId = adapter.parseValue(map['rep_id']);
    model.assignedid = adapter.parseValue(map['assignedid']);
    model.visitId = adapter.parseValue(map['visit_id']);
    model.productId = adapter.parseValue(map['product_id']);
    model.brand = adapter.parseValue(map['brand']);
    model.quantity = adapter.parseValue(map['quantity']);
    model.batchnumber = adapter.parseValue(map['batchnumber']);
    model.notes = adapter.parseValue(map['notes']);
    model.photo = adapter.parseValue(map['photo']);
    model.priorityLevel = adapter.parseValue(map['priority_level']);
    model.outletId = adapter.parseValue(map['outlet_id']);
    model.lat = adapter.parseValue(map['lat']);
    model.lon = adapter.parseValue(map['lon']);
    model.entryTime = adapter.parseValue(map['entry_time']);
    model.assignedTo = adapter.parseValue(map['assigned_to']);
    model.status = adapter.parseValue(map['status']);
    model.createdAt = adapter.parseValue(map['created_at']);
    model.updatedAt = adapter.parseValue(map['updated_at']);
    model.synced = adapter.parseValue(map['synced']);
    model.fromServer = adapter.parseValue(map['from_server']);

    return model;
  }

  List<SetColumn> toSetColumns(Feedback model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(feedId.set(model.feedId));
      ret.add(category.set(model.category));
      ret.add(repId.set(model.repId));
      ret.add(assignedid.set(model.assignedid));
      ret.add(visitId.set(model.visitId));
      ret.add(productId.set(model.productId));
      ret.add(brand.set(model.brand));
      ret.add(quantity.set(model.quantity));
      ret.add(batchnumber.set(model.batchnumber));
      ret.add(notes.set(model.notes));
      ret.add(photo.set(model.photo));
      ret.add(priorityLevel.set(model.priorityLevel));
      ret.add(outletId.set(model.outletId));
      ret.add(lat.set(model.lat));
      ret.add(lon.set(model.lon));
      ret.add(entryTime.set(model.entryTime));
      ret.add(assignedTo.set(model.assignedTo));
      ret.add(status.set(model.status));
      ret.add(createdAt.set(model.createdAt));
      ret.add(updatedAt.set(model.updatedAt));
      ret.add(synced.set(model.synced));
      ret.add(fromServer.set(model.fromServer));
    } else if (only != null) {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(feedId.name)) ret.add(feedId.set(model.feedId));
      if (only.contains(category.name)) ret.add(category.set(model.category));
      if (only.contains(repId.name)) ret.add(repId.set(model.repId));
      if (only.contains(assignedid.name))
        ret.add(assignedid.set(model.assignedid));
      if (only.contains(visitId.name)) ret.add(visitId.set(model.visitId));
      if (only.contains(productId.name))
        ret.add(productId.set(model.productId));
      if (only.contains(brand.name)) ret.add(brand.set(model.brand));
      if (only.contains(quantity.name)) ret.add(quantity.set(model.quantity));
      if (only.contains(batchnumber.name))
        ret.add(batchnumber.set(model.batchnumber));
      if (only.contains(notes.name)) ret.add(notes.set(model.notes));
      if (only.contains(photo.name)) ret.add(photo.set(model.photo));
      if (only.contains(priorityLevel.name))
        ret.add(priorityLevel.set(model.priorityLevel));
      if (only.contains(outletId.name)) ret.add(outletId.set(model.outletId));
      if (only.contains(lat.name)) ret.add(lat.set(model.lat));
      if (only.contains(lon.name)) ret.add(lon.set(model.lon));
      if (only.contains(entryTime.name))
        ret.add(entryTime.set(model.entryTime));
      if (only.contains(assignedTo.name))
        ret.add(assignedTo.set(model.assignedTo));
      if (only.contains(status.name)) ret.add(status.set(model.status));
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
      if (model.feedId != null) {
        ret.add(feedId.set(model.feedId));
      }
      if (model.category != null) {
        ret.add(category.set(model.category));
      }
      if (model.repId != null) {
        ret.add(repId.set(model.repId));
      }
      if (model.assignedid != null) {
        ret.add(assignedid.set(model.assignedid));
      }
      if (model.visitId != null) {
        ret.add(visitId.set(model.visitId));
      }
      if (model.productId != null) {
        ret.add(productId.set(model.productId));
      }
      if (model.brand != null) {
        ret.add(brand.set(model.brand));
      }
      if (model.quantity != null) {
        ret.add(quantity.set(model.quantity));
      }
      if (model.batchnumber != null) {
        ret.add(batchnumber.set(model.batchnumber));
      }
      if (model.notes != null) {
        ret.add(notes.set(model.notes));
      }
      if (model.photo != null) {
        ret.add(photo.set(model.photo));
      }
      if (model.priorityLevel != null) {
        ret.add(priorityLevel.set(model.priorityLevel));
      }
      if (model.outletId != null) {
        ret.add(outletId.set(model.outletId));
      }
      if (model.lat != null) {
        ret.add(lat.set(model.lat));
      }
      if (model.lon != null) {
        ret.add(lon.set(model.lon));
      }
      if (model.entryTime != null) {
        ret.add(entryTime.set(model.entryTime));
      }
      if (model.assignedTo != null) {
        ret.add(assignedTo.set(model.assignedTo));
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
    st.addInt(feedId.name, isNullable: true);
    st.addStr(category.name, isNullable: true);
    st.addInt(repId.name, isNullable: true);
    st.addInt(assignedid.name, isNullable: true);
    st.addStr(visitId.name, isNullable: true);
    st.addInt(productId.name, isNullable: true);
    st.addStr(brand.name, isNullable: true);
    st.addInt(quantity.name, isNullable: true);
    st.addStr(batchnumber.name, isNullable: true);
    st.addStr(notes.name, isNullable: true);
    st.addStr(photo.name, isNullable: true);
    st.addStr(priorityLevel.name, isNullable: true);
    st.addInt(outletId.name, isNullable: true);
    st.addStr(lat.name, isNullable: true);
    st.addStr(lon.name, isNullable: true);
    st.addDateTime(entryTime.name, isNullable: true);
    st.addInt(assignedTo.name, isNullable: true);
    st.addStr(status.name, isNullable: true);
    st.addDateTime(createdAt.name, isNullable: true);
    st.addDateTime(updatedAt.name, isNullable: true);
    st.addBool(synced.name, isNullable: true);
    st.addBool(fromServer.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Feedback model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      Feedback newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<Feedback> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Feedback model,
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
      Feedback newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<Feedback> models,
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

  Future<int> update(Feedback model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Feedback> models,
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

  Future<Feedback> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Feedback> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
