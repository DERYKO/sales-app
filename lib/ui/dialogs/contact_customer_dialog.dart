import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCustomerDialog {
  BuildContext context;
  String phoneNumber = "";

  ContactCustomerDialog(this.context);

  void hide() {
    Navigator.of(context).pop(context);
  }

  void show() {
    _showDialog();
  }

  void _callCustomer() {
    if (phoneNumber != null) {
      launch("tel:$phoneNumber");
      hide();
    }
  }

  void _messageCustomer() {
    if (phoneNumber != null) {
      launch("sms:$phoneNumber");
      hide();
    }
  }

  Future _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 150.0,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "CONTACT CUSTOMER",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: _callCustomer,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          child: Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.green,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text("CALL"),
                        ),
                      ],
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: _messageCustomer,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          child: Icon(
                            Icons.message,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.blueGrey,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text("MESSAGE"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    return null;
  }
}
