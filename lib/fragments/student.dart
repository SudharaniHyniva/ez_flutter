import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login/classes/studyClass.dart';
import 'package:http/http.dart' as http;

class Student extends StatefulWidget {
  Student(String s);
  @override
  StudentClassList createState() {
    return new StudentClassList();
  }
}
class StudentClassList extends State<Student>{
  StudyClass _currentUser;

  final String uri = 'https://eazyschool.in//api/class';

  Future<List<StudyClass>> _fetchUsers() async {
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<StudyClass> listOfUsers = items.map<StudyClass>((json) {
        return StudyClass.fromJson(json);
      }).toList();

      return listOfUsers;
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
            FutureBuilder<List<StudyClass>>(
                future: _fetchUsers(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<StudyClass>> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return DropdownButton<StudyClass>(
                    items: snapshot.data
                        .map((user) => DropdownMenuItem<StudyClass>(
                      child: Text(user.className+""+user.noOfSection),
                      value: user,
                    ))
                        .toList(),
                    onChanged: (StudyClass value) {
                      setState(() {
                        _currentUser = value;
                      });
                    },
                    isExpanded: false,
                    //value: _currentUser,
                    hint: Text('Select User'),
                  );
                }),
            SizedBox(height: 20.0),
           _currentUser != null
                ? Text("Name: " +
                _currentUser.className +
                "\n Email: " +
                _currentUser.noOfSection +
                "\n Username: " +
                _currentUser.sortingOrder)
                : Text("No Classes found"),
          ],
        ),
      ),
    );
  }

}