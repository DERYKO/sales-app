import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:solutech_sat/data/models/product_update.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/preference_manager.dart';
import 'package:solutech_sat/helpers/route_plans_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/helpers/setup_manager.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class ProductUpdateCard extends StatelessWidget {
  final String type;
  final ProductUpdate productUpdate;

  ProductUpdateCard({
    this.type,
    this.productUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 2.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            margin: EdgeInsets.only(top: 15.0),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    "${routePlansManager.getCustomerById(productUpdate.shopId)?.shopName}",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 5.0),
                  width: 80.0,
                  child: Text(
                    "${formatDate(productUpdate.entryTime, "jm")}",
                    textAlign: TextAlign.end,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5.0),
                  child: Icon(
                    Icons.done_all,
                    size: 16.0,
                    color: (productUpdate.synced) ? Colors.green : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: (productUpdate.photo != null)
                ? (productUpdate.fromServer)
                    ? CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            "${settingsManager.updateProfile.imagestorage}productsupdate/${productUpdate.photo}",
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
                        File("${productUpdate.photo}"),
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
          _DetailItem(
            title: "Product",
            value:
                "${commonsManager.productById(productUpdate.productId)?.productDesc}",
          ),
          _DetailItem(
            title: "Quantity",
            value: "${productUpdate.quantity}",
          ),
          _DetailItem(
            title: "Entry time",
            value:
                "${productUpdate.entryTime != null ? "${formatDate(productUpdate.entryTime, 'dt')}" : ""}",
          ),
          Container(
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 5.0,
            ),
            child: Text("${productUpdate.notes ?? ""}"),
          ),
          Divider()
        ],
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  String title;
  String value;

  _DetailItem({
    this.title,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 5.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "$title: ",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          Text("$value")
        ],
      ),
    );
  }
}
