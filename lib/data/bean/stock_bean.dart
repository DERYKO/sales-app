import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/route_plan.dart';
import 'package:solutech_sat/data/models/role.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/stock.dart';

part 'stock_bean.jorm.dart';

@GenBean()
class StockBean extends Bean<Stock> with _StockBean {
  StockBean(Adapter adapter) : super(adapter);
  final String tableName = 'stocks';
}
