import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:login/classes/students.dart';
import 'package:login/classes/users.dart';
import 'package:login/fragments/ViewStudentDetails.dart';
import 'package:login/fragments/single_sms.dart';
import 'package:login/services/call_and_message_service.dart';
import 'package:login/services/service_locator.dart';
import 'package:login/utils/webConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Student extends StatefulWidget {
  Student(String s);
  @override
  StudentClassList createState() {
    return new StudentClassList();
  }
}

class StudentClassList extends State<Student> {
  String  _currentClass;
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

    var response = await http.get(apiURL+"/api/class/"+id+"/A", headers: headers);
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

  Future<List<viewStudentPersonAccountDetailsVOs>> _fetchUsers1() async {
    SharedPreferences _accountId = await SharedPreferences.getInstance();
    var id = _accountId.getString("saved_accountId") ?? "";
    var response = await http.get(apiURL+"/api/studentsDetails/"+id+"/A", headers: headers);
    if (response.statusCode == 200) {
      final items = json
          .decode(response.body)['viewStudentPersonAccountDetailsVOs']
          .cast<Map<String, dynamic>>();
      List<viewStudentPersonAccountDetailsVOs> list =
          new List<viewStudentPersonAccountDetailsVOs>();
      items.map<viewStudentPersonAccountDetailsVOs>((items) {
        viewStudentPersonAccountDetailsVOs accountDetailsVOs =
            viewStudentPersonAccountDetailsVOs.fromJson(items);
        // ignore: unrelated_type_equality_checks
        if (accountDetailsVOs.classSectionId == _currentUser &&
            accountDetailsVOs.description == "") {
          list.add(accountDetailsVOs);
        }
        list.sort((a, b) {
          return a.firstName.toLowerCase().compareTo(b.firstName.toLowerCase());
        });
      }).toList();
      return list;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Student'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: FutureBuilder<List<ClassNameAndSection>>(
                  future: _fetchUsers(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<ClassNameAndSection>> snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();
                    return DropdownButton<ClassNameAndSection>(
                      hint: new Text('Select Class'),
                      items: snapshot.data
                          .map((user) => DropdownMenuItem<ClassNameAndSection>(
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
                      isExpanded: false,
                    );
                  }),
            ),
            SizedBox(height: 0.0),
            _currentClass != null
                ? Text("Selected Class: "+_currentClass,style: new TextStyle(
                fontSize: 20.0,
                color: Colors.red
            ),)
                : Text("Please select the class",style: new TextStyle(
                fontSize: 20.0,
                color: Colors.red
            ),),
            Container(
              height: 520.0,
              child: FutureBuilder<List<viewStudentPersonAccountDetailsVOs>>(
                future: _fetchUsers1(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  return ListView(
                    children: snapshot.data
                        .map((user) => ListTile(
                              title: Text(user.firstName + " " + user.lastName),
                              subtitle: Text(user.mobileNumber),
                              leading: CircleAvatar(
                                radius: 30.0,
                                backgroundImage:
                                    NetworkImage(user.imageUrl, scale: 1.0),
                                backgroundColor: Colors.red,
                              ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new IconButton(
                              icon: new Icon(Icons.call),
                              color: Colors.green,
                              iconSize: 30.0,
                            onPressed: () =>
                                _service.call(user.mobileNumber),),
                          new IconButton(
                              icon: new Icon(Icons.message),
                              color: Colors.orange,
                              iconSize: 30.0,
                            onPressed: ()  {
                              String _mobilenumber= user.mobileNumber;
                              print(_mobilenumber);
                              SharedPreferences.getInstance().then((prefs) {
                                prefs.setString("staff_person_number", _mobilenumber);
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SingleSMS()),
                              );}
                            /*=>
                                _service.sendSms(user.mobileNumber),*/
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewStudentDetails(
                                firstName:user.firstName,
                                lastName: user.lastName,
                                mobileNumber: user.mobileNumber,
                                image: user.imageUrl,
                            ),
                          ),
                        );
                      },
                            ))
                        .toList(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
