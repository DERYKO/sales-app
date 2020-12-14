import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/app_data.dart';

part 'app_data_bean.jorm.dart';

@GenBean()
class AppDataBean extends Bean<AppData> with _AppDataBean {
  AppDataBean(Adapter adapter) : super(adapter);
  final String tableName = 'appdatas';
}
