import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:solutech_sat/bloc/add_stock_bloc.dart';
import 'package:solutech_sat/bloc/banking_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/banking_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/inventory_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/helpers/stockpoints_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/filled_dropdown_button.dart';
import 'package:solutech_sat/ui/widgets/screen_stepper.dart';
import 'package:auto_size_text/auto_size_text.dart';

class BankingScreen extends StatelessWidget {
  final bloc = BankingBloc();
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
                  "Banking",
                ),
              ),
              body: Container(
                color: Colors.white,
                width: double.infinity,
                height: double.infinity,
                child: ListView(
                  children: <Widget>[
                    FilledDropdownButton(
                      padding: EdgeInsets.all(10),
                      isDense: true,
                      value: bloc.bank,
                      label: "Bank",
                      hint: "Select bank",
                      items: bankingManager.banks.map((bank) {
                        return DropdownMenuItem(
                          child: Text("${bank.bankName}"),
                          value: bank,
                        );
                      }).toList(),
                      onChange: bloc.onBankChange,
                    ),
                    FilledDropdownButton(
                      padding:
                          EdgeInsets.all(10).copyWith(top: 0.0, bottom: 0.0),
                      isDense: true,
                      value: bloc.entryType,
                      label: "To bank",
                      hint: "Select mode",
                      items: bloc.entryTypes.map((option) {
                        return DropdownMenuItem(
                          child: Text("$option"),
                          value: option,
                        );
                      }).toList(),
                      onChange: bloc.onOptionChange,
                    ),
                    if (bloc.entryType == "CHEQUE")
                      FilledDropdownButton(
                        padding: EdgeInsets.all(10).copyWith(bottom: 0.0),
                        isDense: true,
                        value: bloc.cheque,
                        onTap: bloc.selectCheque,
                        label: "Cheque",
                        hint: "Select cheque",
                        items: bankingManager.cheques.map((cheque) {
                          return DropdownMenuItem(
                            child: Text("${cheque.paymentRef}"),
                            value: cheque,
                          );
                        }).toList(),
                        onChange: bloc.onChequeChange,
                      ),
                    if (bankingManager.cheques.length == 0)
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          "No cheques",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    if (bloc.entryType == "CHEQUE" &&
                        bloc.cheque?.chequePhoto != "" &&
                        bloc.cheque?.chequePhoto != null)
                      CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            "${settingsManager.updateProfile.imagestorage}cheques/${bloc.cheque.chequePhoto}",
                        errorWidget: (context, url, error) {
                          return Image.asset(
                            "assets/images/noimage.jpg",
                            fit: BoxFit.cover,
                            height: 250.0,
                            width: double.infinity,
                          );
                        },
                        height: 250.0,
                        width: double.infinity,
                      ),
                    Container(
                      margin: EdgeInsets.all(10.0).copyWith(
                        bottom: 0.0,
                      ),
                      child: GestureDetector(
                        onTap: bloc.takePhoto,
                        child: Container(
                          height: (bloc.image != null) ? 200.0 : 50.0,
                          width: double.infinity,
                          color: Colors.grey[100],
                          child: Container(
                            child: (bloc.image != null)
                                ? Image.file(
                                    bloc.image,
                                    fit: BoxFit.cover,
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.camera_alt,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "SLIP PHOTO",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ),
                    if (bloc.bank != null && bloc.entryType != null)
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                        child: Center(
                          child: Text(
                            "${authManager.user.country?.currencyCode} ${bloc.bankingAmount}",
                            style: TextStyle(
                              fontSize: 28.0,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    if (bloc.bank != null && bloc.entryType != null)
                      Padding(
                        padding: const EdgeInsets.all(10.0).copyWith(
                          top: 0.0,
                        ),
                        child: TextFormField(
                          controller: bloc.bankingAmountCtrl,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: "Amount banked",
                            hintText: "Amount banked",
                            filled: true,
                          ),
                        ),
                      ),
                    Container(
                      padding: EdgeInsets.all(10.0).copyWith(
                        top: 0.0,
                        bottom: 5.0,
                      ),
                      child: TextFormField(
                        controller: bloc.notesCtrl,
                        maxLines: 5,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          labelText: "Notes",
                          hintText: "Enter notes",
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0).copyWith(top: 0.0),
                      width: double.infinity,
                      child: MaterialButton(
                        height: 40.0,
                        textColor: Colors.white,
                        color: Theme.of(context).accentColor,
                        onPressed: bloc.saveBanking,
                        child: Text("SAVE"),
                      ),
                    ),
                  ],
                ),
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
