import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:solutech_sat/bloc/refresh_bloc.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/helpers/auth_manager.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:solutech_sat/helpers/refresh_manager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';

class RefreshLoader extends StatelessWidget {
  void showToken() {
    print("${authManager.user}");
  }

  RefreshBloc bloc;

  RefreshLoader({this.bloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: refreshManager.stream,
        builder: (context, snapshot) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            child: (refreshManager.step == 1)
                ? Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: showToken,
                          child: Image.asset(
                            config.appIcon,
                            height: config.appIconSize.splash,
                            width: config.appIconSize.splash,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            if (refreshManager.erred)
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                ),
                              ),
                            Text(
                              "Setting up",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: refreshManager.erred
                                    ? Colors.red
                                    : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            "${refreshManager.progressText}",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        if (!refreshManager.erred)
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: SpinKitThreeBounce(
                              color: Theme.of(context).accentColor,
                              size: 16,
                            ),
                          ),
                        if (refreshManager.erred)
                          Padding(
                            padding: EdgeInsets.all(20.0).copyWith(top: 10.0),
                            child: Text(
                              "${refreshManager.errorText}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        if (refreshManager.erred)
                          Padding(
                            padding: EdgeInsets.all(20.0).copyWith(top: 10.0),
                            child: MaterialButton(
                              color: Theme.of(context).primaryColor,
                              onPressed: (refreshManager.errorText ==
                                      "Unauthenticated.")
                                  ? bloc.onLogout
                                  : refreshManager.reload,
                              child: Text(
                                "${(refreshManager.errorText == "Unauthenticated.") ? "LOG OUT" : "RETRY"}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 170.0,
                        height: 170.0,
                        child: Opacity(
                          opacity: 0.8,
                          child: LiquidCircularProgressIndicator(
                            value: refreshManager.progress, // Defaults to 0.5.
                            valueColor: AlwaysStoppedAnimation(
                              Theme.of(context).primaryColor,
                            ), // Defaults to the current Theme's accentColor.
                            backgroundColor: Theme.of(context)
                                .primaryColor
                                .withAlpha(
                                  25,
                                ), // Defaults to the current Theme's backgroundColor.
                            borderColor: Colors.white30,
                            borderWidth: 1.0,
                            direction: Axis
                                .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                            center: Text(
                              "${(refreshManager.progress * 100).floor()}%",
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0).copyWith(
                          top: 10.0,
                          bottom: 10.0,
                        ),
                        child: Column(
                          children: [
                            ...refreshManager.tasks.map((task) {
                              var index = refreshManager.tasks.indexOf(task);
                              return Container(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withAlpha(220),
                                width: double.infinity,
                                height: 35.0,
                                margin: EdgeInsets.only(
                                  top: 10.0,
                                ),
                                padding: EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                  top: 6.0,
                                  bottom: 6.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "${task.title}",
                                      style: TextStyle(
                                          color: config.contrastColor),
                                    ),
                                    if (refreshManager.currentIndex > index)
                                      Icon(
                                        Icons.done_all,
                                        color: config.contrastColor,
                                        size: 20.0,
                                      ),
                                    if (refreshManager.currentIndex == index)
                                      (refreshManager.erred)
                                          ? Icon(
                                              Icons.error_outline,
                                              color: config.contrastColor,
                                            )
                                          : SpinKitThreeBounce(
                                              color: config.contrastColor,
                                              size: 10.0,
                                            ),
                                  ],
                                ),
                              );
                            }).toList(),
                            if (refreshManager.erred)
                              Padding(
                                padding:
                                    EdgeInsets.all(20.0).copyWith(top: 10.0),
                                child: Text(
                                  "${refreshManager.errorText}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            if (refreshManager.erred)
                              Padding(
                                padding:
                                    EdgeInsets.all(20.0).copyWith(top: 5.0),
                                child: MaterialButton(
                                  color: Theme.of(context).primaryColor,
                                  onPressed: (refreshManager.errorText ==
                                          "Unauthenticated.")
                                      ? bloc.onLogout
                                      : refreshManager.reload,
                                  child: Text(
                                    "${(refreshManager.errorText == "Unauthenticated.") ? "LOG OUT" : "RETRY"}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
          );
        });
  }
}
