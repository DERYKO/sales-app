import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solutech_sat/bloc/add_edit_customer_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/route_plan.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/shop_category.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/filled_dropdown_button.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';

class AddEditCustomerScreen extends StatelessWidget {
  AddEditCustomerBloc bloc;

  AddEditCustomerScreen({
    Customer customer,
    String mode,
    RoutePlan routePlan,
  }) : bloc = AddEditCustomerBloc(
          customer: customer,
          mode: mode,
          routePlan: routePlan,
        );
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "${(bloc.mode == "add") ? "Add customer" : "Edit ${bloc.customer?.shopName ?? ""}"}",
                ),
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
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: bloc.takePhoto,
                                    child: Container(
                                      height: 100.0,
                                      width: 100.0,
                                      margin: EdgeInsets.only(right: 5.0),
                                      color: Colors.grey[100],
                                      child: (bloc.mode == "add")
                                          ? Container(
                                              height: 97.0,
                                              width: 97.0,
                                              margin: EdgeInsets.only(
                                                right: 5.0,
                                              ),
                                              color: Colors.grey[100],
                                              child: (bloc.image != null)
                                                  ? Image.file(
                                                      bloc.image,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Icon(
                                                      Icons.camera_alt,
                                                      size: 30.0,
                                                    ),
                                            )
                                          : Container(
                                              child: bloc.image != null
                                                  ? Image.file(
                                                      bloc.image,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : (bloc.customer?.photo !=
                                                          null)
                                                      ? (bloc.customer
                                                              .fromServer)
                                                          ? CachedNetworkImage(
                                                              fit: BoxFit.cover,
                                                              imageUrl:
                                                                  "${settingsManager.updateProfile.imagestorage}customers/${bloc.customer.photo}",
                                                              errorWidget:
                                                                  (context, url,
                                                                      error) {
                                                                return Image
                                                                    .asset(
                                                                  "assets/images/noimage.jpg",
                                                                  fit: BoxFit
                                                                      .cover,
                                                                );
                                                              },
                                                            )
                                                          : Image.file(
                                                              File(
                                                                  "${bloc.customer.photo}"),
                                                              height: 70.0,
                                                              width: 70.0,
                                                              fit: BoxFit.cover,
                                                            )
                                                      : Icon(
                                                          Icons.camera_alt,
                                                        ),
                                            ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                          controller: bloc.customerNameCtrl,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            filled: true,
                                            labelText: "Customer name",
                                            hintText: "Enter customer name",
                                          ),
                                        ),
                                        Divider(
                                          height: 5.0,
                                          color: Colors.transparent,
                                        ),
                                        TextFormField(
                                          controller: bloc.kraPinCtrl,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            filled: true,
                                            labelText: "KRA PIN",
                                            hintText: "Enter KRA PIN",
                                          ),
                                        ),
                                        Divider(
                                          height: 5.0,
                                          color: Colors.transparent,
                                        ),
                                        TextFormField(
                                          controller: bloc.addressCtrl,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            filled: true,
                                            labelText: "Address",
                                            hintText: "Enter address",
                                          ),
                                        ),
                                        Divider(
                                          height: 5.0,
                                          color: Colors.transparent,
                                        ),
                                        StreamBuilder(
                                          stream: locationManager.stream,
                                          builder: (context, snapshot) {
                                            return FilledDropdownButton(
                                              isDense: true,
                                              value: bloc.location,
                                              label: "Location",
                                              hint: "Select location",
                                              onTap: bloc.selectUserLocation,
                                              padding:
                                                  EdgeInsets.only(bottom: 5.0),
                                              items: locationManager
                                                  .userLocations
                                                  .map((location) {
                                                return DropdownMenuItem(
                                                  child: Text(
                                                      "${location.locationName}"),
                                                  value: location,
                                                );
                                              }).toList(),
                                              onChange: (value) {
                                                bloc.onLocationChanged(value);
                                              },
                                            );
                                          },
                                        ),
                                      ],
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
                              child: StreamBuilder(
                                stream: commonsManager.stream,
                                builder: (context, snapshot) {
                                  return FilledDropdownButton(
                                    isDense: true,
                                    value: bloc.customerCategory,
                                    label: "Category",
                                    hint: "Customer category",
                                    items: commonsManager.shopCategories
                                        .map((ShopCategory category) {
                                      return DropdownMenuItem(
                                        child: Text("${category.shopCatName}"),
                                        value: category,
                                      );
                                    }).toList(),
                                    onChange: (value) {
                                      bloc.onShopCategoryChanged(value);
                                    },
                                  );
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10.0).copyWith(
                                top: 0.0,
                                bottom: 5.0,
                              ),
                              child: TextFormField(
                                controller: bloc.phoneNumberCtrl,
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: false,
                                  signed: false,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  labelText: "Phone",
                                  hintText: "Enter phone number",
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10.0).copyWith(
                                top: 0.0,
                                bottom: 5.0,
                              ),
                              child: TextFormField(
                                controller: bloc.contactPersonCtrl,
                                decoration: InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  labelText: "Contact person",
                                  hintText: "Enter contact",
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
                                onPressed: bloc.saveCustomer,
                                child: Text(
                                    "${bloc.mode == "add" ? "SAVE" : "UPDATE"} CUSTOMER"),
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
