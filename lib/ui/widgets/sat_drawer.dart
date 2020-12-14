import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/sat_drawer_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SatDrawer extends StatelessWidget {
  final bloc = SatDrawerBloc();
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: BlocProvider(
      bloc: bloc,
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SatDrawerHeader(
              userName: authManager.user?.name ?? "",
              userEmail: authManager.user?.email ?? "",
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  /*ModuleItem(
                            module: "checkin",
                            child: ListTile(
                              leading: Icon(Icons.accessibility),
                              title: Text("Checkins", style: drawerText),
                              onTap: onCheckins,
                            ),
                          ),
                          ModuleItem(
                            module: "inventory",
                            child: ListTile(
                              leading: Icon(Icons.all_inclusive),
                              title: Text("Received goods", style: drawerText),
                              onTap: onReceivedGoods,
                            ),
                          ),
                          ModuleItem(
                            module: "statusupdate",
                            child: ListTile(
                              leading: Icon(Icons.update),
                              title: Text("Status update", style: drawerText),
                              onTap: onStatusUpdate,
                            ),
                          ),
                          ModuleItem(
                            module: "feedback",
                            child: ListTile(
                              leading: Icon(Icons.feedback),
                              title: Text("Feedback", style: drawerText),
                              onTap: onFeedBack,
                            ),
                          ),
                          ModuleItem(
                            module: "closeday",
                            child: ListTile(
                              leading: Icon(Icons.assignment),
                              title: Text("Closing day reports",
                                  style: drawerText),
                              onTap: onClosingDayReports,
                            ),
                          ),
                          ModuleItem(
                            module: "inventory",
                            child: ListTile(
                              leading: Icon(FontAwesomeIcons.user),
                              title: Text("Stock Levels", style: drawerText),
                              onTap: onStockLevels,
                            ),
                          ),
                          ModuleItem(
                            module: "images",
                            child: ListTile(
                              leading: Icon(FontAwesomeIcons.image),
                              title: Text("General Photos", style: drawerText),
                              onTap: onListPhotos,
                            ),
                          ),
                          ModuleItem(
                            module: "competitor",
                            child: ListTile(
                              leading: Icon(FontAwesomeIcons.trophy),
                              title: Text("Competitor activities",
                                  style: drawerText),
                              onTap: onListCompetition,
                            ),
                          ),
                          ModuleItem(
                            module: "shelfshare",
                            child: ListTile(
                              leading: Icon(Icons.table_chart),
                              title: Text("Share of shelf", style: drawerText),
                              onTap: onListSos,
                            ),
                          ),
                          ToggleItem(
                            show: hasModule("expiries") || hasModule("damages"),
                            child: ListTile(
                              leading: Icon(Icons.branding_watermark),
                              title: Text("Expiry damages", style: drawerText),
                              onTap: onExpiryDamages,
                            ),
                          ),
                          ModuleItem(
                            module: "backcheck",
                            child: ListTile(
                              leading: Icon(Icons.crop_free),
                              title: Text("Back Checking", style: drawerText),
                              onTap: onBackChecking,
                            ),
                          ),

                          ModuleItem(
                            module: "auditstockpoint",
                            child: ListTile(
                              leading: Icon(Icons.playlist_add_check),
                              title:
                                  Text("Stockpoint Audit", style: drawerText),
                              onTap: onStockPointAudit,
                            ),
                          ),
                          */
                  ListTile(
                    leading: Icon(Icons.attach_money),
                    title: Text('Pricelists', style: drawerText),
                    onTap: bloc.priceLists,
                  ),
                  ListTile(
                    leading: Icon(Icons.print),
                    title: Text('ETR Printer', style: drawerText),
                    onTap: bloc.etrPrinter,
                  ),
                  ListTile(
                    leading: Icon(Icons.not_listed_location),
                    title: Text('Send Location', style: drawerText),
                    onTap: bloc.sendLiveLocation,
                  ),
                  ListTile(
                    leading: Icon(Icons.power_settings_new),
                    title: Text('Logout', style: drawerText),
                    onTap: bloc.logout,
                  ),
                ],
              ),
            ),
            Container(
              height: 45.0,
              width: double.infinity,
              padding: EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "${config.appName}",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    width: 10.0,
                  ),
                  Flexible(
                    child: AutoSizeText(
                      "v${config.appVersion}",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.grey[400],
                      ),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey[200],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class SatDrawerHeader extends StatelessWidget {
  String userName;
  String userEmail;
  SatDrawerHeader({
    this.userName,
    this.userEmail,
  });
  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Text(
        userName,
        style: TextStyle(
          fontSize: 16.0,
          color: config.contrastColor,
        ),
      ),
      accountEmail: Text(
        userEmail,
        style: TextStyle(color: config.contrastColor),
      ),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.grey[100],
        backgroundImage: AssetImage(
          "assets/images/avatar.jpg",
        ),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

var drawerText = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 15.0,
  color: Colors.grey[700],
);
