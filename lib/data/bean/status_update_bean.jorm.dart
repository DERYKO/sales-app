// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_update_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _StatusUpdateBean implements Bean<StatusUpdate> {
  final id = IntField('id');
  final salerId = IntField('saler_id');
  final statusCategory = StrField('status_category');
  final statusNotes = StrField('status_notes');
  final statusType = StrField('status_type');
  final statusPhoto = StrField('status_photo');
  final statusTime = DateTimeField('status_time');
  final startDate = DateTimeField('start_date');
  final endDate = DateTimeField('end_date');
  final latitude = StrField('latitude');
  final longitude = StrField('longitude');
  final approver = StrField('approver');
  final approvalNotes = StrField('approval_notes');
  final approvalTime = DateTimeField('approval_time');
  final status = StrField('status');
  final createdAt = DateTimeField('created_at');
  final updatedAt = DateTimeField('updated_at');
  final fromServer = BoolField('from_server');
  final synced = BoolField('synced');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        salerId.name: salerId,
        statusCategory.name: statusCategory,
        statusNotes.name: statusNotes,
        statusType.name: statusType,
        statusPhoto.name: statusPhoto,
        statusTime.name: statusTime,
        startDate.name: startDate,
        endDate.name: endDate,
        latitude.name: latitude,
        longitude.name: longitude,
        approver.name: approver,
        approvalNotes.name: approvalNotes,
        approvalTime.name: approvalTime,
        status.name: status,
        createdAt.name: createdAt,
        updatedAt.name: updatedAt,
        fromServer.name: fromServer,
        synced.name: synced,
      };
  StatusUpdate fromMap(Map map) {
    StatusUpdate model = StatusUpdate();
    model.id = adapter.parseValue(map['id']);
    model.salerId = adapter.parseValue(map['saler_id']);
    model.statusCategory = adapter.parseValue(map['status_category']);
    model.statusNotes = adapter.parseValue(map['status_notes']);
    model.statusType = adapter.parseValue(map['status_type']);
    model.statusPhoto = adapter.parseValue(map['status_photo']);
    model.statusTime = adapter.parseValue(map['status_time']);
    model.startDate = adapter.parseValue(map['start_date']);
    model.endDate = adapter.parseValue(map['end_date']);
    model.latitude = adapter.parseValue(map['latitude']);
    model.longitude = adapter.parseValue(map['longitude']);
    model.approver = adapter.parseValue(map['approver']);
    model.approvalNotes = adapter.parseValue(map['approval_notes']);
    model.approvalTime = adapter.parseValue(map['approval_time']);
    model.status = adapter.parseValue(map['status']);
    model.createdAt = adapter.parseValue(map['created_at']);
    model.updatedAt = adapter.parseValue(map['updated_at']);
    model.fromServer = adapter.parseValue(map['from_server']);
    model.synced = adapter.parseValue(map['synced']);

    return model;
  }

  List<SetColumn> toSetColumns(StatusUpdate model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      ret.add(salerId.set(model.salerId));
      ret.add(statusCategory.set(model.statusCategory));
      ret.add(statusNotes.set(model.statusNotes));
      ret.add(statusType.set(model.statusType));
      ret.add(statusPhoto.set(model.statusPhoto));
      ret.add(statusTime.set(model.statusTime));
      ret.add(startDate.set(model.startDate));
      ret.add(endDate.set(model.endDate));
      ret.add(latitude.set(model.latitude));
      ret.add(longitude.set(model.longitude));
      ret.add(approver.set(model.approver));
      ret.add(approvalNotes.set(model.approvalNotes));
      ret.add(approvalTime.set(model.approvalTime));
      ret.add(status.set(model.status));
      ret.add(createdAt.set(model.createdAt));
      ret.add(updatedAt.set(model.updatedAt));
      ret.add(fromServer.set(model.fromServer));
      ret.add(synced.set(model.synced));
    } else if (only != null) {
      if (model.id != null) {
        if (only.contains(id.name)) ret.add(id.set(model.id));
      }
      if (only.contains(salerId.name)) ret.add(salerId.set(model.salerId));
      if (only.contains(statusCategory.name))
        ret.add(statusCategory.set(model.statusCategory));
      if (only.contains(statusNotes.name))
        ret.add(statusNotes.set(model.statusNotes));
      if (only.contains(statusType.name))
        ret.add(statusType.set(model.statusType));
      if (only.contains(statusPhoto.name))
        ret.add(statusPhoto.set(model.statusPhoto));
      if (only.contains(statusTime.name))
        ret.add(statusTime.set(model.statusTime));
      if (only.contains(startDate.name))
        ret.add(startDate.set(model.startDate));
      if (only.contains(endDate.name)) ret.add(endDate.set(model.endDate));
      if (only.contains(latitude.name)) ret.add(latitude.set(model.latitude));
      if (only.contains(longitude.name))
        ret.add(longitude.set(model.longitude));
      if (only.contains(approver.name)) ret.add(approver.set(model.approver));
      if (only.contains(approvalNotes.name))
        ret.add(approvalNotes.set(model.approvalNotes));
      if (only.contains(approvalTime.name))
        ret.add(approvalTime.set(model.approvalTime));
      if (only.contains(status.name)) ret.add(status.set(model.status));
      if (only.contains(createdAt.name))
        ret.add(createdAt.set(model.createdAt));
      if (only.contains(updatedAt.name))
        ret.add(updatedAt.set(model.updatedAt));
      if (only.contains(fromServer.name))
        ret.add(fromServer.set(model.fromServer));
      if (only.contains(synced.name)) ret.add(synced.set(model.synced));
    } else /* if (onlyNonNull) */ {
      if (model.id != null) {
        ret.add(id.set(model.id));
      }
      if (model.salerId != null) {
        ret.add(salerId.set(model.salerId));
      }
      if (model.statusCategory != null) {
        ret.add(statusCategory.set(model.statusCategory));
      }
      if (model.statusNotes != null) {
        ret.add(statusNotes.set(model.statusNotes));
      }
      if (model.statusType != null) {
        ret.add(statusType.set(model.statusType));
      }
      if (model.statusPhoto != null) {
        ret.add(statusPhoto.set(model.statusPhoto));
      }
      if (model.statusTime != null) {
        ret.add(statusTime.set(model.statusTime));
      }
      if (model.startDate != null) {
        ret.add(startDate.set(model.startDate));
      }
      if (model.endDate != null) {
        ret.add(endDate.set(model.endDate));
      }
      if (model.latitude != null) {
        ret.add(latitude.set(model.latitude));
      }
      if (model.longitude != null) {
        ret.add(longitude.set(model.longitude));
      }
      if (model.approver != null) {
        ret.add(approver.set(model.approver));
      }
      if (model.approvalNotes != null) {
        ret.add(approvalNotes.set(model.approvalNotes));
      }
      if (model.approvalTime != null) {
        ret.add(approvalTime.set(model.approvalTime));
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
      if (model.fromServer != null) {
        ret.add(fromServer.set(model.fromServer));
      }
      if (model.synced != null) {
        ret.add(synced.set(model.synced));
      }
    }

    return ret;
  }

  Future<void> createTable({bool ifNotExists = false}) async {
    final st = Sql.create(tableName, ifNotExists: ifNotExists);
    st.addInt(id.name, primary: true, autoIncrement: true, isNullable: false);
    st.addInt(salerId.name, isNullable: true);
    st.addStr(statusCategory.name, isNullable: true);
    st.addStr(statusNotes.name, isNullable: true);
    st.addStr(statusType.name, isNullable: true);
    st.addStr(statusPhoto.name, isNullable: true);
    st.addDateTime(statusTime.name, isNullable: true);
    st.addDateTime(startDate.name, isNullable: true);
    st.addDateTime(endDate.name, isNullable: true);
    st.addStr(latitude.name, isNullable: true);
    st.addStr(longitude.name, isNullable: true);
    st.addStr(approver.name, isNullable: true);
    st.addStr(approvalNotes.name, isNullable: true);
    st.addDateTime(approvalTime.name, isNullable: true);
    st.addStr(status.name, isNullable: true);
    st.addDateTime(createdAt.name, isNullable: true);
    st.addDateTime(updatedAt.name, isNullable: true);
    st.addBool(fromServer.name, isNullable: true);
    st.addBool(synced.name, isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(StatusUpdate model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(id.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      StatusUpdate newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<StatusUpdate> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(StatusUpdate model,
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
      StatusUpdate newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<StatusUpdate> models,
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

  Future<int> update(StatusUpdate model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<StatusUpdate> models,
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

  Future<StatusUpdate> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<StatusUpdate> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
