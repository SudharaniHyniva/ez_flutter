import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login/classes/Leaves.dart';
import 'package:login/fragments/add_leaves.dart';
import 'package:login/models/models/auth.dart';
import 'package:login/utils/popUp.dart';
import 'package:login/utils/webConfig.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLeaves extends StatefulWidget {
  @override
  createState() => _ViewEvents();
}

class _ViewEvents extends State<MyLeaves> {
  String _status = 'no-action';

  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //Getting the List of tasks
  //final String uri = 'https://eazyschool.in//api/leaves/319398/A';
  Map<String, String> headers = {
    HttpHeaders.authorizationHeader: "f2e25125db9926be9731678f5c5f05e4804a85d8",
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json"
  };
  Future<List<LeavesList>> _fetchUsers() async {
    SharedPreferences _accountId = await SharedPreferences.getInstance();
    var id = _accountId.getString("saved_accountId") ?? "";
    var response = await http.get(apiURL+"/api/leaves/"+id+"/A", headers: headers);
    if (response.statusCode == 200) {
      final items =
          json.decode(response.body)['leavesList'].cast<Map<String, dynamic>>();
      List<LeavesList> list = new List<LeavesList>();
      items.map<LeavesList>((items) {
        LeavesList accountDetailsVOs = LeavesList.fromJson(items);
        // ignore: unrelated_type_equality_checks
        if (accountDetailsVOs.accountId == int.parse(id)) {
          list.add(accountDetailsVOs);
        }
      }).toList();
      return list;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  @override
  Widget build(BuildContext context) {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    return new Scaffold(
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddLeaves()),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.pink,
        ),
        body: Form(
          key: formKey,
          child: FutureBuilder<List<LeavesList>>(
            future: _fetchUsers(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              print(snapshot.data);
              return ListView(
                shrinkWrap: true,
                children: snapshot.data
                    .map((user) => ListTile(
                          leading: Icon(
                            Icons.report,
                            size: 50,
                            color: Colors.blue,
                          ),
                          title: Text(user.description,
                              style: new TextStyle(
                                fontSize: 25.0,
                                color: Colors.black,
                              )),
                          subtitle: Text(
                            "From:- " +
                                user.startDate.substring(0, 10) +
                                "\n" +
                                "To:-     " +
                                user.endDate.substring(0, 10) +
                                "\n",
                            style: new TextStyle(
                              fontSize: 20.0,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new IconButton(
                                  icon: new Icon(Icons.edit),
                                  color: Colors.green,
                                  iconSize: 30.0,
                                  onPressed: () {}),
                              new IconButton(
                                  icon: new Icon(Icons.delete),
                                  color: Colors.red,
                                  iconSize: 30.0,
                                  onPressed: () {
                                    {
                                      int _leaveId = user.id;
                                      final form = formKey.currentState;
                                      if (form.validate()) {
                                        form.save();
                                        final snackbar = SnackBar(
                                          duration: Duration(seconds: 30),
                                          content: Row(
                                            children: <Widget>[
                                              NativeLoadingIndicator(),
                                              Text("  Logging In...")
                                            ],
                                          ),
                                        );
                                        _scaffoldKey.currentState
                                            .showSnackBar(snackbar);

                                        setState(
                                            () => this._status = 'loading');

                                        _auth
                                            .deleteLeave(
                                          leaveId: _leaveId.toString().trim(),
                                        )
                                            .then((result) {
                                          try {
                                            if (result) {
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      '/home');
                                              Scaffold.of(context).showSnackBar(
                                                new SnackBar(
                                                  content: new Text(
                                                      'You have deleted leave successfully!'),
                                                ),
                                              );
                                            } else {
                                              setState(() =>
                                                  this._status = 'rejected');
                                              showAlertPopup(
                                                  context,
                                                  'Unable to delete leave',
                                                  _auth.errorMessage);
                                            }

                                            _scaffoldKey.currentState
                                                .hideCurrentSnackBar();
                                          } catch (e) {
                                            print('Error with URL: $e');
                                          }
                                        });
                                      }
                                    }
                                  }),
                            ],
                          ),
                        ))
                    .toList(),
              );
            },
          ),
        ));
  }
}
