import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/delivery_order_detail.dart';

part 'delivery_order_detail_bean.jorm.dart';

@GenBean()
class DeliveryOrderDetailBean extends Bean<DeliveryOrderDetail>
    with _DeliveryOrderDetailBean {
  DeliveryOrderDetailBean(Adapter adapter) : super(adapter);
  final String tableName = 'delivery_order_details';
}
