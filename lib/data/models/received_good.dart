class ReceivedGood {
  int receivingId;
  String entryType;
  int supplierId;
  int employeeId;
  String comment;
  dynamic paymentType;
  String totalCost;
  dynamic reference;
  String lat;
  String lon;
  String file;
  DateTime receivingTime;
  String appValidation;
  dynamic appValidationBy;
  dynamic appValidationTime;
  dynamic appNotes;
  dynamic appLat;
  dynamic appLon;
  String stockpointValidation;
  dynamic stockpointValidationBy;
  dynamic stockpointValidationTime;
  dynamic stockpointNotes;
  dynamic stockpointLat;
  dynamic stockpointLon;
  DateTime createdAt;
  DateTime updatedAt;
  List<ReceivedDetail> receivedDetails;

  ReceivedGood({
    this.receivingId,
    this.entryType,
    this.supplierId,
    this.employeeId,
    this.comment,
    this.paymentType,
    this.totalCost,
    this.reference,
    this.lat,
    this.lon,
    this.file,
    this.receivingTime,
    this.appValidation,
    this.appValidationBy,
    this.appValidationTime,
    this.appNotes,
    this.appLat,
    this.appLon,
    this.stockpointValidation,
    this.stockpointValidationBy,
    this.stockpointValidationTime,
    this.stockpointNotes,
    this.stockpointLat,
    this.stockpointLon,
    this.createdAt,
    this.updatedAt,
    this.receivedDetails,
  });

  factory ReceivedGood.fromMap(Map<String, dynamic> json) => new ReceivedGood(
        receivingId: json["receiving_id"] == null ? null : json["receiving_id"],
        entryType: json["entry_type"] == null ? null : json["entry_type"],
        supplierId: json["supplier_id"] == null ? null : json["supplier_id"],
        employeeId: json["employee_id"] == null ? null : json["employee_id"],
        comment: json["comment"] == null ? null : json["comment"],
        paymentType: json["payment_type"],
        totalCost: json["total_cost"] == null ? null : json["total_cost"],
        reference: json["reference"],
        lat: json["lat"] == null ? null : json["lat"],
        lon: json["lon"] == null ? null : json["lon"],
        file: json["file"] == null ? null : json["file"],
        receivingTime: json["receiving_time"] == null
            ? null
            : DateTime.parse(json["receiving_time"]),
        appValidation:
            json["app_validation"] == null ? null : json["app_validation"],
        appValidationBy: json["app_validation_by"],
        appValidationTime: json["app_validation_time"],
        appNotes: json["app_notes"],
        appLat: json["app_lat"],
        appLon: json["app_lon"],
        stockpointValidation: json["stockpoint_validation"] == null
            ? null
            : json["stockpoint_validation"],
        stockpointValidationBy: json["stockpoint_validation_by"],
        stockpointValidationTime: json["stockpoint_validation_time"],
        stockpointNotes: json["stockpoint_notes"],
        stockpointLat: json["stockpoint_lat"],
        stockpointLon: json["stockpoint_lon"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        receivedDetails: json["received_details"] == null
            ? null
            : new List<ReceivedDetail>.from(
                json["received_details"].map((x) => ReceivedDetail.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "receiving_id": receivingId == null ? null : receivingId,
        "entry_type": entryType == null ? null : entryType,
        "supplier_id": supplierId == null ? null : supplierId,
        "employee_id": employeeId == null ? null : employeeId,
        "comment": comment == null ? null : comment,
        "payment_type": paymentType,
        "total_cost": totalCost == null ? null : totalCost,
        "reference": reference,
        "lat": lat == null ? null : lat,
        "lon": lon == null ? null : lon,
        "file": file == null ? null : file,
        "receiving_time":
            receivingTime == null ? null : receivingTime.toIso8601String(),
        "app_validation": appValidation == null ? null : appValidation,
        "app_validation_by": appValidationBy,
        "app_validation_time": appValidationTime,
        "app_notes": appNotes,
        "app_lat": appLat,
        "app_lon": appLon,
        "stockpoint_validation":
            stockpointValidation == null ? null : stockpointValidation,
        "stockpoint_validation_by": stockpointValidationBy,
        "stockpoint_validation_time": stockpointValidationTime,
        "stockpoint_notes": stockpointNotes,
        "stockpoint_lat": stockpointLat,
        "stockpoint_lon": stockpointLon,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "received_details": receivedDetails == null
            ? null
            : new List<dynamic>.from(receivedDetails.map((x) => x.toMap())),
      };
}

class ReceivedDetail {
  int id;
  int receivingId;
  int productId;
  dynamic description;
  dynamic serialnumber;
  int line;
  String quantityPurchased;
  String unitPrice;
  String costPrice;
  String productPackaging;
  String discountPercent;
  int storeId;
  String receivingQuantity;
  DateTime createdAt;
  DateTime updatedAt;

  ReceivedDetail({
    this.id,
    this.receivingId,
    this.productId,
    this.description,
    this.serialnumber,
    this.line,
    this.quantityPurchased,
    this.unitPrice,
    this.costPrice,
    this.productPackaging,
    this.discountPercent,
    this.storeId,
    this.receivingQuantity,
    this.createdAt,
    this.updatedAt,
  });

  factory ReceivedDetail.fromMap(Map<String, dynamic> json) =>
      new ReceivedDetail(
        id: json["id"] == null ? null : json["id"],
        receivingId: json["receiving_id"] == null ? null : json["receiving_id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        description: json["description"],
        serialnumber: json["serialnumber"],
        line: json["line"] == null ? null : json["line"],
        quantityPurchased: json["quantity_purchased"] == null
            ? null
            : json["quantity_purchased"],
        unitPrice: json["unit_price"] == null ? null : json["unit_price"],
        costPrice: json["cost_price"] == null ? null : json["cost_price"],
        productPackaging: json["product_packaging"] == null
            ? null
            : json["product_packaging"],
        discountPercent:
            json["discount_percent"] == null ? null : json["discount_percent"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        receivingQuantity: json["receiving_quantity"] == null
            ? null
            : json["receiving_quantity"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "receiving_id": receivingId == null ? null : receivingId,
        "product_id": productId == null ? null : productId,
        "description": description,
        "serialnumber": serialnumber,
        "line": line == null ? null : line,
        "quantity_purchased":
            quantityPurchased == null ? null : quantityPurchased,
        "unit_price": unitPrice == null ? null : unitPrice,
        "cost_price": costPrice == null ? null : costPrice,
        "product_packaging": productPackaging == null ? null : productPackaging,
        "discount_percent": discountPercent == null ? null : discountPercent,
        "store_id": storeId == null ? null : storeId,
        "receiving_quantity":
            receivingQuantity == null ? null : receivingQuantity,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };
}
