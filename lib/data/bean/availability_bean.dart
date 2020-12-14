import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/availability.dart';

part 'availability_bean.jorm.dart';

@GenBean()
class AvailabilityBean extends Bean<Availability> with _AvailabilityBean {
  AvailabilityBean(Adapter adapter) : super(adapter);
  final String tableName = 'availabilities';
}
