import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';

String formatDate([date, String format = 'dd/MM/yyyy']) {
  try {
    // var d = date ?? DateTime.now();
    if (format == "dt") {
      return "${formatDate(date)} ${formatDate(date, "jm")}";
    }
    if (format == "xt") {
      return date != null ? (date as String).split(".")[0] : null;
    }
    var ourDate = (date is String || date == "")
        ? DateTime.parse(date)
        : (date is DateTime) ? date : DateTime.now();
    var dateFormatter = new DateFormat(format);
    String formattedDate = dateFormatter.format(ourDate);
    return formattedDate;
  } catch (e) {
    print("Error while parsing date $date, $format");
    return "No time";
  }
}
//dd-MM-yyyy HH:mm:ss

List<String> filterDatesFrom(List<DateTime> pickedDates,
    [String format = "dd/MM/yyyy"]) {
  if (pickedDates == null || pickedDates.length == 0) {
    return [
      formatDate(DateTime.now(), format),
      formatDate(DateTime.now(), format)
    ];
  } else {
    return [
      formatDate(pickedDates.first, format),
      formatDate(pickedDates.last, format)
    ];
  }
}

String formatCurrency(number) {
  return FlutterMoneyFormatter(
    amount: double.parse("${number ?? 0}"),
  ).output.nonSymbol;
}

String timeDifference(String startDate, String endDate) {
  var time = DateTime.parse(startDate)
      .difference(DateTime.parse(endDate ?? DateTime.now().toIso8601String()));
  var spent = time.abs().toString().split(".")[0].split(":");
  var pretty =
      "${spent[0]} ${int.parse(spent[0]) == 1 ? "hr" : "hrs"} ${spent[1]} min";
  return pretty;
}
