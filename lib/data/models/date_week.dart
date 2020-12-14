import 'package:jaguar_orm/jaguar_orm.dart';

class DateWeek {
  @PrimaryKey(auto: false)
  int dateweekId;
  @Column(isNullable: true)
  DateTime date;
  @Column(isNullable: true)
  int week;

  DateWeek({
    this.dateweekId,
    this.date,
    this.week,
  });

  factory DateWeek.fromMap(Map<String, dynamic> json) => new DateWeek(
        dateweekId: json["dateweek_id"] == null ? null : json["dateweek_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        week: json["week"] == null ? null : json["week"],
      );

  Map<String, dynamic> toMap() => {
        "dateweek_id": dateweekId == null ? null : dateweekId,
        "date": date == null
            ? null
            : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "week": week == null ? null : week,
      };
}
