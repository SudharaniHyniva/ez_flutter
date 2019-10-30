import 'dart:convert';
import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:login/classes/staff.dart';
import 'package:login/utils/webConfig.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class AddReminder extends StatefulWidget {
  @override
  _AddReminder createState() => _AddReminder();
}


class _AddReminder extends State<AddReminder>
    with SingleTickerProviderStateMixin {

  //CheckBoxes and RadioButtons
  final format = DateFormat("yyyy-MM-dd");
  String _picked = "Every Days";
  List<String> _checked = ["SMS"];

  //Getting Staff List in Dropdown
  staffPersonAccountDetailsVOS _currentUser;
  final String uri = 'https://eazyschool.in/api/staffDetails/319398/A';
  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: "f2e25125db9926be9731678f5c5f05e4804a85d8",
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  Future<List<staffPersonAccountDetailsVOS>> _fetchUsers() async {
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final items = json.decode(response.body)['staffPersonAccountDetailsVOS'].cast<Map<String, dynamic>>();
      print(items);
      List<staffPersonAccountDetailsVOS> listOfUsers = items.map<staffPersonAccountDetailsVOS>((items) {
        return staffPersonAccountDetailsVOS.fromJson(items);
      }).toList();
      return listOfUsers;
    } else {
      throw Exception('Failed to load internet');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Task'),
      ),
      //key: _scaffoldKey,
      body: SafeArea(
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          key: PageStorageKey("Divider 1"),
          children: <Widget>[
            Form(
              //key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: 'Task'),
                      validator: (val) =>
                      val.length < 1 ? 'Enter User Name' : null,
                      //onSaved: (val) => _username = val,
                      //obscureText: false,
                      keyboardType: TextInputType.text,
                      //controller: _controllerUsername,
                      // autocorrect: false,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: 'Description'),
                      validator: (val) =>
                      val.length < 1 ? 'Enter Password' : null,
                      // onSaved: (val) => _password = val,
                      obscureText: true,
                      //controller: _controllerPassword,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                    ),
                  ),
                  ListTile(
                    title:DateTimeField(
                      decoration: InputDecoration(labelText: 'Completion Date'),
                      format: format,
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                    ),
                  ),
                  ListTile(
                    title:Text('Reminder Type') ,
                    subtitle: RadioButtonGroup(
                      //orientation: GroupedButtonsOrientation.HORIZONTAL,
                      margin: const EdgeInsets.only(left: 10.0),
                      onSelected: (String selected) => setState((){
                        _picked = selected;
                      }),
                      labels: [
                        "Every Days",
                        "Specific Day",
                      ],
                      picked: _picked,
                    ),
                  ),
                  ListTile(
                    title:Text('Communication Type') ,
                    subtitle: CheckboxGroup(
                      //orientation: GroupedButtonsOrientation.HORIZONTAL,
                      margin: const EdgeInsets.only(left: 10.0),
                      onSelected: (List selected) => setState((){
                        _checked = selected;
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
                              AsyncSnapshot<List<staffPersonAccountDetailsVOS>> snapshot) {
                            if (!snapshot.hasData) return CircularProgressIndicator();
                            return DropdownButton<staffPersonAccountDetailsVOS>(
                              hint: Text('Select Staff'),
                              items: snapshot.data
                                  .map((user) => DropdownMenuItem<staffPersonAccountDetailsVOS>(
                                child: Text(user.firstName),
                                value: user,
                              ))
                                  .toList(),
                              onChanged: (staffPersonAccountDetailsVOS value) {
                                setState(() {
                                  _currentUser= value;
                                });
                                //return ListView();

                              },
                              isExpanded: true,
                              //value: _currentUser,

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
                  textScaleFactor: textScaleFactor,
                ),
                onPressed: () {

                }
            ),
          ],
        ),
      ),
    );
  }
}