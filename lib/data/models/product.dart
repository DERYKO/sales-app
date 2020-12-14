import 'package:jaguar_orm/jaguar_orm.dart';

class Product {
  @PrimaryKey(auto: false)
  int productId;
  @Column(isNullable: true)
  int companyId;
  @Column(isNullable: true)
  String productRef;
  int focusProduct;
  @Column(isNullable: true)
  String iscompetitor;
  @Column(isNullable: true)
  String companyName;
  @Column(isNullable: true)
  String productDiv;
  @Column(isNullable: true)
  String productValcode;
  @Column(isNullable: true)
  String productCategory;
  @Column(isNullable: true)
  String productCode;
  @Column(isNullable: true)
  String productDesc;
  @Column(isNullable: true)
  String productName;
  @Column(isNullable: true)
  String productPackaging;
  @Column(isNullable: true)
  String taxCode;
  @Column(isNullable: true)
  int crtQnty;
  @Column(isNullable: true)
  String productUnit;
  @Column(isNullable: true)
  String priceCrtns;
  @Column(isNullable: true)
  String pricePkts;
  @Column(isNullable: true)
  String productStatus;
  @Column(isNullable: true)
  String createdAt;
  @Column(isNullable: true)
  String updatedAt;

  Product({
    this.companyId,
    this.companyName,
    this.productId,
    this.productRef,
    this.focusProduct,
    this.iscompetitor,
    this.productDiv,
    this.productValcode,
    this.productCategory,
    this.productCode,
    this.productDesc,
    this.productName,
    this.productPackaging,
    this.taxCode,
    this.crtQnty,
    this.productUnit,
    this.priceCrtns,
    this.pricePkts,
    this.productStatus,
    this.createdAt,
    this.updatedAt,
  });

  Product.fromMap(Map<String, dynamic> json) {
    companyId = json['company_id'];
    companyName = json['company_name'];
    productId = json['product_id'];
    productRef = json['product_ref'];
    focusProduct = json['focus_product'];
    iscompetitor = json['iscompetitor'];
    productDiv = json['product_div'];
    productValcode = json['product_valcode'];
    productCategory = json['product_category'];
    productCode = json['product_code'];
    productDesc = json['product_desc'];
    productName = json['product_name'];
    productPackaging = json['product_packaging'];
    taxCode = json['tax_code'];
    crtQnty = json['crt_qnty'];
    productUnit = json['product_unit'];
    priceCrtns = json['price_crtns'];
    pricePkts = json['price_pkts'];
    productStatus = json['product_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_id'] = this.companyId;
    data['company_name'] = this.companyName;
    data['product_id'] = this.productId;
    data['product_ref'] = this.productRef;
    data['focus_product'] = this.focusProduct;
    data['iscompetitor'] = this.iscompetitor;
    data['product_div'] = this.productDiv;
    data['product_valcode'] = this.productValcode;
    data['product_category'] = this.productCategory;
    data['product_code'] = this.productCode;
    data['product_desc'] = this.productDesc;
    data['product_name'] = this.productName;
    data['product_packaging'] = this.productPackaging;
    data['tax_code'] = this.taxCode;
    data['crt_qnty'] = this.crtQnty;
    data['product_unit'] = this.productUnit;
    data['price_crtns'] = this.priceCrtns;
    data['price_pkts'] = this.pricePkts;
    data['product_status'] = this.productStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
