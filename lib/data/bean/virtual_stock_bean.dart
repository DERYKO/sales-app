import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/virtual_stock.dart';

part 'virtual_stock_bean.jorm.dart';

@GenBean()
class VirtualStockBean extends Bean<VirtualStock> with _VirtualStockBean {
  VirtualStockBean(Adapter adapter) : super(adapter);
  final String tableName = 'virtual_stocks';
}
