import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login/classes/Events.dart';
import 'package:login/utils/webConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewStudentLeaves extends StatefulWidget {
  @override
  createState() => _ViewEvents();
}

class _ViewEvents extends State<ViewStudentLeaves> {
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  //Getting the List of tasks
  //final String uri = 'https://eazyschool.in/api/event/319398/A';
  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: "f2e25125db9926be9731678f5c5f05e4804a85d8",
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  Future<List<EventsVoList>> _fetchUsers() async {
    SharedPreferences _accountId = await SharedPreferences.getInstance();
    var id = _accountId.getString("saved_accountId") ?? "";
    var response = await http.get(apiURL+"/api/event/"+id+"/A", headers: headers);
    if (response.statusCode == 200) {
      final items = json.decode(response.body)['eventsVoList'].cast<Map<String, dynamic>>();
      print(items);
      List<EventsVoList> listOfUsers = items.map<EventsVoList>((items) {
        return EventsVoList.fromJson(items);
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
          child: FutureBuilder<List<EventsVoList>>(
            future: _fetchUsers(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
              print(snapshot.data);
              return ListView(
                shrinkWrap: true,
                children: snapshot.data
                    .map((user) => ListTile(
                  leading: Icon(Icons.event, size: 50,color: Colors.blue,),
                  title: Text(user.eventName,
                      style: new TextStyle(
                        fontSize: 25.0,
                        color: Colors.black,
                      )),
                  subtitle: Text("Start Date:- "+user.startDateTime+"\n"+
                      "End Date:- "+user.endDateTime+"\n"
                      +"Descreption:-"+"\n",
                    style: new TextStyle(
                      fontSize: 20.0,
                      fontStyle: FontStyle.normal,
                    ),),
                )).toList(),
              );
            },
          ),
        ));
  }
}