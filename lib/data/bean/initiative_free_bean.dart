import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/initiative_free.dart';
import 'package:solutech_sat/data/models/initiative_qualify.dart';

part 'initiative_free_bean.jorm.dart';

@GenBean()
class InitiativeFreeBean extends Bean<InitiativeFree> with _InitiativeFreeBean {
  InitiativeFreeBean(Adapter adapter) : super(adapter);
  final String tableName = 'initiatives_free';
}
