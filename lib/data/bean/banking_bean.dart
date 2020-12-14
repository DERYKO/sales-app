import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/banking.dart';

part 'banking_bean.jorm.dart';

@GenBean()
class BankingBean extends Bean<Banking> with _BankingBean {
  BankingBean(Adapter adapter) : super(adapter);
  final String tableName = 'bankings';
}
