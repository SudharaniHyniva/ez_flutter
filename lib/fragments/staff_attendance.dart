import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/classes/staff.dart';

class StaffAttendance extends StatefulWidget {
  _StaffAttendance createState() => _StaffAttendance();
}

class _StaffAttendance extends State<StaffAttendance> {

  bool _isChecked = true;
  bool isSwitched = true;
  String _currText = 'user';

  final String uri = 'https://eazyschool.in/api/staffDetails/319398/A';
  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: "f2e25125db9926be9731678f5c5f05e4804a85d8",
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json"
  };
  Future<List<staffPersonAccountDetailsVOS>> _fetchUsers() async {
    var response = await http.get(uri, headers: headers);
    print(uri);

    if (response.statusCode == 200) {
      final items = json.decode(response.body)['staffPersonAccountDetailsVOS'].cast<Map<String, dynamic>>();
      print(items);
      List<staffPersonAccountDetailsVOS> listOfUsers = items.map<staffPersonAccountDetailsVOS>((items) {
        return staffPersonAccountDetailsVOS.fromJson(items);
      }).toList();
      return listOfUsers;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: 550.0,
              child: FutureBuilder<List<staffPersonAccountDetailsVOS>>(
                future: _fetchUsers(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                  print(snapshot.data);
                  return new ListView(
                    shrinkWrap: true,
                    children: snapshot.data
                        .map((user) => CheckboxListTile(
                      title: ListTile(
                        title: Text(user.firstName+" "+user.lastName),
                        subtitle: Text(user.roleName+" "+user.mobileNumber),
                        leading: CircleAvatar(
                          radius: 30.0,
                          backgroundImage:
                          NetworkImage(user.imageUrl, scale: 1.0),
                          backgroundColor: Colors.red,
                        ),
                      ),
                      value: _isChecked,
                      onChanged: (val){
                        setState(() {
                          _isChecked= val;
                        });
                      },

                      /*value: isSwitched,
                      onChanged: (bool val){
                        setState(() {
                          isSwitched = val;
                          if (val==true){
                            _currText = isSwitched.toString();
                          }
                        });
                      },*/
                    )

                    )
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
