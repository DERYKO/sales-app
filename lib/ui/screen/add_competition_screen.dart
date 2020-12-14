import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solutech_sat/bloc/add_competition_bloc.dart';
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

class AddCompetitionScreen extends StatelessWidget {
  AddCompetitionBloc bloc;
  AddCompetitionScreen({Customer customer})
      : bloc = AddCompetitionBloc(customer: customer);

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
                        title: "COMPETITION",
                        module: Roles.COMPETITOR,
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
                              padding: EdgeInsets.all(10.0)
                                  .copyWith(top: 5.0, bottom: 0.0),
                              child: FilledDropdownButton(
                                isDense: true,
                                value: bloc.csku,
                                label: "CSKU",
                                onTap: bloc.selectCsku,
                                hint: "Select csku",
                                items: cskusManager
                                    .getCskusByCategory(bloc.category)
                                    .map((csku) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      "${csku.cskuName}",
                                    ),
                                    value: csku,
                                  );
                                }).toList(),
                                onChange: (value) {
                                  bloc.onBrandChanged(value);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0)
                                  .copyWith(top: 0.0, bottom: 0.0),
                              child: FilledDropdownButton(
                                isDense: true,
                                value: bloc.mechanism,
                                label: "Mechanism",
                                hint: "Select mechanism",
                                items: commonsManager.appData
                                    .where((appData) =>
                                        appData.category == "Mechanism")
                                    .map((mechanism) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      "${mechanism.data}",
                                    ),
                                    value: mechanism,
                                  );
                                }).toList(),
                                onChange: (value) {
                                  bloc.onMechanismChanged(value);
                                },
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(10.0).copyWith(
                                      top: 5.0,
                                      bottom: 5.0,
                                    ),
                                    child: TextFormField(
                                      controller: bloc.beforeCtrl,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        WhitelistingTextInputFormatter
                                            .digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        isDense: true,
                                        filled: true,
                                        labelText: "Before",
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(0.0).copyWith(
                                      top: 5.0,
                                      bottom: 5.0,
                                      right: 10.0,
                                    ),
                                    child: TextFormField(
                                      controller: bloc.afterCtrl,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        WhitelistingTextInputFormatter
                                            .digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        isDense: true,
                                        filled: true,
                                        labelText: "After",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.0)
                                  .copyWith(top: 0.0, bottom: 5.0, left: 5),
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
