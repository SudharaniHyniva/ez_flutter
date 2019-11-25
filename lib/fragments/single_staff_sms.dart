import 'package:flutter/material.dart';
import 'package:login/models/models/auth.dart';
import 'package:login/utils/popUp.dart';
import 'package:login/utils/webConfig.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class SingleStaffSMS extends StatefulWidget {
  _SingleStaffSMS createState() => _SingleStaffSMS();
}

class _SingleStaffSMS extends State<SingleStaffSMS> {
  String _status = 'no-action';
  // ignore: non_constant_identifier_names
  String _SMSContent;
  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _controllerText;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Send SMS'),
      ),
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: 'SMS Text'),
                      validator: (val) =>
                      val.length < 1 ? 'Enter SMS Text' : null,
                      onSaved: (val) => _SMSContent = val,
                      obscureText: false,
                      controller: _controllerText,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: NativeButton(
                color: Colors.blueAccent,
                child: Text(
                  'Send',
                  style: new TextStyle(fontSize: 20.0, color: Colors.white),
                  textScaleFactor: textScaleFactor,
                ),
                onPressed: () {
                  final form = formKey.currentState;
                  if (form.validate()) {
                    form.save();
                    final snackbar = SnackBar(
                      duration: Duration(seconds: 30),
                      content: Row(
                        children: <Widget>[
                          NativeLoadingIndicator(),
                          Text("Logging In...")
                        ],
                      ),
                    );
                    _scaffoldKey.currentState.showSnackBar(snackbar);
                    setState(() => this._status = 'loading');
                    _auth
                        .SendSingleStaffSMS(
                      smsDescreption:
                      _SMSContent.toString().toLowerCase().trim(),
                    )
                        .then((result) {
                      try {
                        if (result) {
                          Navigator.of(context).pushReplacementNamed('/home');
                        } else {
                          setState(() => this._status = 'rejected');
                          showAlertPopup(
                              context,
                              'Unable to Send SMS',
                              _auth.errorMessage);
                        }

                        _scaffoldKey.currentState.hideCurrentSnackBar();
                      } catch (e) {
                        print('Error with URL: $e');
                      }
                    });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
