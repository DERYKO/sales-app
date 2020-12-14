import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solutech_sat/ui/widgets/bottom_sheet.dart';
import 'package:solutech_sat/ui/widgets/filled_dropdown_button.dart';

Future showQuantityModal(context, title) async {
  final GlobalKey<FormState> quantityFormKey = GlobalKey<FormState>();
  TextEditingController _quantityCtrl = TextEditingController();

  void onSubmit() {
    if (quantityFormKey.currentState.validate() && _quantityCtrl.text != "") {
      Navigator.pop(context, {
        "quantity": _quantityCtrl.text,
      });
    }
  }

  return await showModalBottomSheetApp(
      context: context,
      builder: (BuildContext bc) {
        return WillPopScope(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  Form(
                    key: quantityFormKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "$title",
                            style: Theme.of(context).textTheme.title,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextFormField(
                            controller: _quantityCtrl,
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).requestFocus(FocusNode());
                              onSubmit();
                            },
                            validator: (value) {
                              if (value.isEmpty) return 'Please enter quantity';
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Quantity",
                              hintText: "Quantity in pcs",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: MaterialButton(
                      onPressed: onSubmit,
                      child: Text(
                        "CONTINUE",
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                      color: Theme.of(context).accentColor,
                      height: 50.0,
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                  ),
                ],
              ),
            ),
            onWillPop: () {
              return Future.value(true);
            });
      });
}
