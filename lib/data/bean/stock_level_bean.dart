import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/stock_level.dart';

part 'stock_level_bean.jorm.dart';

@GenBean()
class StockLevelBean extends Bean<StockLevel> with _StockLevelBean {
  StockLevelBean(Adapter adapter) : super(adapter);
  final String tableName = 'stocklevels';
}
