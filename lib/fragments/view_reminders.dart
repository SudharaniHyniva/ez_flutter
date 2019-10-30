import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login/classes/ViewReminder.dart';

class ViewReminders extends StatefulWidget {
  @override
  createState() => _ViewRemindersState();
}

class _ViewRemindersState extends State<ViewReminders> {
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  //Getting the List of tasks
  final String uri = 'https://eazyschool.in/api/reminderdetails/319398';
  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: "f2e25125db9926be9731678f5c5f05e4804a85d8",
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  Future<List<Reminders>> _fetchUsers() async {
    var response = await http.get(uri, headers: headers);
    print(uri);
    if (response.statusCode == 200) {
      final items = json.decode(response.body)['reminders'].cast<Map<String, dynamic>>();
      print(items);
      List<Reminders> listOfUsers = items.map<Reminders>((items) {
        return Reminders.fromJson(items);
      }).toList();
      return listOfUsers;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body:Container(

          height: 600.0,
          child: FutureBuilder<List<Reminders>>(
            future: _fetchUsers(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Center(child: Text("Currently there are no reminders are added."));
              print(snapshot.data);
              return ListView(
                shrinkWrap: true,
                children: snapshot.data
                    .map((user) => ListTile(
                  leading: Icon(Icons.insert_invitation, size: 50,color: Colors.blue),
                  title: Text("Name:- "+user.name,
                    style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),),
                  subtitle: Text("Expiration Date:- "+user.expirationDate,
                  style: new TextStyle(
                    fontSize: 15.0,
                    color: Colors.black
                  ),),
                )).toList(),
              );
            },
          ),
        )
    );
  }
}