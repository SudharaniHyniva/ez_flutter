import 'dart:convert';
import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:login/classes/staff.dart';
import 'package:login/models/models/auth.dart';
import 'package:login/utils/popUp.dart';
import 'package:login/utils/webConfig.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTask createState() => _AddTask();
}

class _AddTask extends State<AddTask> with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _controllerTask, _controllerDescreption;
  String _taskName;
  String _taskDescreption;
  DateTime specificDay = DateTime.now();
  DateTime completionDay = DateTime.now();
  String reminderType;
  String communicationType;
  String _status = 'no-action';
  //CheckBoxes and RadioButtons
  final format = DateFormat("yyyy-MM-dd");
  String _picked = "Every Days";
  List<String> _checked = ["SMS"];
  //Getting Staff List in Dropdown
  String _selected;
  final String uri = 'https://eazyschool.in/api/staffDetails/319398/A';
  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: "f2e25125db9926be9731678f5c5f05e4804a85d8",
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  Future<List<staffPersonAccountDetailsVOS>> _fetchUsers() async {
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final items = json
          .decode(response.body)['staffPersonAccountDetailsVOS']
          .cast<Map<String, dynamic>>();
      print(items);
      List<staffPersonAccountDetailsVOS> listOfUsers =
          items.map<staffPersonAccountDetailsVOS>((items) {
        return staffPersonAccountDetailsVOS.fromJson(items);
      }).toList();
      return listOfUsers;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  @override
  Widget build(BuildContext context) {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Task'),
      ),
      key: _scaffoldKey,
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
                      decoration: InputDecoration(
                          labelText: 'Task',
                          prefixIcon: Icon(Icons.local_activity)),
                      validator: (val) =>
                          val.length < 1 ? 'Enter Task Name' : null,
                      onSaved: (val) => _taskName = val,
                      keyboardType: TextInputType.text,
                      controller: _controllerTask,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Description',
                        prefixIcon: Icon(Icons.description),
                      ),
                      validator: (val) =>
                          val.length < 1 ? 'Enter Password' : null,
                      onSaved: (val) => _taskDescreption = val,
                      controller: _controllerDescreption,
                      autocorrect: false,
                    ),
                  ),
                  ListTile(
                    title: DateTimeField(
                      decoration: InputDecoration(
                          labelText: 'Completion Date',
                          prefixIcon: Icon(Icons.calendar_today)),
                      format: format,
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                      onChanged: (lastDay) {
                        setState(() => completionDay = lastDay);
                        print(completionDay);
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Reminder Type'),
                    subtitle: RadioButtonGroup(
                      //orientation: GroupedButtonsOrientation.HORIZONTAL,
                      margin: const EdgeInsets.only(left: 10.0),
                      onSelected: (String selected) => setState(() {
                        _picked = selected;
                        if(_picked=='Every Days'){
                         reminderType='E';
                        }else if(_picked=='Specific Day'){
                          reminderType='S';
                        }
                      }),
                      labels: [
                        "Every Days",
                        "Specific Day",
                      ],
                      picked: _picked,
                    ),
                  ),
                  if (_picked == 'Specific Day')
                    ListTile(
                      title: DateTimeField(
                        decoration: InputDecoration(
                            labelText: 'Select Specific date',
                            prefixIcon: Icon(Icons.calendar_today)),
                        format: format,
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                        onChanged: (specificDaay) {
                          setState(() => specificDay = specificDaay);
                          print(specificDay);
                        },
                      ),
                    ),
                  ListTile(
                    title: Text('Communication Type'),
                    subtitle: CheckboxGroup(
                      //orientation: GroupedButtonsOrientation.HORIZONTAL,
                      margin: const EdgeInsets.only(left: 10.0),
                      onSelected: (List selected) => setState(() {
                        _checked = selected;
                        if(_checked=='SMS'){
                          communicationType='S';
                        }else if(_checked=='SMS'&& _checked=='Email'){
                          communicationType='E';
                        }
                      }),
                      labels: <String>[
                        "SMS",
                        "Email",
                      ],
                      checked: _checked,
                    ),
                  ),
                  ListTile(
                    title: Text('Assigned To'),
                    subtitle: Container(
                      child: FutureBuilder<List<staffPersonAccountDetailsVOS>>(
                          future: _fetchUsers(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<staffPersonAccountDetailsVOS>>
                                  snapshot) {
                            if (!snapshot.hasData)
                              return CircularProgressIndicator();
                            return DropdownButton<staffPersonAccountDetailsVOS>(
                              hint: Text('Select Staff'),
                              items: snapshot.data
                                  .map((user) => DropdownMenuItem<
                                          staffPersonAccountDetailsVOS>(
                                        child: Text(user.firstName),
                                        value: user,
                                      ))
                                  .toList(),
                              onChanged: (staffPersonAccountDetailsVOS value) {
                                setState(() {
                                  _selected = value.accountId.toString();
                                });
                                return ListView();
                              },
                              isExpanded: true,
                              // value: _currentUser,
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
            NativeButton(
              child: Text(
                'Submit',
                style: new TextStyle(fontSize: 20.0, color: Colors.lightBlue),
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
                        Text("Adding task...")
                      ],
                    ),
                  );
                  _scaffoldKey.currentState.showSnackBar(snackbar);

                  setState(() => this._status = 'loading');

                  _auth.AddTasks(
                    taskName: _taskName,
                    taskDescreption: _taskDescreption,
                    taskCompletionDate: completionDay.toIso8601String(),
                    taskSpecificDate: specificDay.toIso8601String(),
                    assignedTo: _selected,
                    reminderType: reminderType,
                    communicationType: communicationType
                  ).then((result) {
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
          ],
        ),
      ),
    );
  }
}
