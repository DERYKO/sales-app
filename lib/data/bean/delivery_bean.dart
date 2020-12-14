import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/delivery.dart';

part 'delivery_bean.jorm.dart';

@GenBean()
class DeliveryBean extends Bean<Delivery> with _DeliveryBean {
  DeliveryBean(Adapter adapter) : super(adapter);
  final String tableName = 'deliveries';
}
