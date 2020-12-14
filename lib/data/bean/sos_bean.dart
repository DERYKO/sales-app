import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/sos.dart';

part 'sos_bean.jorm.dart';

@GenBean()
class SosBean extends Bean<Sos> with _SosBean {
  SosBean(Adapter adapter) : super(adapter);
  final String tableName = 'sos';
}
