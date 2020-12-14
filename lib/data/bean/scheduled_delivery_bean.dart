import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/scheduled_delivery.dart';

part 'scheduled_delivery_bean.jorm.dart';

@GenBean()
class ScheduledDeliveryBean extends Bean<ScheduledDelivery>
    with _ScheduledDeliveryBean {
  ScheduledDeliveryBean(Adapter adapter) : super(adapter);
  final String tableName = 'scheduled_deliveries';
}
