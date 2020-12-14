import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/bank.dart';

part 'bank_bean.jorm.dart';

@GenBean()
class BankBean extends Bean<Bank> with _BankBean {
  BankBean(Adapter adapter) : super(adapter);
  final String tableName = 'banks';
}
