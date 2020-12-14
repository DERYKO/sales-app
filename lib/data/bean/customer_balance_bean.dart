import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/customer_balance.dart';

part 'customer_balance_bean.jorm.dart';

@GenBean()
class CustomerBalanceBean extends Bean<CustomerBalance>
    with _CustomerBalanceBean {
  CustomerBalanceBean(Adapter adapter) : super(adapter);
  final String tableName = 'customer_balances';
}
