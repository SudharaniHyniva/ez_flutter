import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
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

  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: "f2e25125db9926be9731678f5c5f05e4804a85d8",
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json"
  };
  Future<List<ClassNameAndSection>> _fetchUsers() async {
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
     // print(json.decode(response.body)['classNameVOs']);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Student'),
      ),
      body: Center(
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
                      setState(() {
                       // _currentUser = value;
                      });
                    },
                    isExpanded: false,
                    //value: _currentUser,
                    hint: Text('Select Class'),
                  );
                }),
            SizedBox(height: 0.0),
             /*_currentUser != null
                ? Text("Name: " +
                _currentUser.classNameAndSection)
                : Text("No Classes found"),*/
          ],
        ),
      ),
    );
  }

}