import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:login/classes/students.dart';
import 'package:login/classes/users.dart';
import 'package:login/utils/webConfig.dart';

class Student extends StatefulWidget {
  Student(String s);
  @override
  StudentClassList createState() {
    return new StudentClassList();
  }
}
class StudentClassList extends State<Student>{
  ClassNameAndSection _currentUser;

  final String url = 'https://eazyschool.in//api/class/319398/A';
  final String url1 = 'https://eazyschool.in/api/studentsDetails/319398/A';


  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: "f2e25125db9926be9731678f5c5f05e4804a85d8",
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json"
  };
  Future<List<ClassNameAndSection>> _fetchUsers() async {
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final items = json.decode(response.body)['classNameVOs'].cast<Map<String, dynamic>>();
  List<ClassNameAndSection> classList= new List<ClassNameAndSection>();
      List<classNameVOs> listOfUsers = items.map<classNameVOs>((items) {
        var _item=classNameVOs.fromJson(items);
            for(var i = 0; i < _item.studyClassList.length; i++){
              ClassNameAndSection cls=new ClassNameAndSection();
              var sections=_item.className +"  " + _item.studyClassList[i].section;
              cls.classNameAndSection=sections;
              classList.add(cls);
        }
        print(classList.length);
        return classNameVOs.fromJson(items);
      }).toList();
      return classList;
    }
    else {
      throw Exception('Failed to load internet');
    }
  }

  Future<List<viewStudentPersonAccountDetailsVOs>> _fetchUsers1() async {
    var response = await http.get(url1, headers: headers);
    if (response.statusCode == 200) {
      final items = json.decode(response.body)['viewStudentPersonAccountDetailsVOs'].cast<Map<String, dynamic>>();
      List<viewStudentPersonAccountDetailsVOs> listOfUsers = items.map<viewStudentPersonAccountDetailsVOs>((items) {
        return viewStudentPersonAccountDetailsVOs.fromJson(items);
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
        title: Text('Student'),
      ),
      body:SingleChildScrollView(
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

                        });
                       // return ListView();

                      },
                      isExpanded: true,
                      //value: _currentUser,
                     // hint: Text('Select Class'),
                    );
                  }),
            ),
            Container(
              height: 600.0,
              child: FutureBuilder<List<viewStudentPersonAccountDetailsVOs>>(
                future: _fetchUsers1(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

                  return ListView(
                    children: snapshot.data
                        .map((user) => ListTile(
                      title: Text(user.firstName+" "+user.lastName),
                      subtitle: Text(user.mobileNumber),
                      leading: CircleAvatar(
                        radius: 30.0,
                        backgroundImage:
                        NetworkImage(user.imageUrl, scale: 1.0 ),
                        backgroundColor: Colors.red,
                      ),
                      /*leading: CircleAvatar(
                backgroundColor: Colors.red,
                child: Text(user.imageUrl,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    )),
              ),*/
                    ))
                        .toList(),
                  );
                },
              ),
            )
          ],
        ),
      ),
























     /* Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FutureBuilder<List<ClassNameAndSection>>(
                future: _fetchUsers(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ClassNameAndSection>> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return DropdownButton<ClassNameAndSection>(
                    items: snapshot.data
                        .map((user) => DropdownMenuItem<ClassNameAndSection>(
                      child: Text(user.classNameAndSection),
                      value: user,
                    ))
                        .toList(),
                    onChanged: (ClassNameAndSection value) {
                      return ListView();
                      *//*setState(() {

                      });*//*
                    },
                    isExpanded: true,
                    //value: _currentUser,
                    hint: Text('Select Class'),
                  );
                }),
            SizedBox(height: 0.0),
             *//*_currentUser != null
                ? Text("Name: " +
                _currentUser.classNameAndSection)
                : Text("No Classes found"),*//*
          ],
        ),
      ),*/
    );
  }

}