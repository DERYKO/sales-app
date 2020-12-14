import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/sod.dart';

part 'sod_bean.jorm.dart';

@GenBean()
class SodBean extends Bean<Sod> with _SodBean {
  SodBean(Adapter adapter) : super(adapter);
  final String tableName = 'sods';
}
