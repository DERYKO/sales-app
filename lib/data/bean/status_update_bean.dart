import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/status_update.dart';

part 'status_update_bean.jorm.dart';

@GenBean()
class StatusUpdateBean extends Bean<StatusUpdate> with _StatusUpdateBean {
  StatusUpdateBean(Adapter adapter) : super(adapter);
  final String tableName = 'status_updates';
}
