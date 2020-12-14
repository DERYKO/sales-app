import 'package:solutech_sat/data/models/price_list.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/pricelist_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';

class PricelistsBloc extends Bloc {
  PriceList pricelist;

  void onPriceListChange(value) {
    pricelist = value;
    notifyChanges();
  }

  Product getProduct(index) {
    return commonsManager.products.firstWhere(
        (product) =>
            product.productId ==
            priceListsManager
                .getPriceListOfAssignedProducts(pricelist)[index]
                .productId,
        orElse: () => null);
  }

  void refresh() {}
  @override
  void initState() {
    super.initState();
    onPriceListChange(priceListsManager.uniquePriceLists.first);
  }
}
