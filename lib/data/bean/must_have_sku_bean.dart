import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/must_have_sku.dart';

part 'must_have_sku_bean.jorm.dart';

@GenBean()
class MustHaveSkuBean extends Bean<MustHaveSku> with _MustHaveSkuBean {
  MustHaveSkuBean(Adapter adapter) : super(adapter);
  final String tableName = 'must_have_skus';
}
