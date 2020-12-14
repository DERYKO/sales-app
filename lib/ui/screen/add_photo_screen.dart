import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solutech_sat/bloc/add_competition_bloc.dart';
import 'package:solutech_sat/bloc/add_photo_bloc.dart';
import 'package:solutech_sat/bloc/add_product_uptate_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/helpers/brands_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/csku_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/filled_dropdown_button.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';

class AddPhotoScreen extends StatelessWidget {
  AddPhotoBloc bloc;
  AddPhotoScreen({Customer customer}) : bloc = AddPhotoBloc(customer: customer);

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
                        title: "ADD PHOTO",
                        module: Roles.IMAGES,
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
                                stream: commonsManager.stream,
                                builder: (context, snapshot) {
                                  return FilledDropdownButton(
                                    isDense: true,
                                    value: bloc.productCategory,
                                    label: "Product category",
                                    hint: "Select product category",
                                    onTap: bloc.selectProductCategory,
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    items: commonsManager.productCategories
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
                              padding: EdgeInsets.all(10.0).copyWith(
                                bottom: 0.0,
                                top: 0.0,
                              ),
                              child: StreamBuilder(
                                stream: commonsManager.stream,
                                builder: (context, snapshot) {
                                  return FilledDropdownButton(
                                    isDense: true,
                                    value: bloc.category,
                                    label: "Photo category",
                                    hint: "Select photo category",
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    items: commonsManager.photoCategories
                                        .map((category) {
                                      return DropdownMenuItem(
                                        child: Text("${category.data}"),
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
                                value: bloc.activity,
                                label: "Activity",
                                hint: "Select activity",
                                items: commonsManager.appData
                                    .where((appData) =>
                                        appData.category == "Activity")
                                    .map((activity) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      "${activity.data}",
                                    ),
                                    value: activity,
                                  );
                                }).toList(),
                                onChange: (value) {
                                  bloc.onActivityChanged(value);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0),
                              child: GestureDetector(
                                onTap: bloc.takePhoto,
                                child: Container(
                                  height: (bloc.image != null) ? 200.0 : 50.0,
                                  width: double.infinity,
                                  margin:
                                      EdgeInsets.only(left: 5.0, right: 5.0),
                                  color: Colors.grey[100],
                                  child: Container(
                                    child: (bloc.image != null)
                                        ? Image.file(
                                            bloc.image,
                                            fit: BoxFit.cover,
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.camera_alt,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "PHOTO",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
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
                                onPressed: bloc.saveDamage,
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
