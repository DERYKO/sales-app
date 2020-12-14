import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/customer_record.dart';

part 'customer_record_bean.jorm.dart';

@GenBean()
class CustomerRecordBean extends Bean<CustomerRecord> with _CustomerRecordBean {
  CustomerRecordBean(Adapter adapter) : super(adapter);
  final String tableName = 'customer_records';
}
