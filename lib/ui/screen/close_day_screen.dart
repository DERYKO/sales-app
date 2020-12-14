import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solutech_sat/bloc/close_day_bloc.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/day_manager.dart';
import 'package:solutech_sat/helpers/role_manager.dart';
import 'package:solutech_sat/helpers/session_manager.dart';
import 'package:solutech_sat/helpers/stats_manager.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/circular_material_spinner.dart';
import 'package:solutech_sat/ui/widgets/connection_status.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/utils/format_utils.dart';

class CloseDayScreen extends StatelessWidget {
  final bloc = CloseDayBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarOpacity: 1.0,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              ConnectionStatus(),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Container(
                    padding: EdgeInsets.all(
                      20.0,
                    ).copyWith(
                      top: 20.0,
                      bottom: 0.0,
                    ),
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Center(
                            child: Text(
                              "Closing day questionare",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 21.0,
                              ),
                            ),
                          ),
                        ),
                        if (roleManager.hasRole(Roles.USE_ODOMETER))
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: TextFormField(
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: "What is your odometer reading?",
                              ),
                            ),
                          ),
                        if (int.parse("${statsManager.salesSummary.target}") >
                            int.parse(
                                "${Set.from(sessionManager.sessions.map((session) => session.customerId).toList()).length}"))
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: TextFormField(
                              maxLines: 2,
                              controller: bloc.callageCommentCtrl,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText:
                                    "Why have you visited only ${Set.from(sessionManager.sessions.map((session) => session.customerId).toList()).length} customers?",
                                labelStyle: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                        if (double.parse(
                                "${statsManager.salesSummary.targetValue}") >
                            double.parse(
                                "${statsManager.salesSummary.totalSales}"))
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: TextFormField(
                              maxLines: 2,
                              controller: bloc.salesCommentCtrl,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText:
                                    "Why have you sold only ${formatCurrency(double.parse(statsManager.salesSummary.totalSales))}?",
                                labelStyle: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: TextFormField(
                            controller: bloc.generalCommentCtrl,
                            maxLines: 2,
                            decoration: InputDecoration(
                              isDense: true,
                              labelText: "How was your day?",
                              labelStyle: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: StreamBuilder(
                            stream: dayManager.stream,
                            builder: (context, snapshot) {
                              return StreamBuilder(
                                  stream: connectionManager.stream,
                                  builder: (context, snapshot) {
                                    return MaterialButton(
                                      elevation: (dayManager.closingDay ||
                                              !connectionManager.isConnected)
                                          ? 0.0
                                          : 2.0,
                                      disabledColor: Color(0xFFdfdfdf),
                                      onPressed: (dayManager.closingDay ||
                                              !connectionManager.isConnected)
                                          ? null
                                          : bloc.closeDay,
                                      child: CircularMaterialSpinner(
                                        loading: dayManager.closingDay,
                                        color: Colors.grey,
                                        width: 25.0,
                                        height: 25.0,
                                        strokeWidth: 4.0,
                                        child: Text(
                                          "CLOSE DAY",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      color: (dayManager.closingDay ||
                                              !connectionManager.isConnected)
                                          ? Color(0xFFdfdfdf)
                                          : Theme.of(context).accentColor,
                                      height: 50.0,
                                      minWidth:
                                          MediaQuery.of(context).size.width,
                                    );
                                  });
                            },
                          ),
                        ),
                      ],
                    ),
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
