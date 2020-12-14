import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/product_update.dart';

part 'product_update_bean.jorm.dart';

@GenBean()
class ProductUpdateBean extends Bean<ProductUpdate> with _ProductUpdateBean {
  ProductUpdateBean(Adapter adapter) : super(adapter);
  final String tableName = 'product_updates';
}
