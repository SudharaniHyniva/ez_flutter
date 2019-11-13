import 'package:flutter/material.dart';
import 'package:login/utils/webConfig.dart';
import 'package:native_widgets/native_widgets.dart';

class SendEmail extends StatefulWidget {
  _SendEmail createState() => _SendEmail();
}

class StaffType {
  String name;
  StaffType(this.name);
  static List<StaffType> getStaff() {
    return <StaffType>[
      StaffType('Select Type'),
      StaffType('All'),
      StaffType('All Parents'),
      StaffType('Staff'),
      StaffType('Class & section'),
      StaffType('Others'),
      StaffType('PTA Only')
    ];
  }
}

class _SendEmail extends State<SendEmail> {
  List<StaffType> _staffList = StaffType.getStaff();
  List<DropdownMenuItem<StaffType>> _dropdownStaffItems;
  StaffType _selectedStaff;

  @override
  void initState() {
    _dropdownStaffItems = buildDropdownMenuItems(_staffList);
    _selectedStaff = _dropdownStaffItems[0].value;
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
      _selectedStaff = selectedStaffType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ListTile(
              title: DropdownButtonFormField(
                value: _selectedStaff,
                items: _dropdownStaffItems,
                onChanged: onChangeDropdownItem,
              ),
            ),
            ListTile(
              title: TextFormField(
                decoration: InputDecoration(hintText: 'Email Subject'),
                validator: (val) =>
                    val.length < 1 ? 'Enter Email Subject' : null,
                // onSaved: (val) => _password = val,
                //obscureText: true,
                //controller: _controllerPassword,
                keyboardType: TextInputType.text,
                autocorrect: false,
              ),
            ),
            ListTile(
              title: TextFormField(
                decoration: InputDecoration(labelText: 'Email Content'),
                validator: (val) =>
                    val.length < 1 ? 'Enter Email Content' : null,
                // onSaved: (val) => _password = val,
                //obscureText: true,
                //controller: _controllerPassword,
                keyboardType: TextInputType.text,
                autocorrect: false,
              ),
            ),
            ListTile(
              title: NativeButton(
                  color: Colors.blueAccent,
                  child: Text(
                    'Send',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white),
                    textScaleFactor: textScaleFactor,
                  ),
                  onPressed: () {}),
            )
          ],
        ),
      ),
    );
  }
}
