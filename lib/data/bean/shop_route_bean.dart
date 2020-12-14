import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/shop_route.dart';

part 'shop_route_bean.jorm.dart';

@GenBean()
class ShopRouteBean extends Bean<ShopRoute> with _ShopRouteBean {
  ShopRouteBean(Adapter adapter) : super(adapter);
  final String tableName = 'shop_routes';
}
