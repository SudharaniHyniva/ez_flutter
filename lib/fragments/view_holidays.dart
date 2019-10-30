import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login/classes/Holidays.dart';

class ViewHoliDays extends StatefulWidget {
  @override
  createState() => _ViewHoliDays();
}

class _ViewHoliDays extends State<ViewHoliDays> {
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  //Getting the List of tasks
  final String uri = 'https://eazyschool.in/api/holidays/716';
  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: "f2e25125db9926be9731678f5c5f05e4804a85d8",
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  Future<List<SchoolHolidaysVOList>> _fetchUsers() async {
    var response = await http.get(uri, headers: headers);
    print(uri);
    if (response.statusCode == 200) {
      final items = json.decode(response.body)['schoolHolidaysVOList'].cast<Map<String, dynamic>>();
      print(items);
      List<SchoolHolidaysVOList> listOfUsers = items.map<SchoolHolidaysVOList>((items) {
        return SchoolHolidaysVOList.fromJson(items);
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
          child: FutureBuilder<List<SchoolHolidaysVOList>>(
            future: _fetchUsers(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
              print(snapshot.data);
              return ListView(
                shrinkWrap: true,
                children: snapshot.data
                    .map((user) => ListTile(
                  leading: Icon(Icons.calendar_today, size: 50,color: Colors.blue,),
                  title: Text(user.holidayDescription,
                  style: new TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                  ),),
                  subtitle: Text("Starts from :- "+user.startDate + "\n"
                      + "Ends On :-      "+user.endDate+"\n"+
                      "Number Of Days:-"+user.noOfDays.toInt().toString(),
                  style: new TextStyle(
                    fontSize: 20.0,
                    fontStyle: FontStyle.normal,
                  ),
                  ),
                )).toList(),
              );
            },
          ),
        ));
  }
}