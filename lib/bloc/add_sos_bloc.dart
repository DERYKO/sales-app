import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart' hide Feedback;

import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/screen/audit_sos_screen.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class AddSosBloc extends Bloc {
  Customer customer;
  String category;
  AddSosBloc({this.customer});

  void auditSos(String category) {
    navigate(
      screen: AuditSosScreen(
        customer: customer,
        brandCategory: category,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
