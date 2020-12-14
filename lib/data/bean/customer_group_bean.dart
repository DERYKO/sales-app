import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/customer_group.dart';

part 'customer_group_bean.jorm.dart';

@GenBean()
class CustomerGroupBean extends Bean<CustomerGroup> with _CustomerGroupBean {
  CustomerGroupBean(Adapter adapter) : super(adapter);
  final String tableName = 'customer_groups';
}
