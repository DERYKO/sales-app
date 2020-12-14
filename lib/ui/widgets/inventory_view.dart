import 'package:flutter/material.dart';

class InventoryView extends StatelessWidget {
  InventoryView({
    @required this.productCategory,
    @required this.productCount,
    @required this.child,
    this.color,
  });
  final String productCategory;
  final String productCount;
  final Color color;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: ExpansionTile(
        title: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "$productCategory",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
              ),
              Text(
                " ($productCount)",
                style: TextStyle(
                  fontSize: 12.0,
                ),
              )
            ],
          ),
        ),
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: child,
          )
        ],
      ),
    );
  }
}
