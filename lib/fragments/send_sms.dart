import 'package:flutter/material.dart';
import 'package:login/models/models/auth.dart';
import 'package:login/utils/popUp.dart';
import 'package:login/utils/webConfig.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendSMS extends StatefulWidget {
  _SendSMS createState() => _SendSMS();
}

class SMSType {
  String name;
  SMSType(this.name);
  static List<SMSType> getType() {
    return <SMSType>[
      SMSType('Select Type'),
      SMSType('All'),
      SMSType('All Parents'),
      SMSType('Staff'),
      SMSType('Class & section'),
      SMSType('Others')
    ];
  }
}

class _SendSMS extends State<SendSMS> {
  String _status = 'no-action';
  // ignore: non_constant_identifier_names
  String _SMSContent;
  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _controllerPassword;
  List<SMSType> _smsList = SMSType.getType();
  List<DropdownMenuItem<SMSType>> _dropdownSMSItems;
  SMSType _selectedType;
  @override
  void initState() {
    _dropdownSMSItems = buildDropdownMenuItems(_smsList);
    _selectedType = _dropdownSMSItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<SMSType>> buildDropdownMenuItems(List staff) {
    List<DropdownMenuItem<SMSType>> items = List();
    for (SMSType staffType in staff) {
      items.add(
        DropdownMenuItem(
          value: staffType,
          child: Text(staffType.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(SMSType selectedStaffType) {
    setState(() {
      _selectedType = selectedStaffType;
    });
    String _type = _selectedType.name;
    if (_selectedType.name == 'All') {
      _type = 'A';
    }
    if (_selectedType.name == 'All Parents') {
      _type = 'P';
    }
    if (_selectedType.name == 'Staff') {
      _type = 'S';
    }
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("recever_type", _type);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    return Scaffold(
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
                    title: DropdownButtonFormField(
                      value: _selectedType,
                      items: _dropdownSMSItems,
                      onChanged: onChangeDropdownItem,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: 'SMS Text'),
                      validator: (val) =>
                          val.length < 1 ? 'Enter SMS Text' : null,
                      onSaved: (val) => _SMSContent = val,
                      obscureText: false,
                      controller: _controllerPassword,
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
                          Text("Sending message...")
                        ],
                      ),
                    );
                    _scaffoldKey.currentState.showSnackBar(snackbar);

                    setState(() => this._status = 'loading');

                    _auth
                        .sendSMS(
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
                              'Incorrect UserName or Password',
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
