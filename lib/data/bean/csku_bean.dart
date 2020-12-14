import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/csku.dart';

part 'csku_bean.jorm.dart';

@GenBean()
class CskuBean extends Bean<Csku> with _CskuBean {
  CskuBean(Adapter adapter) : super(adapter);
  final String tableName = 'sckus';
}
