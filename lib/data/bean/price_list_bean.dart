import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/price_list.dart';

part 'price_list_bean.jorm.dart';

@GenBean()
class PriceListBean extends Bean<PriceList> with _PriceListBean {
  PriceListBean(Adapter adapter) : super(adapter);
  final String tableName = 'price_lists';
}
