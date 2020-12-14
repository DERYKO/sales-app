import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:solutech_sat/config.dart';
import 'package:solutech_sat/helpers/connection_manager.dart';
import 'package:validators/validators.dart' as validator;

import 'circular_material_spinner.dart';

class LoginForm extends StatelessWidget {
  GlobalKey<FormState> formKey;
  TextEditingController emailController;
  TextEditingController passwordController;
  bool obscurePassword;
  Function onObscurePassword;
  FocusNode passwordFocusNode = FocusNode();
  bool loading;
  Function onSubmit;

  LoginForm({
    this.formKey,
    this.emailController,
    this.passwordController,
    this.obscurePassword,
    this.loading,
    this.onSubmit,
    this.onObscurePassword,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 38.0, right: 38.0, top: 30.0),
      child: Form(
        key: formKey,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Email Text input Field
            StreamBuilder(
              stream: connectionManager.stream,
              builder: (context, snapshot) {
                return TextFormField(
                  controller: emailController,
                  enabled: connectionManager.isConnected,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(passwordFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter your email';

                    if (!validator.isEmail(value)) return 'Enter a valid email';

                    return null;
                  },
                  decoration: new InputDecoration(
                    labelText: "Email",
                  ),
                );
              },
            ),
            // Separator
            Divider(
              color: Colors.transparent,
            ),
            // Password Text Input
            StreamBuilder(
              stream: connectionManager.stream,
              builder: (context, snapshot) {
                return TextFormField(
                  enabled: connectionManager.isConnected,
                  focusNode: passwordFocusNode,
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    onSubmit();
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  obscureText: obscurePassword,
                  decoration: new InputDecoration(
                    labelText: "Password",
                    suffixIcon: new GestureDetector(
                      onTap: onObscurePassword,
                      child: new Container(
                        color: Colors.white,
                        width: 40.0,
                        height: 30.0,
                        child: new Icon(
                          (obscurePassword)
                              ? FontAwesomeIcons.eyeSlash
                              : FontAwesomeIcons.eye,
                          size: 15.0,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            _SignInButton(
              loading: loading,
              onSubmit: onSubmit,
            ),
            Container(
              margin: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: Color(0xFF8F8E8E),
                      fontSize: 16.0,
                    ),
                  ),
                  GestureDetector(
                    child: StreamBuilder(
                        stream: connectionManager.stream,
                        builder: (context, snapshot) {
                          return Text(
                            " Recover",
                            style: TextStyle(
                              color: connectionManager.isConnected
                                  ? Theme.of(context).primaryColor
                                  : Colors.black54,
                              fontSize: 16.0,
                            ),
                          );
                        }),
                    onTap: () {},
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SignInButton extends StatelessWidget {
  bool loading;
  Function onSubmit;

  _SignInButton({this.loading, this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: connectionManager.stream,
      builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.only(top: 20.0),
          child: MaterialButton(
            elevation: (loading || !connectionManager.isConnected) ? 0.0 : 2.0,
            disabledColor: Color(0xFFdfdfdf),
            onPressed:
                (loading || !connectionManager.isConnected) ? null : onSubmit,
            child: CircularMaterialSpinner(
              loading: loading,
              color: Colors.grey,
              width: 25.0,
              height: 25.0,
              strokeWidth: 4.0,
              child: Text(
                "SIGN IN",
                style: TextStyle(fontSize: 18.0, color: config.contrastColor),
              ),
            ),
            color: (loading || !connectionManager.isConnected)
                ? Color(0xFFdfdfdf)
                : Theme.of(context).primaryColor,
            height: 50.0,
            minWidth: MediaQuery.of(context).size.width,
          ),
        );
      },
    );
  }
}
