part of 'bloc_provider.dart';

class Bloc {
  BuildContext context;
  StreamController<dynamic> _controller = StreamController<dynamic>.broadcast();
  Stream<dynamic> get stream => _controller.stream;
  ProgressDialog progressDialog;

  void dispose() {}

  void onResume() {}

  void onPause() {}

  void onInactive() {}

  void initState() {
    progressDialog = ProgressDialog(context);
  }

  void notifyChanges([callback]) {
    if (callback != null) {
      callback();
    }
    _controller.sink.add(0);
  }

  Future<dynamic> navigate<T extends Bloc>({@required Widget screen}) async {
    return await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) {
      return screen;
    }));
  }

  showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  pop([results]) {
    if (results == null) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop(results);
    }
  }

  Future<Null> alert(title, body, {onOk = null}) async {
    return showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Container(
              child: Text(body),
            ),
            contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onOk != null) {
                    onOk();
                  }
                },
              ),
            ],
          );
        });
  }

  Future<bool> confirm(title, body) async {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: Text(body),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("CANCEL"),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

  void popAndNavigate<T extends Bloc>({@required Widget screen}) async {
    // Delayed here assists push the navigator to after state build
    // Otherwise an error will occur if a rebuild is underway
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return screen;
    }));
  }
}
