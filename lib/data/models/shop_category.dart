import 'dart:async';

import 'package:jaguar_orm/jaguar_orm.dart';

class ShopCategory {
  @PrimaryKey(auto: false)
  int shopcatId;
  @Column(isNullable: true)
  String shopCatName;
  @Column(isNullable: true)
  String status;
  @Column(isNullable: true)
  String mapMarker;
  @Column(isNullable: true)
  String createdAt;
  @Column(isNullable: true)
  String updatedAt;

  ShopCategory(
      {this.shopcatId,
      this.shopCatName,
      this.status,
      this.mapMarker,
      this.createdAt,
      this.updatedAt});

  ShopCategory.fromMap(Map<String, dynamic> json) {
    shopcatId = json['shopcat_id'];
    shopCatName = json['shop_cat_name'];
    status = json['status'];
    mapMarker = json['map_marker'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopcat_id'] = this.shopcatId;
    data['shop_cat_name'] = this.shopCatName;
    data['status'] = this.status;
    data['map_marker'] = this.mapMarker;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
