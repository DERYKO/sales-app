import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/posm.dart';

part 'posm_bean.jorm.dart';

@GenBean()
class PosmBean extends Bean<Posm> with _PosmBean {
  PosmBean(Adapter adapter) : super(adapter);
  final String tableName = 'posms';
}
