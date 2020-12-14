import 'package:jaguar_orm/jaguar_orm.dart';

class MonthlyPerformance {
  int commission;
  String totalCost;
  int targetValue;
  String salerPerformance;
  String yearMonth;

  MonthlyPerformance({
    this.commission,
    this.totalCost,
    this.targetValue,
    this.salerPerformance,
    this.yearMonth,
  });

  factory MonthlyPerformance.fromMap(Map<String, dynamic> json) =>
      MonthlyPerformance(
        commission: json["commission"],
        totalCost: json["total_cost"],
        targetValue: json["target_value"],
        salerPerformance: json["saler_performance"],
        yearMonth: json["YearMonth"],
      );

  Map<String, dynamic> toMap() => {
        "commission": commission,
        "total_cost": totalCost,
        "target_value": targetValue,
        "saler_performance": salerPerformance,
        "YearMonth": yearMonth,
      };
}
