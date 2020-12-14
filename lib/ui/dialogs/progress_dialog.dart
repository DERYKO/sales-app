import 'package:flutter/material.dart';

class ProgressDialog {
  bool _isShowing = false;

  BuildContext buildContext;
  String message = "Loading...";

  ProgressDialog(this.buildContext);

  void setMessage(String mess) {
    this.message = mess;
  }

  void show() {
    if (!isShowing()) {
      _showDialog();
      _isShowing = true;
    }
  }

  bool isShowing() {
    return _isShowing;
  }

  void hide() {
    if (isShowing()) {
      _isShowing = false;
      Navigator.pop(buildContext);
    }
  }

  Future _showDialog() {
    showDialog(
      context: buildContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 45.0,
            child: Center(
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10.0),
                  CircularProgressIndicator(),
                  SizedBox(width: 20.0),
                  FittedBox(
                    child: Text(
                      message,
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
    return null;
  }
}
