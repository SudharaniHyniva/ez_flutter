import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login/classes/users.dart';
import 'package:login/models/models/auth.dart';
import 'package:login/services/call_and_message_service.dart';
import 'package:login/services/service_locator.dart';
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
  String _otherNumbers;
  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _controllerNumber, _controllerText;
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

  String _currentClass;
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  int _currentUser;
  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: "f2e25125db9926be9731678f5c5f05e4804a85d8",
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json"
  };
  Future<List<ClassNameAndSection>> _fetchUsers() async {
    SharedPreferences _accountId = await SharedPreferences.getInstance();
    var id = _accountId.getString("saved_accountId") ?? "";

    var response =
        await http.get(apiURL + "/api/class/" + id + "/A", headers: headers);
    if (response.statusCode == 200) {
      final items = json
          .decode(response.body)['classNameVOs']
          .cast<Map<String, dynamic>>();
      List<ClassNameAndSection> classList = new List<ClassNameAndSection>();
      items.map<classNameVOs>((items) {
        var _item = classNameVOs.fromJson(items);
        for (var i = 0; i < _item.studyClassList.length; i++) {
          ClassNameAndSection cls = new ClassNameAndSection();
          var sections =
              _item.className + " " + _item.studyClassList[i].section;
          cls.classNameAndSection = sections;
          cls.studyClassId = _item.studyClassList[i].id;
          classList.add(cls);
        }
        print(classList.length);
        return classNameVOs.fromJson(items);
      }).toList();
      return classList;
    } else {
      throw Exception('Failed to load internet');
    }
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
                  if (_selectedType.name == 'Class & section')
                    ListTile(
                      title: FutureBuilder<List<ClassNameAndSection>>(
                          future: _fetchUsers(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<ClassNameAndSection>>
                                  snapshot) {
                            if (!snapshot.hasData)
                              return CircularProgressIndicator();
                            return DropdownButton<ClassNameAndSection>(
                              hint: new Text('Select Class'),
                              items: snapshot.data
                                  .map((user) =>
                                      DropdownMenuItem<ClassNameAndSection>(
                                        child: Text(user.classNameAndSection),
                                        value: user,
                                      ))
                                  .toList(),
                              onChanged: (ClassNameAndSection values) {
                                setState(() {
                                  _currentClass = values.classNameAndSection;
                                  _currentUser = values.studyClassId;
                                });
                              },
                              isExpanded: true,
                            );
                          }),
                    ),
                  if (_selectedType.name == 'Others')
                    ListTile(
                      title: TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Enter mobile number..'),
                        validator: (val) =>
                            val.length < 1 ? 'Enter mobile number' : null,
                        onSaved: (val) => _otherNumbers = val,
                        controller: _controllerNumber,
                        keyboardType: TextInputType.number,
                        autocorrect: false,
                      ),
                    ),
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: 'SMS Text'),
                      validator: (val) =>
                          val.length < 1 ? 'Enter SMS Text' : null,
                      onSaved: (val) => _SMSContent = val,
                      obscureText: false,
                      controller: _controllerText,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
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
                            classId: _currentUser.toString(),
                            otherNo: _otherNumbers)
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
