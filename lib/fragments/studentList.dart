import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/classes/students.dart';

class StudentList extends StatefulWidget {
  StudentList(String s);
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  final String uri = 'https://eazyschool.in/api/studentsDetails/319398/A';
  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: "f2e25125db9926be9731678f5c5f05e4804a85d8",
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json"
  };
  Future<List<viewStudentPersonAccountDetailsVOs>> _fetchUsers() async {
    var response = await http.get(uri, headers: headers);

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
      body: FutureBuilder<List<viewStudentPersonAccountDetailsVOs>>(
        future: _fetchUsers(),
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
    );
  }
}

class Users {
  int id;
  String name;
  String username;
  String email;

  Users({
    this.id,
    this.name,
    this.username,
    this.email,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
    );
  }
}