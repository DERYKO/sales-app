import 'dart:io';

import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/brand_audit_bloc.dart';
import 'package:solutech_sat/bloc/posm_audit_bloc.dart';
import 'package:solutech_sat/bloc/records_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/helpers/brands_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/posm_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/filled_dropdown_button.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/ui/widgets/screen_stepper.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class BrandAuditScreen extends StatelessWidget {
  BrandAuditBloc bloc;
  BrandAuditScreen({
    @required Customer customer,
  })  : bloc = BrandAuditBloc(customer: customer),
        assert(customer != null);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FittedBox(
                    child: Text("${roleManager.resolveTitle(
                      title: "BRAND AUDIT",
                      module: Roles.BRAND_AVAILABILITY,
                      capitalize: true,
                    )}"),
                  ),
                  Text(
                    "${bloc.customer.shopName.toUpperCase()}",
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              child: ScreenStepper(
                  screens: brandsManager.brandCategories.map((brandCategories) {
                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              "${brandCategories["category"]}",
                              style: Theme.of(context).textTheme.title,
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: brandCategories["brands"].length,
                                itemBuilder: (context, index) {
                                  var brand = brandCategories["brands"][index];
                                  return Container(
                                    color: ((index + 1) % 2 == 0)
                                        ? Colors.grey[200]
                                        : Colors.white,
                                    padding: EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 10.0,
                                        left: 10.0,
                                        right: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "${brand.brand}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            _AuditChoice(
                                              groupValue: bloc
                                                  .getAuditValue(brand.brand),
                                              value: "Available",
                                              text: "Available",
                                              onChange: () async {
                                                bloc.setAuditValue(brand.brand,
                                                    value: "Available");
                                              },
                                            ),
                                            Container(
                                              width: 20.0,
                                            ),
                                            _AuditChoice(
                                              groupValue: bloc
                                                  .getAuditValue(brand.brand),
                                              value: "Not Available",
                                              text: "Not Available",
                                              onChange: () async {
                                                bloc.setAuditValue(
                                                  brand.brand,
                                                  value: "Not Available",
                                                );
                                              },
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                  currentScreen: bloc.currentScreen,
                  onNext: bloc.nextScreen,
                  onPrev: bloc.prevScreen,
                  onSave: bloc.saveAudit),
            ),
          );
        },
      ),
    );
  }
}

class _AuditChoice extends StatelessWidget {
  String text;
  var groupValue;
  var value;
  var onChange;

  _AuditChoice({this.text, this.value, this.groupValue, this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            width: 25.0,
            child: Radio(
              groupValue: groupValue,
              value: value,
              onChanged: (value) {
                onChange();
              },
            ),
          ),
          GestureDetector(
            onTap: onChange,
            child: Text("$text"),
          ),
        ],
      ),
    );
  }
}
