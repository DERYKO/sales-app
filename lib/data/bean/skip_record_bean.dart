import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/role.dart';
import 'package:solutech_sat/data/models/skip_record.dart';

part 'skip_record_bean.jorm.dart';

@GenBean()
class SkipRecordBean extends Bean<SkipRecord> with _SkipRecordBean {
  SkipRecordBean(Adapter adapter) : super(adapter);
  final String tableName = 'skip_records';
}
