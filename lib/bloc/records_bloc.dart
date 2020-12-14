import 'package:solutech_sat/data/models/order.dart';
import 'package:solutech_sat/data/models/order_item.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/dialogs/contact_customer_dialog.dart';
import 'package:solutech_sat/ui/screen/customers_screen.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:solutech_sat/ui/screen/etr_printing_screen.dart';
import 'package:solutech_sat/ui/screen/open_day_screen.dart';

class RecordsBloc extends Bloc {
  var pickedDates = [
    DateTime.now(),
    DateTime.now(),
  ];
  contactCustomer(int shopId) {
    var shop = routePlansManager.getCustomerById(shopId);
    var contactCustomerDialog = ContactCustomerDialog(context);
    if (shop != null) {
      contactCustomerDialog..phoneNumber = shop.shopPhoneno;
      contactCustomerDialog.show();
    }
  }

  void printSaleOrder(int shopId, Order order, List<OrderItem> orderItems) {
    if (order.synced) {
      navigate(
          screen: EtrPrintingScreen(
        order: order,
        orderItems: orderItems,
      ));
    } else {
      alert("Sale not synced",
          "You will be able to print once the sale is synced.");
    }
  }

  void filterByDate() async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: pickedDates.first,
      initialLastDate: pickedDates.last,
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked.length > 0) {
      pickedDates = picked;
      recordsManager.loadOrders(picked);
      recordsManager.loadSkipRecords(picked);
    }
  }

  showClosedDayDialog() {
    alert("Day already closed",
        "You can't perform this activity after closing the day. Go rest and pick up from tomorrow");
  }

  void chooseCustomer() async {
    if (dayManager.openedDay) {
      navigate(
        screen: CustomersScreen(),
      );
    } else {
      bool opened = await navigate(
        screen: OpenDayScreen(),
      );
      if (opened != null && opened) {
        navigate(
          screen: CustomersScreen(),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }
}
