import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/setup_bloc.dart';
import 'package:solutech_sat/bloc/splash_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/client_code_form.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';

class SetupScreen extends StatelessWidget {
  final SetupBloc bloc = SetupBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          height: double.infinity,
          child: Container(
            height: 250.0,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          height: 225.0,
                          padding: EdgeInsets.all(20.0),
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${config.appName}",
                                style: TextStyle(
                                    color: config.contrastColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 28.0),
                              ),
                              Text(
                                "Setup client",
                                style: TextStyle(
                                    color: config.contrastColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0),
                              )
                            ],
                          ),
                          color: Theme.of(context).primaryColor,
                        ),
                        ClientCodeForm(
                          onFinish: bloc.changeClient,
                        ),
                      ],
                    ),
                  ),
                ),
                Footer(),
              ],
            ),
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
