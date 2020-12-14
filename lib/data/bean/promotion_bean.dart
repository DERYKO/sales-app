import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/promotion.dart';

part 'promotion_bean.jorm.dart';

@GenBean()
class PromotionBean extends Bean<Promotion> with _PromotionBean {
  PromotionBean(Adapter adapter) : super(adapter);
  final String tableName = 'promotions';
}
