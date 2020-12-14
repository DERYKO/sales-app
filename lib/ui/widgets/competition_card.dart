import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solutech_sat/data/models/competitor_activity.dart';
import 'package:solutech_sat/helpers/csku_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class CompetitionCard extends StatelessWidget {
  CompetitorActivity competitorActivity;
  final bool simple;

  CompetitionCard({
    this.competitorActivity,
    this.simple = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 2.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10, left: 10.0, right: 10.0),
            width: MediaQuery.of(context).size.width,
            child: Text(
              "${routePlansManager.getCustomerById(competitorActivity.shopId)?.shopName ?? ""}",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10.0),
                  child: Text(
                    "${formatDate(competitorActivity.entryTime, "dt")}",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                Icon(
                  Icons.done_all,
                  color:
                      (competitorActivity.synced) ? Colors.green : Colors.grey,
                  size: 16.0,
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: (competitorActivity.photo != null)
                ? (competitorActivity.fromServer)
                    ? CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            "${settingsManager.updateProfile.imagestorage}competitor/${competitorActivity.photo}",
                        errorWidget: (context, url, error) {
                          return Image.asset(
                            "assets/images/noimage.jpg",
                            fit: BoxFit.cover,
                            height: 250.0,
                          );
                        },
                        height: 250.0,
                        width: 70.0,
                      )
                    : Image.file(
                        File("${competitorActivity.photo}"),
                        height: 250.0,
                        width: 70.0,
                        fit: BoxFit.cover,
                      )
                : Image.asset(
                    "assets/images/noimage.jpg",
                    height: 250.0,
                    width: 250.0,
                  ),
          ),
          DetailItem(
            title: "Competitor",
            value: "${competitorActivity.competitor}",
          ),
          DetailItem(
            title: "Product",
            value: "${competitorActivity.productName}",
          ),
          DetailItem(
            title: "Sku",
            value: "${competitorActivity.productSku}",
          ),
          DetailItem(
            title: "CSKU",
            value:
                "${cskusManager.getSkuById(competitorActivity.csku)?.cskuName ?? ""}",
          ),
          DetailItem(
            title: "Mechanism",
            value: "${competitorActivity.mechanism}",
          ),
          DetailItem(
            title: "Before",
            value: "${competitorActivity.beforeValue}",
          ),
          DetailItem(
            title: "After",
            value: "${competitorActivity.afterValue}",
          ),
          DetailItem(
            title: "Depth",
            value:
                "${competitorActivity.mechanism == "Price Reduction" ? "${(((double.parse("${competitorActivity.beforeValue ?? 0}") - double.parse("${competitorActivity.afterValue ?? 0}")) / double.parse("${competitorActivity.beforeValue ?? 0}")) * 100).toStringAsFixed(0)}%" : "${(((double.parse("${competitorActivity.afterValue ?? 0}") - double.parse("${competitorActivity.beforeValue ?? 0}")) / double.parse("${competitorActivity.beforeValue ?? 0}")) * 100).toStringAsFixed(0)}%"}",
          ),
          DetailItem(
            title: "Notes",
            value: "${competitorActivity.notes ?? ""}",
          ),
          Divider()
        ],
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  String title;
  String value;

  DetailItem({this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "$title: ",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text("$value")
        ],
      ),
    );
  }
}
