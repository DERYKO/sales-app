import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:solutech_sat/bloc/login_bloc.dart';
import 'package:solutech_sat/tools/bloc_provider.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';
import 'package:solutech_sat/ui/widgets/login_form.dart';
import 'package:solutech_sat/ui/widgets/login_page_header.dart';

class LoginScreen extends StatelessWidget {
  LoginBloc bloc = LoginBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: OfflineBuilder(
                connectivityBuilder: (
                  BuildContext context,
                  ConnectivityResult connectivity,
                  Widget child,
                ) {
                  final bool connected =
                      connectivity != ConnectivityResult.none;
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            color: Colors.white,
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  LoginPageHeader(
                                    onSetupClient: bloc.setupClient,
                                  ),
                                  StreamBuilder(
                                      stream: bloc.stream,
                                      builder: (context, snapshot) {
                                        return LoginForm(
                                          onSubmit: bloc.login,
                                          loading: bloc.loading,
                                          emailController: bloc.emailCtrl,
                                          passwordController: bloc.passwordCtrl,
                                          formKey: bloc.loginFormKey,
                                          obscurePassword: bloc.obscurePassword,
                                          onObscurePassword:
                                              bloc.changePasswordVisibility,
                                        );
                                      })
                                ],
                              ),
                            )),
                      ),
                      Footer()
                    ],
                  );
                },
                child: Container())),
      ),
    );
  }
}
