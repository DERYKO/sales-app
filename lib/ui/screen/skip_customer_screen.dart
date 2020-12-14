import 'dart:io';

import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/records_bloc.dart';
import 'package:solutech_sat/bloc/skip_customer_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/records_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/stockpoints_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/filled_dropdown_button.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class SkipCustomerScreen extends StatelessWidget {
  SkipCustomerBloc bloc;
  SkipCustomerScreen({Customer customer}) : bloc = SkipCustomerBloc(customer);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FittedBox(
                      child: Text(
                        "SKIP CUSTOMER",
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        "${bloc.customer.shopName}",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: config.contrastColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: StreamBuilder(
              stream: bloc.stream,
              builder: (context, snapshot) {
                return Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            "${bloc.customer.shopName.toUpperCase()}",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              StreamBuilder(
                                stream: commonsManager.stream,
                                builder: (context, snapshot) {
                                  return Container(
                                    padding: EdgeInsets.all(10.0)
                                        .copyWith(bottom: 0.0),
                                    child: FilledDropdownButton(
                                      isDense: true,
                                      value: bloc.skipReason,
                                      label: "Skip reason",
                                      hint: "Select skip reason",
                                      items: commonsManager.skipReasons
                                          .map((reason) {
                                        return DropdownMenuItem(
                                          child: Text("${reason.data}"),
                                          value: reason,
                                        );
                                      }).toList(),
                                      onChange: (value) {
                                        bloc.onSkipReasonChanged(value);
                                      },
                                    ),
                                  );
                                },
                              ),
                              Container(
                                padding: EdgeInsets.all(10.0)
                                    .copyWith(bottom: 0.0, top: 5.0),
                                child: Stack(
                                  children: <Widget>[
                                    TextFormField(
                                      controller: bloc.nextVisitDateCtrl,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        filled: true,
                                        labelText: "Next visit date",
                                        hintText: "Select next visit date",
                                        suffixIcon: Icon(
                                          Icons.date_range,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: bloc.pickDate,
                                      child: Container(
                                        color: Colors.transparent,
                                        height: 50.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10.0)
                                    .copyWith(bottom: 0.0, top: 5.0),
                                child: TextFormField(
                                  controller: bloc.notesCtrl,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    labelText: "More info",
                                    hintText:
                                        "Tell us more about why you are skipping",
                                  ),
                                  minLines: 5,
                                  maxLines: 6,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10.0)
                                    .copyWith(bottom: 0.0, top: 5.0),
                                height: 55.0,
                                child: MaterialButton(
                                  onPressed: bloc.onSave,
                                  color: Theme.of(context).accentColor,
                                  child: Text(
                                    "SAVE",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Footer(),
                      ],
                    ));
              },
            ),
          );
        },
      ),
    );
  }
}
