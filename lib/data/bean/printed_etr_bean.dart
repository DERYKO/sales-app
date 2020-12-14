import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/printed_etr.dart';

part 'printed_etr_bean.jorm.dart';

@GenBean()
class PrintedEtrBean extends Bean<PrintedEtr> with _PrintedEtrBean {
  PrintedEtrBean(Adapter adapter) : super(adapter);
  final String tableName = 'printed_etrs';
}
