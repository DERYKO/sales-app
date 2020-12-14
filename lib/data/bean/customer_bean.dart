import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/route_plan.dart';
import 'package:solutech_sat/data/models/role.dart';
import 'package:solutech_sat/data/models/customer.dart';

part 'customer_bean.jorm.dart';

@GenBean()
class CustomerBean extends Bean<Customer> with _CustomerBean {
  CustomerBean(Adapter adapter) : super(adapter);
  final String tableName = 'shops';
}
