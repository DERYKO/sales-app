// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timesheet_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _TimesheetBean implements Bean<Timesheet> {
  final timesheetId = IntField('timesheet_id');
  final visitid = StrField('visitid');
  final branchId = IntField('branch_id');
  final checkinLatitude = StrField('checkin_latitude');
  final checkinLongitude = StrField('checkin_longitude');
  final checkinAddress = StrField('checkin_address');
  final checkinPhoto = StrField('checkin_photo');
  final checkoutLatitude = StrField('checkout_latitude');
  final checkoutLongitude = StrField('checkout_longitude');
  final checkoutAddress = StrField('checkout_address');
  final checkinTime = DateTimeField('checkin_time');
  final checkoutStime = DateTimeField('checkout_stime');
  final checkoutTime = DateTimeField('checkout_time');
  final merchandiserId = IntField('merchandiser_id');
  final createdAt = DateTimeField('created_at');
  final updatedAt = DateTimeField('updated_at');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        timesheetId.name: timesheetId,
        visitid.name: visitid,
        branchId.name: branchId,
        checkinLatitude.name: checkinLatitude,
        checkinLongitude.name: checkinLongitude,
        checkinAddress.name: checkinAddress,
        checkinPhoto.name: checkinPhoto,
        checkoutLatitude.name: checkoutLatitude,
        checkoutLongitude.name: checkoutLongitude,
        checkoutAddress.name: checkoutAddress,
        checkinTime.name: checkinTime,
        checkoutStime.name: checkoutStime,
        checkoutTime.name: checkoutTime,
        merchandiserId.name: merchandiserId,
        createdAt.name: createdAt,
        updatedAt.name: updatedAt,
      };
  Timesheet fromMap(Map map) {
    Timesheet model = Timesheet();
    model.timesheetId = adapter.parseValue(map['timesheet_id']);
    model.visitid = adapter.parseValue(map['visitid']);
    model.branchId = adapter.parseValue(map['branch_id']);
    model.checkinLatitude = adapter.parseValue(map['checkin_latitude']);
    model.checkinLongitude = adapter.parseValue(map['checkin_longitude']);
    model.checkinAddress = adapter.parseValue(map['checkin_address']);
    model.checkinPhoto = adapter.parseValue(map['checkin_photo']);
    model.checkoutLatitude = adapter.parseValue(map['checkout_latitude']);
    model.checkoutLongitude = adapter.parseValue(map['checkout_longitude']);
    model.checkoutAddress = adapter.parseValue(map['checkout_address']);
    model.checkinTime = adapter.parseValue(map['checkin_time']);
    model.checkoutStime = adapter.parseValue(map['checkout_stime']);
    model.checkoutTime = adapter.parseValue(map['checkout_time']);
    model.merchandiserId = adapter.parseValue(map['merchandiser_id']);
    model.createdAt = adapter.parseValue(map['created_at']);
    model.updatedAt = adapter.parseValue(map['updated_at']);

    return model;
  }

  List<SetColumn> toSetColumns(Timesheet model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      if (model.timesheetId != null) {
        ret.add(timesheetId.set(model.timesheetId));
      }
      ret.add(visitid.set(model.visitid));
      ret.add(branchId.set(model.branchId));
      ret.add(checkinLatitude.set(model.checkinLatitude));
      ret.add(checkinLongitude.set(model.checkinLongitude));
      ret.add(checkinAddress.set(model.checkinAddress));
      ret.add(checkinPhoto.set(model.checkinPhoto));
      ret.add(checkoutLatitude.set(model.checkoutLatitude));
      ret.add(checkoutLongitude.set(model.checkoutLongitude));
      ret.add(checkoutAddress.set(model.checkoutAddress));
      ret.add(checkinTime.set(model.checkinTime));
      ret.add(checkoutStime.set(model.checkoutStime));
      ret.add(checkoutTime.set(model.checkoutTime));
      ret.add(merchandiserId.set(model.merchandiserId));
      ret.add(createdAt.set(model.createdAt));
      ret.add(updatedAt.set(model.updatedAt));
    } else if (only != null) {
      if (model.timesheetId != null) {
        if (only.contains(timesheetId.name))
          ret.add(timesheetId.set(model.timesheetId));
      }
      if (only.contains(visitid.name)) ret.add(visitid.set(model.visitid));
      if (only.contains(branchId.name)) ret.add(branchId.set(model.branchId));
      if (only.contains(checkinLatitude.name))
        ret.add(checkinLatitude.set(model.checkinLatitude));
      if (only.contains(checkinLongitude.name))
        ret.add(checkinLongitude.set(model.checkinLongitude));
      if (only.contains(checkinAddress.name))
        ret.add(checkinAddress.set(model.checkinAddress));
      if (only.contains(checkinPhoto.name))
        ret.add(checkinPhoto.set(model.checkinPhoto));
      if (only.contains(checkoutLatitude.name))
        ret.add(checkoutLatitude.set(model.checkoutLatitude));
      if (only.contains(checkoutLongitude.name))
        ret.add(checkoutLongitude.set(model.checkoutLongitude));
      if (only.contains(checkoutAddress.name))
        ret.add(checkoutAddress.set(model.checkoutAddress));
      if (only.contains(checkinTime.name))
        ret.add(checkinTime.set(model.checkinTime));
      if (only.contains(checkoutStime.name))
        ret.add(checkoutStime.set(model.checkoutStime));
      if (only.contains(checkoutTime.name))
        ret.add(checkoutTime.set(model.checkoutTime));
      if (only.contains(merchandiserId.name))
        ret.add(merchandiserId.set(model.merchandiserId));
      if (only.contains(createdAt.name))
        ret.add(createdAt.set(model.createdAt));
      if (only.contains(updatedAt.name))
        ret.add(updatedAt.set(model.updatedAt));
    } else /* if (onlyNonNull) */ {
      if (model.timesheetId != null) {
        ret.add(timesheetId.set(model.timesheetId));
      }
      if (model.visitid != null) {
        ret.add(visitid.set(model.visitid));
      }
      if (model.branchId != null) {
        ret.add(branchId.set(model.branchId));
      }
      if (model.checkinLatitude != null) {
        ret.add(checkinLatitude.set(model.checkinLatitude));
      }
      if (model.checkinLongitude != null) {
        ret.add(checkinLongitude.set(model.checkinLongitude));
      }
      if (model.checkinAddress != null) {
        ret.add(checkinAddress.set(model.checkinAddress));
      }
      if (model.checkinPhoto != null) {
        ret.add(checkinPhoto.set(model.checkinPhoto));
      }
      if (model.checkoutLatitude != null) {
        ret.add(checkoutLatitude.set(model.checkoutLatitude));
      }
      if (model.checkoutLongitude != null) {
        ret.add(checkoutLongitude.set(model.checkoutLongitude));
      }
      if (model.checkoutAddress != null) {
        ret.add(checkoutAddress.set(model.checkoutAddress));
      }
      if (model.checkinTime != null) {
        ret.add(checkinTime.set(model.checkinTime));
      }
      if (model.checkoutStime != null) {
        ret.add(checkoutStime.set(model.checkoutStime));
      }
      if (model.checkoutTime != null) {
        ret.add(checkoutTime.set(model.checkoutTime));
      }
      if (model.merchandiserId != null) {
        ret.add(merchandiserId.set(model.merchandiserId));
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
    st.addInt(timesheetId.name,
        primary: true, autoIncrement: true, isNullable: false);
    st.addStr(visitid.name, isNullable: true);
    st.addInt(branchId.name, isNullable: true);
    st.addStr(checkinLatitude.name, isNullable: true);
    st.addStr(checkinLongitude.name, isNullable: true);
    st.addStr(checkinAddress.name, isNullable: true);
    st.addStr(checkinPhoto.name, isNullable: true);
    st.addStr(checkoutLatitude.name, isNullable: true);
    st.addStr(checkoutLongitude.name, isNullable: true);
    st.addStr(checkoutAddress.name, isNullable: true);
    st.addDateTime(checkinTime.name, isNullable: true);
    st.addDateTime(checkoutStime.name, isNullable: true);
    st.addDateTime(checkoutTime.name, isNullable: true);
    st.addInt(merchandiserId.name, isNullable: true);
    st.addDateTime(createdAt.name, isNullable: true);
    st.addDateTime(updatedAt.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Timesheet model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .id(timesheetId.name);
    var retId = await adapter.insert(insert);
    if (cascade) {
      Timesheet newModel;
    }
    return retId;
  }

  Future<void> insertMany(List<Timesheet> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(Timesheet model,
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
            .where(this.timesheetId.eq(model.timesheetId))
            .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
        retId = adapter.update(update);
      }
    } else {
      final Upsert upsert = upserter
          .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
          .id(timesheetId.name);
      retId = await adapter.upsert(upsert);
    }
    if (cascade) {
      Timesheet newModel;
    }
    return retId;
  }

  Future<void> upsertMany(List<Timesheet> models,
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

  Future<int> update(Timesheet model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.timesheetId.eq(model.timesheetId))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<Timesheet> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(
          toSetColumns(model, only: only, onlyNonNull: onlyNonNull).toList());
      where.add(this.timesheetId.eq(model.timesheetId));
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<Timesheet> find(int timesheetId,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.timesheetId.eq(timesheetId));
    return await findOne(find);
  }

  Future<int> remove(int timesheetId) async {
    final Remove remove = remover.where(this.timesheetId.eq(timesheetId));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Timesheet> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.timesheetId.eq(model.timesheetId));
    }
    return adapter.remove(remove);
  }
}
