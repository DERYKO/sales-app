import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/initiative_qualify.dart';

part 'initiative_qualify_bean.jorm.dart';

@GenBean()
class InitiativeQualifyBean extends Bean<InitiativeQualify>
    with _InitiativeQualifyBean {
  InitiativeQualifyBean(Adapter adapter) : super(adapter);
  final String tableName = 'initiatives_qualify';
}
