import 'package:jaguar_orm/jaguar_orm.dart';

class PriceList {
  @Column(isNullable: true)
  int pricelistId;
  @Column(isNullable: true)
  int productId;
  @Column(isNullable: true)
  String pricelistName;
  @Column(isNullable: true)
  String productCode;
  @Column(isNullable: true)
  String packetsBuying;
  @Column(isNullable: true)
  String cartonBuying;
  @Column(isNullable: true)
  String pricePkts;
  @Column(isNullable: true)
  String priceCrtns;

  PriceList({
    this.pricelistId,
    this.productId,
    this.pricelistName,
    this.productCode,
    this.packetsBuying,
    this.cartonBuying,
    this.pricePkts,
    this.priceCrtns,
  });

  factory PriceList.fromMap(Map<String, dynamic> json) => PriceList(
        pricelistId: json["pricelist_id"],
        productId: json["product_id"],
        pricelistName: json["pricelist_name"],
        productCode: json["product_code"],
        packetsBuying: json["packets_buying"],
        cartonBuying: json["carton_buying"],
        pricePkts: json["price_pkts"],
        priceCrtns: json["price_crtns"],
      );

  Map<String, dynamic> toMap() => {
        "pricelist_id": pricelistId,
        "product_id": productId,
        "pricelist_name": pricelistName,
        "product_code": productCode,
        "packets_buying": packetsBuying,
        "carton_buying": cartonBuying,
        "price_pkts": pricePkts,
        "price_crtns": priceCrtns,
      };
}
