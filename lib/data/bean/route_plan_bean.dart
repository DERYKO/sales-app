import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/route_plan.dart';

part 'route_plan_bean.jorm.dart';

@GenBean()
class RoutePlanBean extends Bean<RoutePlan> with _RoutePlanBean {
  RoutePlanBean(Adapter adapter) : super(adapter);
  final String tableName = 'route_plans';
}
