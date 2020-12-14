import 'package:flutter/material.dart';
import 'package:solutech_sat/bloc/splash_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';

class SplashScreen extends StatelessWidget {
  final SplashBloc bloc = SplashBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return Scaffold(
              body: Container(
                color: Colors.white,
                child: Center(
                  child: Hero(
                    tag: "logo",
                    child: Image.asset(
                      config.appIcon,
                      height: config.appIconSize.splash,
                      width: config.appIconSize.splash,
                    ),
                  ),
                ),
                width: double.infinity,
                height: double.infinity,
              ),
            );
          }),
    );
  }
}
