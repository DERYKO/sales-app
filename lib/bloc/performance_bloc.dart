import 'package:flutter/material.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/reports_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/dialogs/contact_customer_dialog.dart';
import 'package:solutech_sat/ui/screen/customers_screen.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:solutech_sat/ui/screen/products_report_screen.dart';
import 'package:solutech_sat/ui/widgets/filled_dropdown_button.dart';

class PerformanceBloc extends Bloc {
  List<DateTime> pickedDates = [
    DateTime.now(),
    DateTime.now(),
  ];
  List<int> years = [2017, 2018, 2019, 2020];
  List<int> periods = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  int year = 2020;
  int period = 1;
  void filterByDate() async {
    if (connectionManager.isConnected) {
      final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: pickedDates.first,
        initialLastDate: pickedDates.last,
        firstDate: DateTime(2015),
        lastDate: DateTime.now(),
      );
      if (picked != null && picked.length > 0) {
        pickedDates = picked;
        reportsManager.loadCatlist(picked);
      }
    } else {
      alert("You are offline", "Make sure you enable data to continue");
    }
  }

  void filterByPeriod() {
    showDialog(
        context: context,
        child: Dialog(
          child: StreamBuilder(
              stream: stream,
              builder: (context, snapshot) {
                return Container(
                  height: 220.0,
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Select period",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      FilledDropdownButton(
                        isDense: true,
                        value: year,
                        label: "Year",
                        hint: "Select year",
                        padding: EdgeInsets.only(bottom: 5.0),
                        items: years.map((year) {
                          return DropdownMenuItem(
                            child: Text("$year"),
                            value: year,
                          );
                        }).toList(),
                        onChange: onYearChange,
                      ),
                      FilledDropdownButton(
                        isDense: true,
                        value: period,
                        label: "Period",
                        hint: "Select period",
                        padding: EdgeInsets.only(bottom: 5.0),
                        items: periods.map((period) {
                          return DropdownMenuItem(
                            child: Text("$period"),
                            value: period,
                          );
                        }).toList(),
                        onChange: onPeriodChange,
                      ),
                      Container(
                        width: double.infinity,
                        child: MaterialButton(
                          height: 40.0,
                          textColor: Colors.white,
                          color: Theme.of(context).accentColor,
                          onPressed: () {
                            pop();
                            onRefresh();
                          },
                          child: Text("FILTER"),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ));
  }

  void onRefresh() {
    if (connectionManager.isConnected) {
      reportsManager
          .loadPerformance(pickedDates, year, period)
          .catchError((error) {
        reportsManager.loadingPerformance = false;
      });
    } else {
      alert("You are offline", "Make sure you enable data then tap on refresh");
    }
  }

  void onYearChange(value) {
    year = value;
    notifyChanges();
  }

  void onPeriodChange(value) {
    period = value;
    notifyChanges();
  }

  void openProductsReport(String category) {
    navigate(
        screen: ProductsReportScreen(
      category: category,
      pickedDates: pickedDates,
    ));
  }

  @override
  void initState() {
    super.initState();
    if (connectionManager.isConnected) {
      reportsManager
          .loadPerformance(pickedDates, year, period)
          .catchError((error) {
        reportsManager.loadingPerformance = false;
      });
    } else {
      Future.delayed(Duration(milliseconds: 1)).then((done) {
        alert(
            "You are offline", "Make sure you enable data then tap on refresh");
      });
    }
  }
}
