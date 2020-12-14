import 'package:flutter/material.dart';
import 'package:solutech_sat/config.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'circular_material_spinner.dart';

class StickyHeaderGroup extends StatelessWidget {
  dynamic title;
  List<Widget> children;
  StickyHeaderGroup({@required this.title, this.children = const []});
  @override
  Widget build(BuildContext context) {
    return StickyHeader(
      header: Container(
        height: 30.0,
        padding: EdgeInsets.only(top: 7.0, left: 15.0),
        child: (title is String)
            ? Text(
                "$title",
                style: TextStyle(color: Color(0xFF858687)),
              )
            : title,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE0DEDE))),
          color: Color(0xFFF1F1F1),
        ),
      ),
      content: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      )),
    );
  }
}
