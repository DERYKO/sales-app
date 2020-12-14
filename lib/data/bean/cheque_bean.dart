import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/cheque.dart';

part 'cheque_bean.jorm.dart';

@GenBean()
class ChequeBean extends Bean<Cheque> with _ChequeBean {
  ChequeBean(Adapter adapter) : super(adapter);
  final String tableName = 'cheques';
}
