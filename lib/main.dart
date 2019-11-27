

import 'package:flutter/material.dart';
import 'package:login/models/models/auth.dart';
import 'package:login/fragments/forgot_password.dart';
import 'package:login/services/service_locator.dart';
import 'package:persist_theme/data/models/theme_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'fragments/resetPassword.dart';
import 'fragments/verify_forgot_password.dart';
import 'home_page.dart';
import 'login_page.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class _MyAppState extends State<MyApp> {
  final ThemeModel _model = ThemeModel();
  final AuthModel _auth = new AuthModel();

  @override
  void initState() {
    try {
      _model.loadFromDisk();
    } catch (e) {
      print("Error Loading Theme: $e");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ThemeModel>(
        model: _model,
        child: new ScopedModelDescendant<ThemeModel>(
          builder: (context, child, theme) => ScopedModel<AuthModel>(
            model: _auth,
            child: MaterialApp(
              theme: theme.theme,
              home:new ScopedModelDescendant<AuthModel>(
                  builder: (context, child, model) {
                    if (model?.user != null) return MyHomePage() ;
                    return LoginPage();
                  }),
              routes: <String, WidgetBuilder>{
                "/home": (BuildContext context) => MyHomePage(),
                "/login": (BuildContext context) => LoginPage(),
                "/forgotpassword": (BuildContext context) => ForgotPassword(),
                "/otp": (BuildContext context) => OtpVerification(),
                "/reset": (BuildContext context) => ResetPassword(),
              },
            ),
          ),
        ));
  }
}


