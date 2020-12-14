import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/collection_item.dart';

part 'collection_item_bean.jorm.dart';

@GenBean()
class CollectionItemBean extends Bean<CollectionItem> with _CollectionItemBean {
  CollectionItemBean(Adapter adapter) : super(adapter);
  final String tableName = 'collection_items';
}
