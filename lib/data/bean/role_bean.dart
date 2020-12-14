import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/role.dart';

part 'role_bean.jorm.dart';

@GenBean()
class RoleBean extends Bean<Role> with _RoleBean {
  RoleBean(Adapter adapter) : super(adapter);
  final String tableName = 'roles';
}
