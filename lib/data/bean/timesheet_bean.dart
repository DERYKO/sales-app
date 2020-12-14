import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/timesheet.dart';

part 'timesheet_bean.jorm.dart';

@GenBean()
class TimesheetBean extends Bean<Timesheet> with _TimesheetBean {
  TimesheetBean(Adapter adapter) : super(adapter);
  final String tableName = 'timesheets';
}
