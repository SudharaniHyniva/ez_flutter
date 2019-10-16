import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:login/models/models/auth.dart';
import 'package:login/utils/popUp.dart';
import 'package:login/utils/webConfig.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class ForgotPassword extends StatefulWidget {
  CreateAccountState createState() => CreateAccountState();
}

class CreateAccountState extends State<ForgotPassword> {
  String _status = 'no-action';
  String _username;

  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _controllerUsername;

  @override
  initState() {
    _controllerUsername = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Forgot Password",
          textScaleFactor: textScaleFactor,
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          key: PageStorageKey("Divider 1"),
          children: <Widget>[
            SizedBox(
              height: 200.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Image.asset('assets/logo.png'),),
            ),
            Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: 'Enter username or mobile number'),
                      validator: (val) =>
                          val.length < 1 ? 'Username or mobile number Required' : null,
                      onSaved: (val) => _username = val,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      controller: _controllerUsername,
                      autocorrect: false,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: NativeButton(
                child: Text(
                  'Send OTP',
                  textScaleFactor: textScaleFactor,
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  final form = formKey.currentState;
                  if (form.validate()) {
                    form.save();
                    final snackbar = SnackBar(
                      duration: Duration(seconds: 30),
                      content: Row(
                        children: <Widget>[
                          NativeLoadingIndicator(),
                          Text("  Logging In...")
                        ],
                      ),
                    );
                    _scaffoldKey.currentState.showSnackBar(snackbar);

                    setState(() => this._status = 'loading');

                    _auth
                        .forgotPassword(
                      username: _username.toString().trim(),
                    )
                        .then((result) {
                      try {if (result) {
                        Navigator.of(context).pushReplacementNamed('/otp');
                      } else {
                        setState(() => this._status = 'rejected');
                        showAlertPopup(context, 'Unable to generate OTP', _auth.errorMessage);
                      }

                      _scaffoldKey.currentState.hideCurrentSnackBar();
                      } catch (e) {
                        print('Error with URL: $e');
                      }
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
