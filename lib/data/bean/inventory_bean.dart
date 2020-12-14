import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:solutech_sat/data/models/inventory.dart';

part 'inventory_bean.jorm.dart';

@GenBean()
class InventoryBean extends Bean<Inventory> with _InventoryBean {
  InventoryBean(Adapter adapter) : super(adapter);
  final String tableName = 'inventories';
}
