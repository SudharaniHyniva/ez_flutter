import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login/classes/studyClass.dart';
import 'package:http/http.dart' as http;

class Staff extends StatefulWidget {
  Staff(String s);
  @override
  StudentClassList createState() {
    return new StudentClassList();
  }
}
class StudentClassList extends State<Staff>{
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
    } else {
      throw Exception('Failed to load internet');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Staff'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //mainAxisSize: MainAxisSize.max,
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
/*

import 'package:flutter/material.dart';

class Staff extends StatefulWidget {
  Staff() : super();

  final String title = "DropDown Demo";

  @override
  DropDownState createState() => DropDownState();
}

class Company {
  int id;
  String name;

  Company(this.id, this.name);

  static List<Company> getCompanies() {
    return <Company>[
      Company(1, 'Apple'),
      Company(2, 'Google'),
      Company(3, 'Samsung'),
      Company(4, 'Sony'),
      Company(5, 'LG'),
    ];
  }
}

class DropDownState extends State<Staff> {
  //
  List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItems;
  Company _selectedCompany;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Staff"),
        ),
        body: new Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Select Staff"),
                SizedBox(
                  height: 10.0,
                ),
                DropdownButton(
                  value: _selectedCompany,
                  items: _dropdownMenuItems,
                  onChanged: onChangeDropdownItem,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text('Selected: ${_selectedCompany.name}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/
