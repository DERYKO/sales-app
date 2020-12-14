import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/product.dart';

part 'product_bean.jorm.dart';

@GenBean()
class ProductBean extends Bean<Product> with _ProductBean {
  ProductBean(Adapter adapter) : super(adapter);
  final String tableName = 'products';
}
