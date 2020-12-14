import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/availability_item.dart';

part 'availability_item_bean.jorm.dart';

@GenBean()
class AvailabilityItemBean extends Bean<AvailabilityItem>
    with _AvailabilityItemBean {
  AvailabilityItemBean(Adapter adapter) : super(adapter);
  final String tableName = 'availability_items';
}
