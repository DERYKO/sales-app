import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/route_plan.dart';
import 'package:solutech_sat/data/models/role.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/stock.dart';
import 'package:solutech_sat/data/models/stock_take.dart';
import 'package:solutech_sat/data/models/stock_take_item.dart';

part 'stock_take_item_bean.jorm.dart';

@GenBean()
class StockTakeItemBean extends Bean<StockTakeItem> with _StockTakeItemBean {
  StockTakeItemBean(Adapter adapter) : super(adapter);
  final String tableName = 'stock_take_items';
}
