import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/brand.dart';

part 'brand_bean.jorm.dart';

@GenBean()
class BrandBean extends Bean<Brand> with _BrandBean {
  BrandBean(Adapter adapter) : super(adapter);
  final String tableName = 'brands';
}
