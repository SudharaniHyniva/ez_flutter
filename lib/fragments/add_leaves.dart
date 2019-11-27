import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:login/models/models/auth.dart';
import 'package:login/utils/popUp.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddLeaves extends StatefulWidget {
  @override
  _AddLeaves createState() => _AddLeaves();
}

class LeaveType {
  String name;
  LeaveType(this.name);
  static List<LeaveType> getLeaves() {
    return <LeaveType>[
      LeaveType('-Select-'),
      LeaveType('Casual Leave'),
      LeaveType('Sick Leave'),
      LeaveType('Earned Leave'),
    ];
  }
}

class _AddLeaves extends State<AddLeaves> with SingleTickerProviderStateMixin {
  TextEditingController _controllerUsername;
  bool isSwitched = false;
   DateTime selectedStartDate = DateTime.now();
   DateTime selectedEndDate = DateTime.now();
    String _count;
  String _status = 'no-action';
  String _descreption;
  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<LeaveType> _leaveList = LeaveType.getLeaves();
  List<DropdownMenuItem<LeaveType>> _dropdownLeaveItems;
  LeaveType _selectedLeaves;

  @override
  void initState() {
    _dropdownLeaveItems = buildDropdownMenuItems(_leaveList);
    _selectedLeaves = _dropdownLeaveItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<LeaveType>> buildDropdownMenuItems(List staff) {
    List<DropdownMenuItem<LeaveType>> items = List();
    for (LeaveType LeaveTyp in staff) {
      items.add(
        DropdownMenuItem(
          value: LeaveTyp,
          child: Text(
            LeaveTyp.name,
            style: new TextStyle(
              fontSize: 23.0,
              color: Colors.lightBlue,
            ),
          ),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(LeaveType selectedStaffType) {
    setState(() {
      _selectedLeaves = selectedStaffType;
    });
    String _leaveType = _selectedLeaves.name;
    if (_selectedLeaves.name == 'Casual Leave') {
      _leaveType = 'CL';
    }
    if (_selectedLeaves.name == 'Sick Leave') {
      _leaveType = 'SL';
    }
    if (_selectedLeaves.name == 'Earned Leave') {
      _leaveType = 'EL';
    }
    print(_leaveType);
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("leave_type", _leaveType);
    });
  }

  //CheckBoxes and RadioButtons
  final format = DateFormat("yyyy-MM-dd");



  @override
  Widget build(BuildContext context) {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Apply Leave'),
      ),
      //key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Select Leave Type',
                      style: new TextStyle(fontSize: 13.0, color: Colors.black),
                    ),
                    subtitle: Container(
                      child: DropdownButtonFormField(
                        value: _selectedLeaves,
                        items: _dropdownLeaveItems,
                        onChanged: onChangeDropdownItem,
                      ),
                    ),
                  ),
                  ListTile(
                    title: DateTimeField(
                      decoration: InputDecoration(
                        hintText: 'Select Start Date',
                        prefixIcon: Icon(
                          Icons.event,
                          color: Colors.pink,
                          size: 30.0,
                        ),
                      ),
                      format: format,
                      onShowPicker: (context, currentValue1) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue1 ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                      onChanged: (starDates){
                        setState(()=> selectedStartDate = starDates);
                           print(selectedStartDate);
                      },
                    ),
                    subtitle: DateTimeField(
                      decoration: InputDecoration(
                        hintText: 'Select End Date',
                        prefixIcon: Icon(
                          Icons.event,
                          color: Colors.pink,
                          size: 30.0,
                        ),
                      ),
                      format: format,
                      onShowPicker: (context, currentValue2) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue2 ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                      onChanged: (endDates){
                        setState(()=> selectedEndDate = endDates);
                      },
                    ),
                  ),

                  /*ListTile(
                    title: CheckboxListTile(
                      title: Text("Half-Day Leave"),
                        value:isSwitched,
                        onChanged: (bool value){
                          setState(() {
                            isSwitched= value;
                          });
                        },
                      controlAffinity: ListTileControlAffinity.leading,),
                  ),*/
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter descreption...',
                        suffix: Icon(
                          Icons.edit,
                          color: Colors.green,
                          size: 30.0,
                        ),
                      ),
                      validator: (val) =>
                          val.length < 1 ? 'Enter Descreption' : null,
                       onSaved: (val) => _descreption = val,
                      controller: _controllerUsername,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      autocorrect: false,
                    ),
                  ),
                ],
              ),
            ),
            NativeButton(
              color: Colors.lightBlue,
              child: Text(
                'Apply',
                style: new TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              onPressed: () {
                final form = formKey.currentState;
                if (form.validate()) {
                  form.save();
                  final snackbar = SnackBar(
                    duration: Duration(seconds: 30),
                    content: Row(
                      children: <Widget>[
                        NativeLoadingIndicator(),
                        Text("Applying...")
                      ],
                    ),
                  );
                  _scaffoldKey.currentState.showSnackBar(snackbar);

                  setState(() => this._status = 'loading');

                  _auth
                      .applyLeave(
                           leaveDescreption: _descreption.toString().trim(),
                           startDate: selectedStartDate.toString().trim(),
                           lastDate: selectedEndDate.toString().trim(),

                          )
                      .then((result) {
                    try {
                      if (result) {
                        Navigator.of(context).pushReplacementNamed('/home');
                      } else {
                        setState(() => this._status = 'rejected');
                        showAlertPopup(context, 'Unable to apply leave',
                            _auth.errorMessage);
                      }

                      _scaffoldKey.currentState.hideCurrentSnackBar();
                    } catch (e) {
                      print('Error with URL: $e');
                    }
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
