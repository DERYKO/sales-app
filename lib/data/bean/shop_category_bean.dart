import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/shop_category.dart';

part 'shop_category_bean.jorm.dart';

@GenBean()
class ShopCategoryBean extends Bean<ShopCategory> with _ShopCategoryBean {
  ShopCategoryBean(Adapter adapter) : super(adapter);
  final String tableName = 'shop_categories';
}
