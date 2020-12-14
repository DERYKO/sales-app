import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/stockpoint.dart';

part 'stockpoint_bean.jorm.dart';

@GenBean()
class StockpointBean extends Bean<Stockpoint> with _StockpointBean {
  StockpointBean(Adapter adapter) : super(adapter);
  final String tableName = 'stockpoints';
}
