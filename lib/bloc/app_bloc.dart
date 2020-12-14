import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/route_plan.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/shop_category.dart';
import 'package:solutech_sat/data/models/user_location.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/setup_manager.dart';
import 'package:solutech_sat/shared/translations.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/screen/search_screen.dart';
import 'package:solutech_sat/utils/image_utils.dart';
import 'package:solutech_sat/utils/validators.dart';

class AppBloc extends Bloc {
  _onLocaleChanged() async {
    print('Language has been changed to: ${translations.currentLanguage}');
  }

  @override
  void initState() async {
    super.initState();
    if (setupManager.variantCode != null) {
      await config.setVariant(setupManager.variantCode);
    }
    translations.onLocaleChangedCallback = _onLocaleChanged;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
