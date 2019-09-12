import 'package:flutter/material.dart';
import 'package:login/fragments/events_holidays.dart';
import 'package:login/fragments/task_reminder.dart';

import 'fragments/attendance.dart';
import 'fragments/leaves.dart';
import 'fragments/sms_Email.dart';

class MyHomePage extends StatefulWidget {
  static String tag = 'home-page';
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(''),
      ),
      drawer: new Drawer(
          child: new ListView(
        children: <Widget>[
          new Container(child: new DrawerHeader(child: new CircleAvatar()),color: Colors.tealAccent,),
         /* new DrawerHeader(
            child: new Text('Header'),
          ),*/
          new ListTile(
            title: new Text('Home'),
            onTap: () {},
          ),
          new ListTile(
            title: new Text('Student'),
            onTap: () {},
          ),
          new ListTile(
            title: new Text('Staff'),
            onTap: () {},
          ),
          new ListTile(
            title: new Text('Attendance'),
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new TabBarViewPage("attendanceFragment"))),
          ),
          new ListTile(
            title: new Text('SMS/Email'),
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new TabBarSMSAndEmailViewPage("sms_Email"))),
          ),
          new ListTile(
            title: new Text('Leaves'),
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new TabBarLeaveViewPage("leavesFrgment"))),
          ),
          new ListTile(
            title: new Text('Assignment'),
            onTap: () {},
          ),
          new ListTile(
            title: new Text('Task&Reminder'),
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new TaskReminder("task_reminder"))),
          ),
          new ListTile(
            title: new Text('Events&Holidays'),
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new EventsHolidays("Events"))),
          ),
          new Divider(),
          new ListTile(
            title: new Text('Contact US'),
            onTap: () {},
          ),
          new ListTile(
            title: new Text('Sync Web Data'),
            onTap: () {},
          ),
          new ListTile(
            title: new Text('Change Password'),
            onTap: () {},
          ),
          new ListTile(
            title: new Text('LogOut'),
            onTap: () {},
          ),
        ],
      )),
      body: new Center(
        child: new Text(
          'Wel-Come',
        ),
      ),
    );
  }
}
