import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solutech_sat/bloc/add_edit_customer_bloc.dart';
import 'package:solutech_sat/bloc/add_feedback_bloc.dart';
import 'package:solutech_sat/bloc/add_status_update_bloc.dart';
import 'package:solutech_sat/bloc/add_stock_bloc.dart';
import 'package:solutech_sat/bloc/status_updates_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/brand.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/feedback_category.dart';
import 'package:solutech_sat/data/models/shop_category.dart';
import 'package:solutech_sat/data/models/stockpoint.dart';
import 'package:solutech_sat/helpers/brands_manager.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/helpers/stockpoints_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/screen/add_stock_screen.dart';
import 'package:solutech_sat/ui/widgets/filled_dropdown_button.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/ui/widgets/screen.dart';
import 'package:solutech_sat/ui/widgets/screen_stepper.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AddFeedbackScreen extends StatelessWidget {
  AddFeedbackBloc bloc;
  AddFeedbackScreen({Customer customer})
      : bloc = AddFeedbackBloc(customer: customer);

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
                        title: "ADD FEEDBACK",
                        module: Roles.FEEDBACK,
                        capitalize: true,
                      )}"),
                    ),
                    if (bloc.customer != null)
                      Text(
                        "${bloc.customer?.shopName?.toUpperCase()}",
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
                            Container(
                              padding: EdgeInsets.all(10.0).copyWith(
                                bottom: 5.0,
                              ),
                              child: StreamBuilder(
                                stream: commonsManager.stream,
                                builder: (context, snapshot) {
                                  return FilledDropdownButton(
                                    isDense: true,
                                    value: bloc.category,
                                    label: "Category",
                                    hint: "Select category ",
                                    items: commonsManager.feedbackCategories
                                        .map((FeedbackCategory
                                            feedbackCategory) {
                                      return DropdownMenuItem(
                                        child: Text(
                                            "${feedbackCategory.feedbackCategory}"),
                                        value: feedbackCategory,
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
                              padding: EdgeInsets.all(5.0)
                                  .copyWith(top: 0.0, bottom: 0.0, left: 5),
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
                                        : Icon(
                                            Icons.camera_alt,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10.0).copyWith(
                                bottom: 5.0,
                              ),
                              child: StreamBuilder(
                                stream: commonsManager.stream,
                                builder: (context, snapshot) {
                                  return FilledDropdownButton(
                                    isDense: true,
                                    value: bloc.brand,
                                    label: "Brand",
                                    hint: "Select brand ",
                                    onTap: bloc.selectBrand,
                                    items:
                                        brandsManager.brands.map((Brand brand) {
                                      return DropdownMenuItem(
                                        child: Text("${brand.brand}"),
                                        value: brand,
                                      );
                                    }).toList(),
                                    onChange: (value) {
                                      bloc.onBrandChanged(value);
                                    },
                                  );
                                },
                              ),
                            ),
                            if (bloc.category?.hasbatch == "YES")
                              Container(
                                padding: EdgeInsets.all(10.0).copyWith(
                                  top: 0.0,
                                  bottom: 5.0,
                                ),
                                child: TextFormField(
                                  controller: bloc.batchNumberCtrl,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    labelText: "Batch number",
                                    hintText: "Enter batch number",
                                  ),
                                ),
                              ),
                            Container(
                              padding: EdgeInsets.all(10.0).copyWith(
                                top: 0.0,
                                bottom: 5.0,
                              ),
                              child: TextFormField(
                                controller: bloc.quantityCtrl,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  labelText: "Quantity",
                                  hintText: "Enter quantity",
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
                                onPressed: bloc.saveFeedback,
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
