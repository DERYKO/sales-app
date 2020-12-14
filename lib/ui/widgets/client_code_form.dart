import 'package:flutter/material.dart';
import 'package:solutech_sat/config.dart';

import 'circular_material_spinner.dart';

class ClientCodeForm extends StatelessWidget {
  TextEditingController clientCodeCtrl = TextEditingController();
  Function onFinish;
  ClientCodeForm({
    this.onFinish,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.all(28.0),
          child: Text(
            "Enter the client code provided by Solutech Limited during setup.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
              color: Color(0xFF747678),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          color: Colors.grey[200],
          padding: EdgeInsets.all(6.0).copyWith(left: 20.0),
          margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
          child: TextFormField(
            controller: clientCodeCtrl,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              hintText: "Client code",
              border: InputBorder.none,
            ),
            onFieldSubmitted: (String value) {
              if (value.trim() != "") {
                onFinish(value);
              }
            },
          ),
        ),
        Align(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(right: 30.0, top: 15.0, left: 30.0),
            child: MaterialButton(
              onPressed: () {
                onFinish(clientCodeCtrl.text);
              },
              child: CircularMaterialSpinner(
                loading: false,
                color: Colors.grey,
                width: 25.0,
                height: 25.0,
                strokeWidth: 4.0,
                child: Text(
                  "FINISH",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: config.contrastColor,
                  ),
                ),
              ),
              color: Theme.of(context).primaryColor,
              height: 50.0,
            ),
          ),
        ),
      ]),
    );
  }
}
