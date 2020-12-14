import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/performance.dart';

part 'performance_bean.jorm.dart';

@GenBean()
class PerformanceBean extends Bean<Performance> with _PerformanceBean {
  PerformanceBean(Adapter adapter) : super(adapter);
  final String tableName = 'performances';
}
