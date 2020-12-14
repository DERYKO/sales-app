import 'dart:io';

import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/audit_osa_bloc.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/dialogs/not_available_modal.dart';
import 'package:solutech_sat/ui/dialogs/quantity_modal.dart';
import 'package:solutech_sat/ui/widgets/screen_stepper.dart';

class AuditOSAScreen extends StatelessWidget {
  AuditOSABloc bloc;
  AuditOSAScreen({
    @required Customer customer,
  })  : bloc = AuditOSABloc(customer: customer),
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
                      title: "ON SHELF AUDIT",
                      module: Roles.AVAILABILITY,
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
                screens: commonsManager
                    .mustHaveProductCategories(
                        bloc.customer.shopSubCatId ?? bloc.customer.shopCatId)
                    .map((category) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            "$category",
                            style: Theme.of(context).textTheme.title,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: commonsManager
                                  .mustHaveProductsByCat(
                                      category,
                                      bloc.customer.shopSubCatId ??
                                          bloc.customer.shopCatId)
                                  .length,
                              itemBuilder: (context, index) {
                                var product = commonsManager
                                    .mustHaveProductsByCat(
                                        category,
                                        bloc.customer.shopSubCatId ??
                                            bloc.customer.shopCatId)
                                    .toList()[index];
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
                                        "${product.productDesc}",
                                        style:
                                            Theme.of(context).textTheme.subhead,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          _AuditChoice(
                                            groupValue: bloc.getAuditValue(
                                                product.productDesc),
                                            value: "Available",
                                            text: (bloc.getAuditQuantity(product
                                                            .productDesc) !=
                                                        null &&
                                                    bloc.getAuditValue(product
                                                            .productDesc) ==
                                                        "Available")
                                                ? "Available (${bloc.getAuditQuantity(product.productDesc)})"
                                                : "Available",
                                            onChange: () async {
                                              var data =
                                                  await showQuantityModal(
                                                context,
                                                product.productDesc,
                                              );
                                              if (data != null) {
                                                bloc.setAuditValue(
                                                    product.productDesc,
                                                    productId:
                                                        product.productId,
                                                    value: "Available",
                                                    notes: "",
                                                    reason: "",
                                                    quantity: int.parse(
                                                        "${data["quantity"] ?? 0}"));
                                              }
                                            },
                                          ),
                                          Container(
                                            width: 20.0,
                                          ),
                                          _AuditChoice(
                                            groupValue: bloc.getAuditValue(
                                                product.productDesc),
                                            value: "Insufficient",
                                            text: (bloc.getAuditQuantity(product
                                                            .productDesc) !=
                                                        null &&
                                                    bloc.getAuditValue(product
                                                            .productDesc) ==
                                                        "Insufficient")
                                                ? "Insufficient (${bloc.getAuditQuantity(product.productDesc)})"
                                                : "Insufficient",
                                            onChange: () async {
                                              var data =
                                                  await showQuantityModal(
                                                context,
                                                product.productDesc,
                                              );
                                              if (data != null) {
                                                bloc.setAuditValue(
                                                    product.productDesc,
                                                    productId:
                                                        product.productId,
                                                    value: "Insufficient",
                                                    notes: "",
                                                    reason: "",
                                                    quantity: int.parse(
                                                        "${data["quantity"] ?? 0}"));
                                              }
                                            },
                                          ),
                                          Container(
                                            width: 20.0,
                                          ),
                                          _AuditChoice(
                                            groupValue: bloc.getAuditValue(
                                                product.productDesc),
                                            value: "Not Available",
                                            text: "Not Available",
                                            onChange: () async {
                                              var data =
                                                  await showNotAvailableModal(
                                                context,
                                                product.productDesc,
                                              );
                                              if (data != null) {
                                                bloc.setAuditValue(
                                                  product.productDesc,
                                                  productId: product.productId,
                                                  value: "Not Available",
                                                  notes: data["notes"],
                                                  reason: data["reason"],
                                                );
                                              }
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
                onSave: bloc.saveAudit,
              ),
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
