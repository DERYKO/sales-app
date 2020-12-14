// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_category_bean.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _FeedbackCategoryBean implements Bean<FeedbackCategory> {
  final id = IntField('id');
  final categoryname = StrField('categoryname');
  final feedbackCategory = StrField('feedback_category');
  final hasbatch = StrField('hasbatch');
  final status = StrField('status');
  final createdAt = DateTimeField('created_at');
  final updatedAt = DateTimeField('updated_at');
  final deletedAt = DateTimeField('deleted_at');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        categoryname.name: categoryname,
        feedbackCategory.name: feedbackCategory,
        hasbatch.name: hasbatch,
        status.name: status,
        createdAt.name: createdAt,
        updatedAt.name: updatedAt,
        deletedAt.name: deletedAt,
      };
  FeedbackCategory fromMap(Map map) {
    FeedbackCategory model = FeedbackCategory();
    model.id = adapter.parseValue(map['id']);
    model.categoryname = adapter.parseValue(map['categoryname']);
    model.feedbackCategory = adapter.parseValue(map['feedback_category']);
    model.hasbatch = adapter.parseValue(map['hasbatch']);
    model.status = adapter.parseValue(map['status']);
    model.createdAt = adapter.parseValue(map['created_at']);
    model.updatedAt = adapter.parseValue(map['updated_at']);
    model.deletedAt = adapter.parseValue(map['deleted_at']);

    return model;
  }

  List<SetColumn> toSetColumns(FeedbackCategory model,
      {bool update = false, Set<String> only, bool onlyNonNull = false}) {
    List<SetColumn> ret = [];

    if (only == null && !onlyNonNull) {
      ret.add(id.set(model.id));
      ret.add(categoryname.set(model.categoryname));
      ret.add(feedbackCategory.set(model.feedbackCategory));
      ret.add(hasbatch.set(model.hasbatch));
      ret.add(status.set(model.status));
      ret.add(createdAt.set(model.createdAt));
      ret.add(updatedAt.set(model.updatedAt));
      ret.add(deletedAt.set(model.deletedAt));
    } else if (only != null) {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(categoryname.name))
        ret.add(categoryname.set(model.categoryname));
      if (only.contains(feedbackCategory.name))
        ret.add(feedbackCategory.set(model.feedbackCategory));
      if (only.contains(hasbatch.name)) ret.add(hasbatch.set(model.hasbatch));
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
      if (model.categoryname != null) {
        ret.add(categoryname.set(model.categoryname));
      }
      if (model.feedbackCategory != null) {
        ret.add(feedbackCategory.set(model.feedbackCategory));
      }
      if (model.hasbatch != null) {
        ret.add(hasbatch.set(model.hasbatch));
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
    st.addStr(categoryname.name, isNullable: true);
    st.addStr(feedbackCategory.name, isNullable: true);
    st.addStr(hasbatch.name, isNullable: true);
    st.addStr(status.name, isNullable: true);
    st.addDateTime(createdAt.name, isNullable: true);
    st.addDateTime(updatedAt.name, isNullable: true);
    st.addDateTime(deletedAt.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(FeedbackCategory model,
      {bool cascade = false,
      bool onlyNonNull = false,
      Set<String> only}) async {
    final Insert insert = inserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<FeedbackCategory> models,
      {bool onlyNonNull = false, Set<String> only}) async {
    final List<List<SetColumn>> data = models
        .map((model) =>
            toSetColumns(model, only: only, onlyNonNull: onlyNonNull))
        .toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(FeedbackCategory model,
      {bool cascade = false,
      Set<String> only,
      bool onlyNonNull = false,
      isForeignKeyEnabled = false}) async {
    final Upsert upsert = upserter
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<FeedbackCategory> models,
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

  Future<int> update(FeedbackCategory model,
      {bool cascade = false,
      bool associate = false,
      Set<String> only,
      bool onlyNonNull = false}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only, onlyNonNull: onlyNonNull));
    return adapter.update(update);
  }

  Future<void> updateMany(List<FeedbackCategory> models,
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

  Future<FeedbackCategory> find(int id,
      {bool preload = false, bool cascade = false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await findOne(find);
  }

  Future<int> remove(int id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<FeedbackCategory> models) async {
// Return if models is empty. If this is not done, all records will be removed!
    if (models == null || models.isEmpty) return 0;
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }
}
