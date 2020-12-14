import 'package:flutter/material.dart';

class ModuleItem extends StatelessWidget {
  String assetImage;
  String title;
  Function onTap;
  ModuleItem({this.assetImage = "", this.title = "", @required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.0,
      width: (MediaQuery.of(context).size.width / 2),
      child: Card(
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  assetImage,
                  height: 35.0,
                ),
                Text("$title"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
