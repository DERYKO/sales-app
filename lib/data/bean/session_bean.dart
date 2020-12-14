import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/session.dart';

part 'session_bean.jorm.dart';

@GenBean()
class SessionBean extends Bean<Session> with _SessionBean {
  SessionBean(Adapter adapter) : super(adapter);
  final String tableName = 'sessions';
}
