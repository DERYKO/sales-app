import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/product_availability.dart';
import 'package:solutech_sat/data/models/product_availability_detail.dart';

part 'product_availability_detail_bean.jorm.dart';

@GenBean()
class ProductAvailabilityDetailBean extends Bean<ProductAvailabilityDetail>
    with _ProductAvailabilityDetailBean {
  ProductAvailabilityDetailBean(Adapter adapter) : super(adapter);
  final String tableName = 'product_availability_details';
}
