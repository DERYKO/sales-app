import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/posm_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/data/models/posm.dart';
import 'package:solutech_sat/helpers/posm_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/sync_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class PosmScreen extends StatelessWidget {
  final bloc = PosmBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("${roleManager.resolveTitle(
            title: "POSM",
            module: Roles.POSM_AUDIT,
          )}"),
          actions: <Widget>[
            StreamBuilder(
                stream: syncManager.stream,
                builder: (context, snapshot) {
                  return (!syncManager.syncing)
                      ? IconButton(
                          onPressed: bloc.refresh,
                          icon: Icon(
                            Icons.refresh,
                          ),
                        )
                      : Container();
                }),
            IconButton(
              icon: Icon(
                Icons.date_range,
                color: config.contrastColor,
              ),
              onPressed: bloc.filterByDate,
            ),
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Colors.grey[100],
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: StreamBuilder(
                            stream: posmManager.stream,
                            builder: (context, snapshot) {
                              return CircularMaterialSpinner(
                                loading: posmManager.loadingPosms,
                                child: ListView.builder(
                                    itemCount: posmManager.posms.length,
                                    itemBuilder: (context, index) {
                                      Posm posm = posmManager.posms[index];
                                      return Container(
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    "${posm.shopName}",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.done_all,
                                                  color: (posm.synced)
                                                      ? Colors.green
                                                      : Colors.grey,
                                                  size: 16.0,
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 5.0,
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Text(
                                                      "${posm.productName}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${formatDate(posm.entryTime)} ${formatDate(posm.entryTime, "jm")}",
                                                    style: TextStyle(
                                                      fontSize: 11.0,
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10.0,
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Text(
                                                      "${posm.itemname}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  "Availability: ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  "${posm.availability ?? ""}",
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  "Stocked: ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  "${posm.stocked ?? ""}",
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  "Visibility: ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  "${posm.visibility ?? ""}",
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border(
                                                bottom: BorderSide(
                                              color: Colors.grey[300],
                                            ))),
                                      );
                                    }),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
