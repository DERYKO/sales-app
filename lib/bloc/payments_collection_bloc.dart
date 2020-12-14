import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart' hide Feedback;
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/brand.dart';
import 'package:solutech_sat/data/models/csku.dart';
import 'package:solutech_sat/data/models/feedback.dart';
import 'package:solutech_sat/data/models/product.dart';
import 'package:solutech_sat/data/models/product_update.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/user_location.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/brands_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/competitor_activities_manager.dart';
import 'package:solutech_sat/helpers/csku_manager.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/payments_manager.dart';
import 'package:solutech_sat/helpers/product_updates_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solutech_sat/ui/screen/add_edit_customer_screen.dart';
import 'package:solutech_sat/ui/screen/collect_payment_screen.dart';
import 'package:solutech_sat/ui/screen/open_day_screen.dart';
import 'package:solutech_sat/ui/screen/search_screen.dart';
import 'package:solutech_sat/utils/image_utils.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

import '../data/models/competitor_activity.dart';
import '../helpers/session_manager.dart';

class PaymentsCollectionBloc extends Bloc {
  void collectPayment(Customer customer) async {
    if (dayManager.openedDay) {
      if (paymentsManager.getCustomerBalancesFor(customer.id).fold<double>(
              0.0,
              (a, b) =>
                  a +
                  (double.parse("${b.amount ?? 0}") -
                      double.parse("${b.amountpaid ?? 0}"))) >
          0) {
        navigate(
            screen: CollectPaymentScreen(
          customer: customer,
        ));
      } else {
        alert(
          "No balances",
          "This customer does not have any balance for collection.",
        );
      }
    } else {
      bool opened = await navigate(
        screen: OpenDayScreen(),
      );
      if (opened != null && opened) {
        if (paymentsManager.getCustomerBalancesFor(customer.id).fold<double>(
                0.0,
                (a, b) =>
                    a +
                    (double.parse("${b.amount ?? 0}") -
                        double.parse("${b.amountpaid ?? 0}"))) >
            0) {
          navigate(
              screen: CollectPaymentScreen(
            customer: customer,
          ));
        } else {
          alert(
            "No balances",
            "This customer does not have any balance for collection.",
          );
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }
}
