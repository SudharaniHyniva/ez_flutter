import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/classes/students.dart';
import 'package:login/classes/users.dart';
import 'package:login/utils/webConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentAttendance extends StatefulWidget {
  _StudentAttendance createState() => _StudentAttendance();
}

class _StudentAttendance extends State<StudentAttendance> {
  int _currentUser;
   String _selectedClass;
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
      //  print(_currentUser);
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
                      onChanged: (ClassNameAndSection value) {
                        setState(() {
                          _currentUser = value.studyClassId;
                          _selectedClass = value.classNameAndSection;
                        });
                        return ListView();
                      },

                      //value: _selectedClass,
                      isExpanded: false,
                    );
                  }),
            ),
            SizedBox(height: 0.0),
            _selectedClass != null
                ? Text("Selected Class: "+_selectedClass,style: new TextStyle(
              fontSize: 20.0,
              color: Colors.red
            ),)
                : Text("Please select the class",style: new TextStyle(
              fontSize: 20.0,
              color: Colors.red
            ),),
            Container(
              height: 500.0,
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
                    ))
                        .toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
