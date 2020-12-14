import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solutech_sat/bloc/add_competition_bloc.dart';
import 'package:solutech_sat/bloc/add_product_uptate_bloc.dart';
import 'package:solutech_sat/bloc/add_sod_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/helpers/brands_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/csku_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/filled_dropdown_button.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';

class AddSodScreen extends StatelessWidget {
  AddSodBloc bloc;
  AddSodScreen({Customer customer}) : bloc = AddSodBloc(customer: customer);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FittedBox(
                      child: Text("${roleManager.resolveTitle(
                        title: "ADD SHARE OF DISPLAY",
                        module: Roles.SHARE_OF_DISPLAY,
                        capitalize: true,
                      )}"),
                    ),
                    Text(
                      "${bloc.customer.shopName.toUpperCase()}",
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                bottom: (bloc.customer != null)
                    ? PreferredSize(
                        child: Container(
                          height: 40.0,
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              left: 72.0, bottom: 10.0, right: 17.0),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "${bloc.customer.shopName}",
                            style:
                                TextStyle(fontSize: 17.0, color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white.withAlpha(30),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0))),
                        ),
                        preferredSize: Size(double.infinity, 50),
                      )
                    : null,
              ),
              body: Container(
                color: Colors.white,
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  EdgeInsets.all(10.0).copyWith(bottom: 0.0),
                              child: StreamBuilder(
                                stream: brandsManager.stream,
                                builder: (context, snapshot) {
                                  return FilledDropdownButton(
                                    isDense: true,
                                    value: bloc.category,
                                    label: "Category",
                                    hint: "Select category",
                                    onTap: bloc.selectBrandCategory,
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    items: brandsManager.categories
                                        .map((category) {
                                      return DropdownMenuItem(
                                        child: Text("$category"),
                                        value: category,
                                      );
                                    }).toList(),
                                    onChange: (value) {
                                      bloc.onCategoryChanged(value);
                                    },
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0)
                                  .copyWith(top: 0.0, bottom: 0.0),
                              child: FilledDropdownButton(
                                isDense: true,
                                value: bloc.brand,
                                label: "Brand",
                                onTap: bloc.selectBrand,
                                hint: "Select brand",
                                items: brandsManager.brands
                                    .where((brand) =>
                                        brand.category == bloc.category)
                                    .map((brand) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      "${brand?.brand}",
                                    ),
                                    value: brand,
                                  );
                                }).toList(),
                                onChange: (value) {
                                  bloc.onBrandChanged(value);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0).copyWith(
                                top: 5.0,
                                bottom: 5.0,
                              ),
                              child: FilledDropdownButton(
                                isDense: true,
                                value: bloc.displayType,
                                label: "Display type",
                                onTap: bloc.selectDisplayType,
                                hint: "Select display type",
                                items: commonsManager.displayTypes
                                    .map((displayType) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      "${displayType?.data}",
                                    ),
                                    value: displayType,
                                  );
                                }).toList(),
                                onChange: (value) {
                                  bloc.onDisplayTypeChanged(value);
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10.0).copyWith(top: 5.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      controller: bloc.quantityCtrl,
                                      inputFormatters: [
                                        WhitelistingTextInputFormatter
                                            .digitsOnly
                                      ],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        filled: true,
                                        labelText: "Quantity",
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0)
                                  .copyWith(top: 0.0, bottom: 5.0, left: 5),
                              child: Wrap(
                                children: <Widget>[
                                  ...bloc.imageUrls.map<Widget>((imageUrl) {
                                    return Container(
                                      height: 120.0,
                                      padding: EdgeInsets.only(top: 5.0),
                                      width:
                                          (MediaQuery.of(context).size.width /
                                                  2) -
                                              20,
                                      margin: EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      color: Colors.grey[100],
                                      child: Container(
                                          child: Image.file(
                                        File("$imageUrl"),
                                        height: 250.0,
                                        width: 70.0,
                                        fit: BoxFit.cover,
                                      )),
                                    );
                                  }).toList(),
                                  GestureDetector(
                                    onTap: bloc.takePhoto,
                                    child: Container(
                                      height: 120.0,
                                      width:
                                          (MediaQuery.of(context).size.width /
                                                  2) -
                                              20,
                                      margin: EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      color: Colors.grey[100],
                                      child: Container(
                                        child: Icon(
                                          Icons.camera_alt,
                                          size: 30.0,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10.0).copyWith(
                                top: 0.0,
                                bottom: 5.0,
                              ),
                              child: TextFormField(
                                controller: bloc.notesCtrl,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  labelText: "Notes",
                                  hintText: "Enter notes",
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10.0).copyWith(
                                top: 0.0,
                                bottom: 5.0,
                              ),
                              child: MaterialButton(
                                minWidth: double.infinity,
                                height: 50.0,
                                textColor: Colors.white,
                                color: Theme.of(context).accentColor,
                                onPressed: bloc.saveSod,
                                child: Text("SAVE"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Footer(),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
