import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:login/models/models/auth.dart';
import 'package:login/utils/popUp.dart';
import 'package:login/utils/webConfig.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  CreateAccountState createState() => CreateAccountState();
}

class CreateAccountState extends State<ChangePassword> {
  String _status = 'no-action';
  String _oldPassword, _newPassword, _confirmUsername;

  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _controllerOldPassword, _controllerNewPassword, _controllerUserName;

  @override
  initState() {
    _controllerOldPassword = TextEditingController();
    _controllerNewPassword = TextEditingController();
    _controllerUserName = TextEditingController();
    super.initState();
  }
  /*void _loadUsername() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _username = _prefs.getString("saved_username") ?? "";
    } catch (e) {
      print(e);
    }
  }*/
  @override
  Widget build(BuildContext context) {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Change Password",
          textScaleFactor: textScaleFactor,
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          key: PageStorageKey("Divider 1"),
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: 'Old Password'),
                      validator: (val) =>
                      val.length < 1 ? 'Enter Old Password' : null,
                      onSaved: (val) => _oldPassword = val,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      controller: _controllerOldPassword,
                      autocorrect: false,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: 'New Password'),
                      validator: (val) =>
                      val.length < 1 ? 'Enter New Password' : null,
                      onSaved: (val) => _newPassword = val,
                      obscureText: true,
                      controller: _controllerNewPassword,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: 'Confirm Password'),
                      validator: (val) =>
                      val.length < 1 ? 'Confirm Password' : null,
                      onSaved: (val) => _confirmUsername = val,
                      controller: _controllerUserName,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: NativeButton(
                child: Text(
                  'Submit',
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
                        .changePassword(
                      oldPassword: _oldPassword.toString().trim(),
                      newPassword: _newPassword.toString().trim(),
                      confirmUsername: _confirmUsername.toString().trim(),
                    )
                        .then((result) {
                      try {if (result) {
                        Navigator.of(context).pushReplacementNamed('/home');
                      } else {
                        setState(() => this._status = 'rejected');
                        showAlertPopup(context, 'Password Not Changed', _auth.errorMessage);
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
