import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/date_week.dart';

part 'date_week_bean.jorm.dart';

@GenBean()
class DateWeekBean extends Bean<DateWeek> with _DateWeekBean {
  DateWeekBean(Adapter adapter) : super(adapter);
  final String tableName = 'date_weeks';
}
