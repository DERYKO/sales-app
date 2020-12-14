import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/date_week.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/shop_category.dart';

class Commons {
  List<ShopCategory> shopCategories;
  List<Product> products;
  List<AppData> appdata;
  List<DateWeek> dateweeks;

  Commons({
    this.shopCategories,
    this.products,
    this.appdata,
    this.dateweeks,
  });

  factory Commons.fromMap(Map<String, dynamic> json) => new Commons(
        shopCategories: json["shop-category"] == null
            ? null
            : new List<ShopCategory>.from(
                json["shop-category"].map((x) => ShopCategory.fromMap(x))),
        products: json["products"] == null
            ? null
            : new List<Product>.from(
                json["products"].map((x) => Product.fromMap(x))),
        appdata: json["appdata"] == null
            ? null
            : new List<AppData>.from(
                json["appdata"].map((x) => AppData.fromMap(x))),
        dateweeks: json["dateweek"] == null
            ? null
            : new List<DateWeek>.from(
                json["dateweek"].map((x) => DateWeek.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "shop-category": shopCategories == null
            ? null
            : new List<dynamic>.from(shopCategories.map((x) => x.toMap())),
        "products": products == null
            ? null
            : new List<dynamic>.from(products.map((x) => x.toMap())),
        "appdata": appdata == null
            ? null
            : new List<dynamic>.from(appdata.map((x) => x.toMap())),
        "dateweek": dateweeks == null
            ? null
            : new List<dynamic>.from(dateweeks.map((x) => x.toMap())),
      };
}
