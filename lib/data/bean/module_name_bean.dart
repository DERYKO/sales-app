import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/module_name.dart';

part 'module_name_bean.jorm.dart';

@GenBean()
class ModuleNameBean extends Bean<ModuleName> with _ModuleNameBean {
  ModuleNameBean(Adapter adapter) : super(adapter);
  final String tableName = 'module_names';
}
