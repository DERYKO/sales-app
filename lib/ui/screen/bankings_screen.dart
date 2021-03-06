import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:solutech_sat/bloc/add_stock_bloc.dart';
import 'package:solutech_sat/bloc/banking_bloc.dart';
import 'package:solutech_sat/bloc/bankings_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/banking_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/helpers/stockpoints_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/filled_dropdown_button.dart';
import 'package:solutech_sat/ui/widgets/screen_stepper.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class BankingsScreen extends StatelessWidget {
  final bloc = BankingsBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Bankings",
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: config.contrastColor,
                    ),
                    onPressed: bloc.refresh,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.date_range,
                      color: config.contrastColor,
                    ),
                    onPressed: bloc.filterByDate,
                  ),
                ],
              ),
              body: Container(
                color: Colors.white,
                width: double.infinity,
                height: double.infinity,
                child: StreamBuilder(
                    stream: bankingManager.stream,
                    builder: (context, snapshot) {
                      return CircularMaterialSpinner(
                        loading: bankingManager.loadingBankings,
                        child: ListView.builder(
                          itemCount: bankingManager.bankings.length,
                          itemBuilder: (context, index) {
                            var banking = bankingManager.bankings[index];
                            return Container(
                                color: (index + 1) % 2 == 0
                                    ? Colors.white
                                    : Colors.grey[100],
                                padding: EdgeInsets.all(
                                  10.0,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: (double.parse(
                                                      "${banking.customerId ?? 0}") >
                                                  0)
                                              ? Text(
                                                  "${routePlansManager.getCustomerById(int.parse("${banking.customerId}")).shopName}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.0,
                                                  ),
                                                )
                                              : Container(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10.0,
                                          ),
                                          child: Icon(
                                            Icons.done_all,
                                            color: (banking.synced)
                                                ? Colors.green
                                                : Colors.grey,
                                            size: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            "${banking.bankName}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black54,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 10.0,
                                          ),
                                          child: Text(
                                            "${formatCurrency(banking.amount)}",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (banking.slipPhoto != "" &&
                                        banking.slipPhoto != null)
                                      (banking.fromServer)
                                          ? CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  "${settingsManager.updateProfile.imagestorage}bankingslips/${banking.slipPhoto}",
                                              errorWidget:
                                                  (context, url, error) {
                                                return Image.asset(
                                                  "assets/images/noimage.jpg",
                                                  fit: BoxFit.cover,
                                                  height: 250.0,
                                                  width: double.infinity,
                                                );
                                              },
                                              height: 250.0,
                                              width: double.infinity,
                                            )
                                          : Image.file(
                                              File(
                                                "${banking.slipPhoto}",
                                              ),
                                              height: 250.0,
                                              width: double.infinity,
                                              fit: BoxFit.cover),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(2.0),
                                          child: Text(
                                            "${banking.entryType}",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(2.0)),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 10.0,
                                          ),
                                          child: Text(
                                            "${formatDate(banking.entryTime, "dt")}",
                                            style: TextStyle(
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ));
                          },
                        ),
                      );
                    }),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: bloc.addBanking,
                child: Icon(Icons.add),
              ),
            );
          }),
    );
  }
}

class RadioItem<T> extends StatelessWidget {
  Widget title;
  T value;
  T groupValue;
  Color activeColor;
  ValueChanged<T> onChanged;
  MaterialTapTargetSize materialTapTargetSize;
  RadioItem({
    this.title,
    @required this.value,
    @required this.groupValue,
    @required this.onChanged,
    this.activeColor,
    this.materialTapTargetSize,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Row(
        children: <Widget>[
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: activeColor,
            materialTapTargetSize: materialTapTargetSize,
          ),
          title,
        ],
      ),
    );
  }
}
