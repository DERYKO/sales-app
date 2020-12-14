import 'dart:io';

import 'package:flutter/material.dart';
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
import 'package:solutech_sat/utils/format_utils.dart';

class PosmAuditScreen extends StatelessWidget {
  PosmAuditBloc bloc;
  PosmAuditScreen({
    @required Customer customer,
  })  : bloc = PosmAuditBloc(customer: customer),
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
                        title: "POSM AUDIT",
                        module: Roles.POSM_AUDIT,
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
                actions: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: InkResponse(
                        onTap: bloc.savePosmAudit,
                        child: Text(
                          "SAVE",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
            body: Container(
              child: Column(
                children: <Widget>[
                  FilledDropdownButton(
                    padding: EdgeInsets.all(10.0),
                    value: bloc.brand,
                    label: "Brand",
                    hint: "Select brand",
                    onTap: bloc.selectBrand,
                    items: brandsManager.brands.map((brand) {
                      return DropdownMenuItem(
                        child: Text("${brand.brand}"),
                        value: brand,
                      );
                    }).toList(),
                    onChange: (value) {
                      bloc.onBrandChanged(value);
                    },
                  ),
                  Expanded(
                    child: (bloc.brand != null)
                        ? ListView.builder(
                            itemCount: posmManager.posmMaterials.length,
                            itemBuilder: (BuildContext context, int index) {
                              var posmMaterial =
                                  posmManager.posmMaterials[index];
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey[300]),
                                  ),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 30.0,
                                      padding: EdgeInsets.all(5.0),
                                      width: double.infinity,
                                      color: Colors.grey[200],
                                      child: Text(
                                        "${posmMaterial.itemname}",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              _AuditChoice(
                                                groupValue: bloc.getAuditValue(
                                                    posmMaterial.id,
                                                    "availability"),
                                                text: "Available",
                                                value: "Available",
                                                onChange: (value) {
                                                  print("");
                                                  bloc.setAuditValue(
                                                      posmMaterial.id,
                                                      audit: "availability",
                                                      value: value,
                                                      itemtype: posmMaterial
                                                          .itemtype);
                                                },
                                              ),
                                              _AuditChoice(
                                                groupValue: bloc.getAuditValue(
                                                    posmMaterial.id,
                                                    "availability"),
                                                text: "Not Available",
                                                value: "Not Available",
                                                onChange: (value) {
                                                  bloc.setAuditValue(
                                                      posmMaterial.id,
                                                      audit: "availability",
                                                      value: value,
                                                      itemtype: posmMaterial
                                                          .itemtype);
                                                },
                                              ),
                                            ],
                                          ),
                                          (posmMaterial.itemtype == "display")
                                              ? Row(
                                                  children: <Widget>[
                                                    _AuditChoice(
                                                      groupValue:
                                                          bloc.getAuditValue(
                                                              posmMaterial.id,
                                                              "stocked"),
                                                      text: "Stocked",
                                                      value: "Stocked",
                                                      onChange: (value) {
                                                        print(
                                                            "The value is $value");
                                                        bloc.setAuditValue(
                                                            posmMaterial.id,
                                                            audit: "stocked",
                                                            value: value,
                                                            itemtype:
                                                                posmMaterial
                                                                    .itemtype);
                                                      },
                                                    ),
                                                    _AuditChoice(
                                                      groupValue:
                                                          bloc.getAuditValue(
                                                              posmMaterial.id,
                                                              "stocked"),
                                                      text: "Not Stocked",
                                                      value: "Not Stocked",
                                                      onChange: (value) {
                                                        bloc.setAuditValue(
                                                          posmMaterial.id,
                                                          audit: "stocked",
                                                          value: value,
                                                          itemtype: posmMaterial
                                                              .itemtype,
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                )
                                              : Container(),
                                          Row(
                                            children: <Widget>[
                                              _AuditChoice(
                                                groupValue: bloc.getAuditValue(
                                                    posmMaterial.id,
                                                    "visibility"),
                                                text: "Visible",
                                                value: "Visible",
                                                onChange: (value) {
                                                  bloc.setAuditValue(
                                                    posmMaterial.id,
                                                    audit: "visibility",
                                                    value: value,
                                                    itemtype:
                                                        posmMaterial.itemtype,
                                                  );
                                                },
                                              ),
                                              _AuditChoice(
                                                groupValue: bloc.getAuditValue(
                                                    posmMaterial.id,
                                                    "visibility"),
                                                text: "Not Visible",
                                                value: "Not Visible",
                                                onChange: (value) {
                                                  bloc.setAuditValue(
                                                      posmMaterial.id,
                                                      audit: "visibility",
                                                      value: value,
                                                      itemtype: posmMaterial
                                                          .itemtype);
                                                },
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            })
                        : Container(
                            alignment: AlignmentDirectional.center,
                            child: Text("No Brand Selected"),
                          ),
                  )
                ],
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
  RadioListTile v = null;

  _AuditChoice({this.text, this.value, this.groupValue, this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 25.0,
            child: Radio(
              groupValue: groupValue,
              value: value,
              onChanged: (value) {
                onChange(value);
              },
            ),
          ),
          Text("$text")
        ],
      ),
    );
  }
}
