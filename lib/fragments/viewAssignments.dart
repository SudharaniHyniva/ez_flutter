import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:login/classes/Assignment.dart';
import 'package:login/classes/students.dart';
import 'package:login/classes/users.dart';
import 'package:login/const/eaz_api.dart';
import 'package:login/fragments/add_assignments.dart';
import 'package:login/utils/webConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewAssignments extends StatefulWidget {
  @override
  StudentClassList createState() {
    return new StudentClassList();
  }
}

class StudentClassList extends State<ViewAssignments> {
  int _currentUser;
  String _currentClass;
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

  Future<List<ClassAssignmentsVO>> _fetchUsers1() async {
    SharedPreferences _accountId = await SharedPreferences.getInstance();
    var classId = _accountId.getString("saved_classId") ?? "";
    var response =
        await http.get(apiURL + classAssignment + classId, headers: headers);
    if (response.statusCode == 200) {
      final items = json
          .decode(response.body)['classAssignmentVO']
          .cast<Map<String, dynamic>>();
      List<ClassAssignmentsVO> listOfUsers =
          items.map<ClassAssignmentsVO>((items) {
        return ClassAssignmentsVO.fromJson(items);
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
        title: Text('Assignments'),
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: () {Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddAssignments()),
        );},
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
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
                      onChanged: (ClassNameAndSection value) {
                        setState(() {
                          _currentClass = value.classNameAndSection;
                          _currentUser = value.studyClassId;

                          SharedPreferences.getInstance().then((prefs) {
                            prefs.setString(
                                "saved_classId", _currentUser.toString());
                          });
                        });
                        return ListView();
                      },
                      isExpanded: false,
                    );
                  }),
            ),
            _currentClass != null
                ? Text(
              "Selected Class: " + _currentClass,
              style: new TextStyle(fontSize: 20.0, color: Colors.red),
            )
                : Text(
              "Please select the class",
              style: new TextStyle(fontSize: 20.0, color: Colors.red),
            ),
            Container(
              height: 550.0,
              child: FutureBuilder<List<ClassAssignmentsVO>>(
                future: _fetchUsers1(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Stack(
                      children: <Widget>[
                   /* Center(child: new Text("There are no assignment in selected class",
                      style: new TextStyle(
                          fontSize: 20.0,
                          color: Colors.red
                      ),))*/
                      ],
                    );
                  return ListView(
                    children: snapshot.data
                        .map((user) => ListTile(
                              title: Text(
                                user.subjectName,
                                style: new TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                              subtitle: Text(
                                user.description +
                                    "\n" +
                                    "Last date of submission :- " +
                                    user.date,
                                style: new TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                              leading: Icon(
                                Icons.assignment,
                                size: 25,
                                color: Colors.blue,
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
