import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:login/classes/AddAssignment.dart';
import 'package:login/classes/users.dart';
import 'package:login/models/models/auth.dart';
import 'package:login/utils/popUp.dart';
import 'package:login/utils/webConfig.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAssignments extends StatefulWidget {
  @override
  _AddAssignments createState() => _AddAssignments();
}

class _AddAssignments extends State<AddAssignments>
    with SingleTickerProviderStateMixin {
  TextEditingController _controllerUsername;
  bool isSwitched = false;
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  String _status = 'no-action';
  String _descreption;
  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //CheckBoxes and RadioButtons
  final format = DateFormat("yyyy-MM-dd");
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

  Future<List<SubjectName>> _fetchUsers1() async {
    SharedPreferences _accountId = await SharedPreferences.getInstance();
    var id = _accountId.getString("saved_accountId") ?? "";
    var response =
    await http.get(apiURL + "/api/class/" + id + "/A", headers: headers);
    if (response.statusCode == 200) {
      final items = json
          .decode(response.body)['studyClassList']
          .cast<Map<String, dynamic>>();
      List<SubjectName> classList = new List<SubjectName>();
      items.map<classNameVOs>((items) {
        var _item = StudySubjectList.fromJson(items);
        for (var i = 0; i < _item.name.length; i++) {
          SubjectName cls = new SubjectName();
          var sections =
              _item.name;
          //cls.classNameAndSection = sections;
          //cls.studyClassId = _item.studyClassList[i].id;
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
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Assignment'),
      ),
      //key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ListTile(
                    title: Container(
                      child: FutureBuilder<List<ClassNameAndSection>>(
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
                              onChanged: (ClassNameAndSection value) {
                                setState(() {
                                  _currentUser = value.studyClassId;
                                });
                              },
                              isExpanded: true,
                            );
                          }),
                    ),
                  ),
                  ListTile(
                    title: Container(
                      child: FutureBuilder<List<SubjectName>>(
                          future: _fetchUsers1(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<SubjectName>>
                              snapshot) {
                            if (!snapshot.hasData)
                              return CircularProgressIndicator();
                            return DropdownButton<SubjectName>(
                              hint: new Text('Select Class'),
                              items: snapshot.data
                                  .map((user) =>
                                  DropdownMenuItem<SubjectName>(
                                    child: Text(user.name),
                                    value: user,
                                  ))
                                  .toList(),
                              /*onChanged: (ClassNameAndSection value) {
                                setState(() {
                                  _currentUser = value.studyClassId;
                                });
                              },*/
                              isExpanded: true,
                            );
                          }),
                    ),
                  ),
                  ListTile(
                    title: DateTimeField(
                      decoration: InputDecoration(
                        hintText: 'Select Completion Date',
                        prefixIcon: Icon(
                          Icons.event,
                          color: Colors.pink,
                          size: 30.0,
                        ),
                      ),
                      format: format,
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                      onChanged: (starDates) {
                        setState(() => selectedStartDate = starDates);
                        print(selectedStartDate);
                      },
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter descreption...',
                        suffix: Icon(
                          Icons.edit,
                          color: Colors.green,
                          size: 30.0,
                        ),
                      ),
                      validator: (val) =>
                          val.length < 1 ? 'Enter Descreption' : null,
                      onSaved: (val) => _descreption = val,
                      controller: _controllerUsername,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                    ),
                  ),
                ],
              ),
            ),
            NativeButton(
              color: Colors.lightBlue,
              child: Text(
                'Apply',
                style: new TextStyle(fontSize: 20.0, color: Colors.white),
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
                        Text("Applying...")
                      ],
                    ),
                  );
                  _scaffoldKey.currentState.showSnackBar(snackbar);

                  setState(() => this._status = 'loading');

                  _auth
                      .applyLeave(
                    leaveDescreption: _descreption.toString().trim(),
                    startDate: selectedStartDate.toString().trim(),
                    lastDate: selectedEndDate.toString().trim(),
                  )
                      .then((result) {
                    try {
                      if (result) {
                        Navigator.of(context).pushReplacementNamed('/home');
                      } else {
                        setState(() => this._status = 'rejected');
                        showAlertPopup(context, 'Unable to apply leave',
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
          ],
        ),
      ),
    );
  }
}
