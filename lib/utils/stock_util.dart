import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:solutech_sat/data/database.dart';

Future<int> getStockpointLevel(int productId) async {
  var stockLevel = await db?.stockpointStockLevelBean?.findOne(Find(
      "stockpoint_stock_levels",
      where: await db?.stockpointStockLevelBean?.productId?.eq(productId)));
  return int.parse("${stockLevel?.quantity ?? 0}");
}
