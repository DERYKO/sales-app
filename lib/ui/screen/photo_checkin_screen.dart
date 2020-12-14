import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solutech_sat/bloc/add_edit_customer_bloc.dart';
import 'package:solutech_sat/bloc/add_feedback_bloc.dart';
import 'package:solutech_sat/bloc/add_status_update_bloc.dart';
import 'package:solutech_sat/bloc/add_stock_bloc.dart';
import 'package:solutech_sat/bloc/photo_checkin_bloc.dart';
import 'package:solutech_sat/bloc/status_updates_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/app_data.dart';
import 'package:solutech_sat/data/models/brand.dart';
import 'package:solutech_sat/data/models/customer.dart';
import 'package:solutech_sat/data/models/shop_category.dart';
import 'package:solutech_sat/data/models/stockpoint.dart';
import 'package:solutech_sat/helpers/brands_manager.dart';
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

/*
class PhotoCheckinScreen extends StatelessWidget {
  PhotoCheckinBloc bloc;
  PhotoCheckinScreen({Customer customer}) : bloc = PhotoCheckinBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return Scaffold(
              body: Container(
                width: double.infinity,
                color: Colors.white,
                child: (bloc.image == null)
                    ? LayoutBuilder(builder: (context, constraints) {
                        return Column(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: LayoutBuilder(
                                  builder: (context, constraints) {
                                return Stack(children: [
                                  CameraPreview(bloc.controller),
                                  Positioned(
                                    top: constraints.maxHeight * .30,
                                    left: (constraints.maxWidth * .45) / 2,
                                    child: Container(
                                      width: constraints.maxWidth * .55,
                                      height: (constraints.maxHeight * .40),
                                      alignment: AlignmentDirectional.center,
                                      child: Text(
                                        "PLACE HEAD HERE",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ),
                                  )
                                ]);
                              }),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                alignment: AlignmentDirectional.center,
                                child: Container(
                                  child: InkWell(
                                    onTap: bloc.capturePhoto,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        top: 10.0,
                                      ),
                                      width: 70.0,
                                      height: 70.0,
                                      child: Icon(
                                        Icons.camera,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                          width: 5.0,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0, -1),
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      })
                    : Container(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Image.file(
                                bloc.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: FlatButton(
                                    onPressed: bloc.cancelImage,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 2.0,
                                  color: Colors.black54,
                                ),
                                Expanded(
                                  child: FlatButton(
                                    onPressed: bloc.confirmImage,
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
              ),
            );
          }),
    );
  }
}
*/
