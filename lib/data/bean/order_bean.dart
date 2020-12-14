import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/order.dart';
part 'order_bean.jorm.dart';

@GenBean()
class OrderBean extends Bean<Order> with _OrderBean {
  OrderBean(Adapter adapter) : super(adapter);
  final String tableName = 'orders';
}
