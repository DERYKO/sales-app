class SalesSummary {
  String monthTarget;
  String monthSales;
  String checkins;
  String performance;
  String target;
  String targetValue;
  String success;
  String actual;
  String orderTotalCost;
  String totalSales;

  SalesSummary({
    this.monthTarget,
    this.monthSales,
    this.checkins,
    this.performance,
    this.target,
    this.targetValue,
    this.success,
    this.actual,
    this.orderTotalCost,
    this.totalSales,
  });

  SalesSummary.fromMap(Map<String, dynamic> json) {
    monthTarget = "${json['MonthTarget'] ?? 0}";
    monthSales = "${json['MonthSales'] ?? 0}";
    checkins = "${json['Checkins'] ?? 0}";
    performance = "${json['Performance'] ?? 0}";
    target = "${json['Target'] ?? 0}";
    targetValue = "${json['TargetValue'] ?? 0}";
    success = "${json['Success'] ?? 0}";
    actual = "${json['Actual'] ?? 0}";
    orderTotalCost = "${json['OrderTotalCost'] ?? 0}";
    totalSales = "${json['TotalSales'] ?? 0}";
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MonthTarget'] = this.monthTarget;
    data['MonthSales'] = this.monthSales;
    data['Checkins'] = this.checkins;
    data['Performance'] = this.performance;
    data['Target'] = this.target;
    data['TargetValue'] = this.targetValue;
    data['Success'] = this.success;
    data['Actual'] = this.actual;
    data['OrderTotalCost'] = this.orderTotalCost;
    data['TotalSales'] = this.totalSales;
    return data;
  }
}
