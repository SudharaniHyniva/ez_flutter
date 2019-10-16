import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:login/models/models/auth.dart';
import 'package:login/utils/popUp.dart';
import 'package:login/utils/webConfig.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class ResetPassword extends StatefulWidget {
  CreateAccountState createState() => CreateAccountState();
}

class CreateAccountState extends State<ResetPassword> {
  String _status = 'no-action';
  String _newPassword, _confirmPassword;

  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _controllerNewPassword, _controllerConfirmPassword;

  @override
  initState() {
    _controllerNewPassword = TextEditingController();
    _controllerConfirmPassword = TextEditingController();
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
                      decoration: InputDecoration(labelText: 'New Password'),
                      validator: (val) =>
                      val.length < 1 ? 'Enter New Password' : null,
                      onSaved: (val) => _newPassword = val,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      controller: _controllerNewPassword,
                      autocorrect: false,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: 'Confrim Password'),
                      validator: (val) =>
                      val.length < 1 ? 'Confirm New Password' : null,
                      onSaved: (val) => _confirmPassword = val,
                      obscureText: true,
                      controller: _controllerConfirmPassword,
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
                        .resetPassword(
                      newPassword: _newPassword.toString().trim(),
                      confirmPassword: _confirmPassword.toString().trim(),
                    )
                        .then((result) {
                      try {if (result) {
                        Navigator.of(context).pushReplacementNamed('/login');
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
