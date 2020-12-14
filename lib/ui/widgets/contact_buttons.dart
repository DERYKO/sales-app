import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactButtons extends StatelessWidget {
  String phoneNumber;
  Function onEditTap;
  ContactButtons({this.phoneNumber, this.onEditTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(2.0),
            margin: EdgeInsets.all(1.0),
            child: GestureDetector(
              child: Icon(
                Icons.call,
                color: Colors.white,
              ),
              onTap: phoneNumber != null
                  ? () {
                      launch("tel:${phoneNumber}");
                    }
                  : null,
            ),
            color: phoneNumber != null ? Colors.green : Colors.grey[300],
          ),
          Container(
            padding: EdgeInsets.all(2.0),
            margin: EdgeInsets.all(1.0),
            child: GestureDetector(
              child: Icon(
                Icons.message,
                color: Colors.white,
              ),
              onTap: phoneNumber != null
                  ? () {
                      launch("sms:${phoneNumber}");
                    }
                  : null,
            ),
            color: phoneNumber != null ? Colors.orange : Colors.grey[300],
          ),
          if (onEditTap != null)
            Container(
              padding: EdgeInsets.all(2.0),
              margin: EdgeInsets.all(1.0),
              child: GestureDetector(
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onTap: onEditTap,
              ),
              color: Colors.black87,
            ),
        ],
      ),
    );
  }
}
