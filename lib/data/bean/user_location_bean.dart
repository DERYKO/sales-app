import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/user_location.dart';

part 'user_location_bean.jorm.dart';

@GenBean()
class UserLocationBean extends Bean<UserLocation> with _UserLocationBean {
  UserLocationBean(Adapter adapter) : super(adapter);
  final String tableName = 'user_locations';
}
