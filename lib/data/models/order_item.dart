import 'package:jaguar_orm/jaguar_orm.dart';

class OrderItem {
  @Column(
    isNullable: true,
  )
  int orderitemId;
  @Column(
    isNullable: true,
  )
  int orderId;
  @Column(
    isNullable: true,
  )
  int productId;
  @Column(
    isNullable: true,
  )
  int quantity;
  @Column(
    isNullable: true,
  )
  String ordered;
  @Column(
    isNullable: true,
  )
  String batchnumber;
  @Column(
    isNullable: true,
  )
  int cartonQuantity;
  @Column(
    isNullable: true,
  )
  int orderQuantity;
  @Column(
    isNullable: true,
  )
  int distribution;
  @Column(
    isNullable: true,
  )
  String sellingPrice;
  @Column(
    isNullable: true,
  )
  String productPackaging;
  @Column(
    isNullable: true,
  )
  String sellingTotalcost;
  @Column(
    isNullable: true,
  )
  String orderitemTotalcost;
  @Column(
    isNullable: true,
  )
  String itemTotalcost;
  @Column(
    isNullable: true,
  )
  int orderitemStatus;
  @Column(
    isNullable: true,
  )
  String changeReason;
  @Column(
    isNullable: true,
  )
  DateTime createdAt;
  @Column(
    isNullable: true,
  )
  DateTime updatedAt;

  OrderItem({
    this.orderitemId,
    this.orderId,
    this.productId,
    this.quantity,
    this.ordered,
    this.batchnumber,
    this.orderQuantity,
    this.distribution,
    this.sellingPrice,
    this.cartonQuantity,
    this.productPackaging,
    this.sellingTotalcost,
    this.orderitemTotalcost,
    this.itemTotalcost,
    this.orderitemStatus,
    this.changeReason,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderItem.fromMap(Map<String, dynamic> json) => new OrderItem(
        orderitemId: json["orderitem_id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        ordered: json["ordered"],
        batchnumber: json["batchnumber"],
        orderQuantity: json["order_quantity"],
        distribution: json["distribution"],
        sellingPrice: json["selling_price"],
        productPackaging: json["product_packaging"],
        sellingTotalcost: json["selling_totalcost"],
        orderitemTotalcost: json["orderitem_totalcost"],
        itemTotalcost: json["item_totalcost"],
        cartonQuantity: json["carton_quantity"],
        orderitemStatus: json["orderitem_status"],
        changeReason: json["change_reason"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "orderitem_id": orderitemId == null ? null : orderitemId,
        "order_id": orderId == null ? null : orderId,
        "product_id": productId == null ? null : productId,
        "quantity": quantity == null ? null : quantity,
        "ordered": ordered == null ? null : ordered,
        "batchnumber": batchnumber == null ? null : batchnumber,
        "order_quantity": orderQuantity == null ? null : orderQuantity,
        "distribution": distribution == null ? null : distribution,
        "selling_price": sellingPrice == null ? null : sellingPrice,
        "product_packaging": productPackaging == null ? null : productPackaging,
        "selling_totalcost": sellingTotalcost == null ? null : sellingTotalcost,
        "orderitem_totalcost":
            orderitemTotalcost == null ? null : orderitemTotalcost,
        "carton_quantity": cartonQuantity,
        "item_totalcost": itemTotalcost == null ? null : itemTotalcost,
        "orderitem_status": orderitemStatus == null ? null : orderitemStatus,
        "change_reason": changeReason == null ? null : changeReason,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };
}
