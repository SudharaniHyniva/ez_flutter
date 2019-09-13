import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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

Material myItems(IconData icon, String heading, int color) {
  return Material(
    color: Colors.white,
    elevation: 10.0,
    shadowColor: Colors.black,
    borderRadius: BorderRadius.circular(20.0),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //text
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      heading,
                      style: TextStyle(
                        color: new Color(color),
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                // Icon
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      color: new Color(color),
                      borderRadius: BorderRadius.circular(24.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(
                          icon,
                          color: Colors.white,
                          size: 40.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          //centerTitle: true,
          //title: new Text('Dashboard'),
          ),
      drawer: new Drawer(
          child: new ListView(
        children: <Widget>[
          new Container(
            child: new DrawerHeader(child: new CircleAvatar()),
            color: Colors.tealAccent,
          ),
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
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) =>
                    new TabBarViewPage("attendanceFragment"))),
          ),
          new ListTile(
            title: new Text('SMS/Email'),
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) =>
                    new TabBarSMSAndEmailViewPage("sms_Email"))),
          ),
          new ListTile(
            title: new Text('Leaves'),
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) =>
                    new TabBarLeaveViewPage("leavesFrgment"))),
          ),
          new ListTile(
            title: new Text('Assignment'),
            onTap: () {},
          ),
          new ListTile(
            title: new Text('Task&Reminder'),
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) =>
                    new TaskReminder("task_reminder"))),
          ),
          new ListTile(
            title: new Text('Events&Holidays'),
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) =>
                    new EventsHolidays("Events"))),
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
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          myItems(Icons.people, "Students", 0xffff9800),
          myItems(Icons.people, "Staff", 0xffff5722),
          myItems(Icons.email, "SMS & Email", 0xff3399fe),
          myItems(Icons.notifications, "Attendance", 0xffe91E63),
          myItems(Icons.event, "Events", 0xff622F74),
          myItems(Icons.drafts, "Leaves", 0xff26cb3c),
        ],
        staggeredTiles: [
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
        ],
      ),
    );
  }
}
