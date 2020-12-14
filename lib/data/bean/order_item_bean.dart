import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/order.dart';
import 'package:solutech_sat/data/models/order_item.dart';
part 'order_item_bean.jorm.dart';

@GenBean()
class OrderItemBean extends Bean<OrderItem> with _OrderItemBean {
  OrderItemBean(Adapter adapter) : super(adapter);
  final String tableName = 'order_items';
}
