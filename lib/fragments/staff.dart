import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/classes/staff.dart';

class Staff extends StatefulWidget {
  Staff(String s);
  _StaffListState createState() => _StaffListState();
}

class StaffType {
  String name;
  StaffType(this.name);
  static List<StaffType> getStaff() {
    return <StaffType>[
      StaffType('All'),
      StaffType('Teaching'),
      StaffType('Non-Teaching'),
      StaffType('Management'),
    ];
  }
}

class _StaffListState extends State<Staff> {
  List<StaffType> _staffList = StaffType.getStaff();
  List<DropdownMenuItem<StaffType>> _dropdownStaffItems;
  StaffType _selectedStafff;

  @override
  void initState() {
    _dropdownStaffItems = buildDropdownMenuItems(_staffList);
    _selectedStafff = _dropdownStaffItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<StaffType>> buildDropdownMenuItems(List staff) {
    List<DropdownMenuItem<StaffType>> items = List();
    for (StaffType staffType in staff) {
      items.add(
        DropdownMenuItem(
          value: staffType,
          child: Text(staffType.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(StaffType selectedStaffType) {
    setState(() {
      _selectedStafff = selectedStaffType;
    });
  }

  final String uri = 'https://eazyschool.in/api/staffDetails/319398/A';
  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: "f2e25125db9926be9731678f5c5f05e4804a85d8",
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json"
  };

  // ignore: missing_return
  Future<List<staffPersonAccountDetailsVOS>> _fetchUsers() async {
    // Getting All Staff Details
    if (_selectedStafff.name == 'All') {
      var response = await http.get(uri, headers: headers);
      print(uri);
      if (response.statusCode == 200) {
        final items = json
            .decode(response.body)['staffPersonAccountDetailsVOS']
            .cast<Map<String, dynamic>>();
        print(items);
        List<staffPersonAccountDetailsVOS> staffList =
            items.map<staffPersonAccountDetailsVOS>((items) {
          return staffPersonAccountDetailsVOS.fromJson(items);
        }).toList();
        staffList.sort((a, b) {
          return a.firstName.toLowerCase().compareTo(b.firstName.toLowerCase());
        });
        return staffList;
      } else {
        throw Exception('Failed to load internet');
      }
    }
    // Getting Teaching Staff Details
    else if (_selectedStafff.name == 'Teaching') {
      var response = await http.get(uri, headers: headers);
      print(uri);
      if (response.statusCode == 200) {
        final items = json
            .decode(response.body)['staffPersonAccountDetailsVOS']
            .cast<Map<String, dynamic>>();
        List<staffPersonAccountDetailsVOS> teachingList =
            new List<staffPersonAccountDetailsVOS>();
        items.map<staffPersonAccountDetailsVOS>((items) {
          staffPersonAccountDetailsVOS obj =
              staffPersonAccountDetailsVOS.fromJson(items);
          if (obj.roleType == 'T') {
            teachingList.add(obj);
          }
          teachingList.sort((a, b) {
            return a.firstName
                .toLowerCase()
                .compareTo(b.firstName.toLowerCase());
          });
        }).toList();
        return teachingList;
      } else {
        throw Exception('Failed to load internet');
      }
    }
    // Getting Non-Teaching Staff Details
    else if (_selectedStafff.name == 'Non-Teaching') {
      var response = await http.get(uri, headers: headers);
      print(uri);
      if (response.statusCode == 200) {
        final items = json
            .decode(response.body)['staffPersonAccountDetailsVOS']
            .cast<Map<String, dynamic>>();
        // ignore: non_constant_identifier_names
        List<staffPersonAccountDetailsVOS> NonTeachingList =
            new List<staffPersonAccountDetailsVOS>();
        items.map<staffPersonAccountDetailsVOS>((items) {
          staffPersonAccountDetailsVOS obj =
              staffPersonAccountDetailsVOS.fromJson(items);
          if (obj.roleType == 'N') {
            NonTeachingList.add(obj);
          }
          NonTeachingList.sort((a, b) {
            return a.firstName
                .toLowerCase()
                .compareTo(b.firstName.toLowerCase());
          });
        }).toList();
        return NonTeachingList;
      } else {
        throw Exception('Failed to load internet');
      }
    }
    // Getting Management Staff Details
    else if (_selectedStafff.name == 'Management') {
      var response = await http.get(uri, headers: headers);
      print(uri);
      if (response.statusCode == 200) {
        final items = json
            .decode(response.body)['staffPersonAccountDetailsVOS']
            .cast<Map<String, dynamic>>();
        // ignore: non_constant_identifier_names
        List<staffPersonAccountDetailsVOS> ManagementStaff =
            new List<staffPersonAccountDetailsVOS>();
        items.map<staffPersonAccountDetailsVOS>((items) {
          staffPersonAccountDetailsVOS obj =
              staffPersonAccountDetailsVOS.fromJson(items);
          if (obj.roleType == 'M') {
            ManagementStaff.add(obj);
          }
          ManagementStaff.sort((a, b) {
            return a.firstName
                .toLowerCase()
                .compareTo(b.firstName.toLowerCase());
          });
        }).toList();
        return ManagementStaff;
      } else {
        throw Exception('Failed to load internet');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Staff'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: DropdownButton(
                value: _selectedStafff,
                items: _dropdownStaffItems,
                onChanged: onChangeDropdownItem,
              ),
            ),
            Container(
              height: 600.0,
              child: FutureBuilder<List<staffPersonAccountDetailsVOS>>(
                future: _fetchUsers(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());
                  print(snapshot.data);
                  return ListView(
                    shrinkWrap: true,
                    children: snapshot.data
                        .map((user) => ListTile(
                              title: Text(
                                user.firstName + " " + user.lastName,
                                style: new TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                              ),
                              subtitle: Text(
                                user.roleName + " ," + user.mobileNumber,
                                style: new TextStyle(fontSize: 15.0),
                              ),
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
