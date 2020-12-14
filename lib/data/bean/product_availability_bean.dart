import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/product_availability.dart';

part 'product_availability_bean.jorm.dart';

@GenBean()
class ProductAvailabilityBean extends Bean<ProductAvailability> with _ProductAvailabilityBean {
  ProductAvailabilityBean(Adapter adapter) : super(adapter);
  final String tableName = 'product_availabilities';
}
