import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/sos_item.dart';

part 'sos_item_bean.jorm.dart';

@GenBean()
class SosItemBean extends Bean<SosItem> with _SosItemBean {
  SosItemBean(Adapter adapter) : super(adapter);
  final String tableName = 'sos_items';
}
