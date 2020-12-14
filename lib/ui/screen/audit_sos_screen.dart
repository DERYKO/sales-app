import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solutech_sat/bloc/add_competition_bloc.dart';
import 'package:solutech_sat/bloc/add_product_uptate_bloc.dart';
import 'package:solutech_sat/bloc/add_sos_bloc.dart';
import 'package:solutech_sat/bloc/audit_sos_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/sos_item.dart';
import 'package:solutech_sat/helpers/brands_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/csku_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/sos_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/custom_expansion_tile.dart';
import 'package:solutech_sat/ui/widgets/filled_dropdown_button.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/ui/widgets/screen_stepper.dart';

class AuditSosScreen extends StatelessWidget {
  AuditSosBloc bloc;
  AuditSosScreen({@required Customer customer, @required String brandCategory})
      : bloc = AuditSosBloc(customer: customer, brandCategory: brandCategory);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return WillPopScope(
              onWillPop: bloc.onWillPop,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    "SOS: ${bloc.brandCategory?.toUpperCase()}",
                  ),
                ),
                body: Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: double.infinity,
                  child: ScreenStepper(
                    currentScreen: bloc.currentScreen,
                    screens: <Widget>[
                      ListView(
                        children: brandsManager
                            .getBrandByCategory(bloc.brandCategory)
                            .toList()
                            .map<Widget>((product) {
                          var index = brandsManager
                              .getBrandByCategory(bloc.brandCategory)
                              .toList()
                              .indexOf(product);
                          bloc.addAuditListeners(index);
                          return CustomExpansionTile(
                            backgroundColor: Colors.white,
                            title: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10.0)
                                  .copyWith(top: 13.0, bottom: 13.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Text(
                                    "${product.brand}",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  )),
                                  Icon(
                                    Icons.check_circle,
                                    color: (bloc
                                                    .audits[index][0].text
                                                    .trim() !=
                                                "" ||
                                            bloc.audits[index][1].text.trim() !=
                                                "" ||
                                            bloc.audits[index][2].text.trim() !=
                                                "")
                                        ? Colors.green
                                        : Colors.grey,
                                    size: 16.0,
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: (index + 1) % 2 == 0
                                      ? Colors.grey[100]
                                      : Colors.white),
                            ),
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                padding:
                                    EdgeInsets.all(10.0).copyWith(bottom: 5.0),
                                child: Row(
                                  children: <Widget>[
                                    if (roleManager
                                        .hasRole(Roles.USE_FACINGS_SOS))
                                      Expanded(
                                        child: TextFormField(
                                          controller: bloc.audits[index][0],
                                          inputFormatters: [
                                            WhitelistingTextInputFormatter
                                                .digitsOnly
                                          ],
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            filled: true,
                                            labelText: "Facings",
                                            isDense: true,
                                          ),
                                        ),
                                      ),
                                    if (roleManager
                                            .hasRole(Roles.USE_FACINGS_SOS) &&
                                        roleManager
                                            .hasRole(Roles.USE_LENGTH_SOS))
                                      Container(
                                        width: 5.0,
                                      ),
                                    if (roleManager
                                        .hasRole(Roles.USE_LENGTH_SOS))
                                      Expanded(
                                        child: TextFormField(
                                          controller: bloc.audits[index][1],
                                          inputFormatters: [
                                            WhitelistingTextInputFormatter
                                                .digitsOnly
                                          ],
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            filled: true,
                                            labelText: "Length",
                                            isDense: true,
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    EdgeInsets.all(10.0).copyWith(top: 5.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: TextFormField(
                                        controller: bloc.audits[index][2],
                                        inputFormatters: [
                                          WhitelistingTextInputFormatter
                                              .digitsOnly
                                        ],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          filled: true,
                                          labelText: "Position",
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        }).toList(),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          color: Colors.grey[100],
                          child: Column(
                            children: <Widget>[
                              Card(
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: TextFormField(
                                                controller:
                                                    bloc.totalFacingsCtrl,
                                                inputFormatters: [
                                                  WhitelistingTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  labelText: "Total facings",
                                                  isDense: true,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 5.0,
                                            ),
                                            Expanded(
                                              child: TextFormField(
                                                controller:
                                                    bloc.totalLengthCtrl,
                                                inputFormatters: [
                                                  WhitelistingTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  labelText: "Total length",
                                                  isDense: true,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: bloc.takePhoto,
                                        child: Container(
                                          height: (bloc.image != null)
                                              ? 200.0
                                              : 50.0,
                                          width: double.infinity,
                                          margin: EdgeInsets.only(top: 10.0),
                                          color: Colors.grey[100],
                                          child: Container(
                                            child: (bloc.image != null)
                                                ? Image.file(
                                                    bloc.image,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.camera_alt,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "PHOTO",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 10.0),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                height: 150.0,
                                                child: TextFormField(
                                                  controller: bloc.notesCtrl,
                                                  maxLines: 5,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    labelText: "Notes",
                                                    hintText:
                                                        "Enter additional notes",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                    onNext: bloc.nextScreen,
                    onPrev: bloc.prevScreen,
                    onSave: bloc.saveAudit,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
