import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/stockpoint_stock_level.dart';

part 'stockpoint_stock_level_bean.jorm.dart';

@GenBean()
class StockpointStockLevelBean extends Bean<StockpointStockLevel>
    with _StockpointStockLevelBean {
  StockpointStockLevelBean(Adapter adapter) : super(adapter);
  final String tableName = 'stockpoint_stock_levels';
}
