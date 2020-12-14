import 'package:flutter/material.dart';
import 'package:solutech_sat/ui/widgets/bottom_sheet.dart';
import 'package:solutech_sat/ui/widgets/filled_dropdown_button.dart';

Future showNotAvailableModal(context, title) async {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  var reasons = ["Not stocked", "Pending delivery", "Out of stock"];
  var reason;
  TextEditingController _notesCtrl = TextEditingController();

  void onSubmit() {
    if (loginFormKey.currentState.validate() && reason != null) {
      Navigator.pop(context, {
        "reason": reason,
        "notes": _notesCtrl.text,
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
                    key: loginFormKey,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "$title",
                          style: Theme.of(context).textTheme.title,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                          child: Text(
                            "Not available",
                            style: Theme.of(context).textTheme.title,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: FilledDropdownButton(
                        value: reason,
                        label: "Reason",
                        hint: "Reason",
                        items: reasons.map((item) {
                          return DropdownMenuItem(
                            child: Text("$item"),
                            value: item,
                          );
                        }).toList(),
                        onChange: (value) {
                          print("TEXT_CHANGED");
                          reason = value;
                        },
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextFormField(
                      controller: _notesCtrl,
                      autofocus: true,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        onSubmit();
                      },
                      validator: (value) {
                        if (value.isEmpty) return 'Please enter your email';
                        return null;
                      },
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: "Notes",
                        hintText: "Explain more about it",
                      ),
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
