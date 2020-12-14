import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solutech_sat/bloc/add_edit_customer_bloc.dart';
import 'package:solutech_sat/bloc/add_status_update_bloc.dart';
import 'package:solutech_sat/bloc/add_stock_bloc.dart';
import 'package:solutech_sat/bloc/status_updates_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/shop_category.dart';
import 'package:solutech_sat/data/models/stockpoint.dart';
import 'package:solutech_sat/helpers/commons_manager.dart';
import 'package:solutech_sat/helpers/location_manager.dart';
import 'package:solutech_sat/helpers/settings_manager.dart';
import 'package:solutech_sat/helpers/stockpoints_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/screen/add_stock_screen.dart';
import 'package:solutech_sat/ui/widgets/filled_dropdown_button.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/ui/widgets/screen.dart';
import 'package:solutech_sat/ui/widgets/screen_stepper.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AddStatusUpdateScreen extends StatelessWidget {
  final bloc = AddStatusUpdateBloc();

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
                  bloc.mode == "status" ? "Status update" : "Apply leave",
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RadioItem(
                                  title: Text("Status update"),
                                  value: "status",
                                  groupValue: bloc.mode,
                                  onChanged: bloc.onModeChange,
                                  activeColor: Theme.of(context).accentColor,
                                ),
                                RadioItem(
                                  value: "leave",
                                  title: Text("Leave application"),
                                  groupValue: bloc.mode,
                                  onChanged: bloc.onModeChange,
                                  activeColor: Theme.of(context).accentColor,
                                ),
                              ],
                            ),
                            if (bloc.mode == "status")
                              Container(
                                padding: EdgeInsets.all(10.0).copyWith(
                                  bottom: 5.0,
                                ),
                                child: StreamBuilder(
                                  stream: commonsManager.stream,
                                  builder: (context, snapshot) {
                                    return FilledDropdownButton(
                                      isDense: true,
                                      value: bloc.statusCategory,
                                      label: "Category",
                                      hint: "Select status category ",
                                      items: commonsManager.statusCategory
                                          .map((AppData appData) {
                                        return DropdownMenuItem(
                                          child: Text("${appData.data}"),
                                          value: appData,
                                        );
                                      }).toList(),
                                      onChange: (value) {
                                        bloc.onAppDataChanged(value);
                                      },
                                    );
                                  },
                                ),
                              ),
                            if (bloc.mode == "leave")
                              Container(
                                padding: EdgeInsets.only(
                                    bottom: 10.0, left: 10.0, right: 10.0),
                                child: Stack(
                                  children: <Widget>[
                                    TextFormField(
                                      controller: bloc.leavePeriodCtrl,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        filled: true,
                                        labelText: "Date range",
                                        hintText: "Select date range",
                                        suffixIcon: Icon(
                                          Icons.date_range,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: bloc.filterByDate,
                                      child: Container(
                                        color: Colors.transparent,
                                        height: 50.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            Padding(
                              padding: EdgeInsets.all(10.0)
                                  .copyWith(top: 0.0, left: 12.0),
                              child: GestureDetector(
                                onTap: bloc.takePhoto,
                                child: Container(
                                  height: (bloc.image != null) ? 200.0 : 150.0,
                                  width: double.infinity,
                                  margin: EdgeInsets.only(right: 5.0),
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
                                onPressed: bloc.saveStatusUpdate,
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
