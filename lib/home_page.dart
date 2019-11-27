import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:login/fragments/change_password.dart';
import 'package:login/fragments/events_holidays.dart';
import 'package:login/fragments/staff.dart';
import 'package:login/fragments/student.dart';
import 'package:login/fragments/task_reminder.dart';
import 'package:login/login_page.dart';
import 'package:scoped_model/scoped_model.dart';
import 'fragments/attendance.dart';
import 'fragments/leaves.dart';
import 'fragments/sms_Email.dart';
import 'fragments/viewAssignments.dart';
import 'models/models/auth.dart';

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
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //text
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      heading,
                      style: TextStyle(
                        color: new Color(color),
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                // Icon
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Material(
                      color: new Color(color),
                      //borderRadius: BorderRadius.circular(20.0),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(
                          icon,
                          color: Colors.white,
                          size: 30.0,
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
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    return new Scaffold(
      appBar: new AppBar(
          centerTitle: true,
          title: Text('Dashboard',
              style: TextStyle(
                color: Colors.white,
              ))),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.blueAccent,
          primaryColor: Colors.white,
        ),
        child: new Drawer(
            child: new ListView(
          children: <Widget>[
              new Container(
              child: new DrawerHeader(
                  child: new CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.black,
                ),
              )),
              color: Colors.blueAccent,
            ),
            /*DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                      image: AssetImage("assets/gold.jpg"),
                      fit: BoxFit.cover)),
            ),*/

            new ListTile(
              title: new Text(
                'Home',
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              leading: Icon(
                Icons.home,
                size: 30,
                color: Colors.white,
              ),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new MyHomePage())),
            ),
            new ListTile(
              leading: Icon(
                Icons.people,
                size: 30,
                color: Colors.white,
              ),
              title: new Text(
                'Student',
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Student(""))),
            ),
            new ListTile(
              leading: Icon(
                Icons.people,
                size: 30,
                color: Colors.white,
              ),
              title: new Text(
                'Staff',
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Staff(""))),
            ),
            new ListTile(
              leading: Icon(
                Icons.person,
                size: 30,
                color: Colors.white,
              ),
              title: new Text(
                'Attendance',
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Attendance())),
            ),
            new ListTile(
              leading: Icon(
                Icons.textsms,
                size: 30,
                color: Colors.white,
              ),
              title: new Text(
                'SMS/Email',
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new SmsAndEmail())),
            ),
            new ListTile(
              leading: Icon(
                Icons.sms_failed,
                size: 30,
                color: Colors.white,
              ),

              title: new Text(
                'Leaves',
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new Leaves())),
            ),
            new ListTile(
              leading: Icon(
                Icons.work,
                size: 30,
                color: Colors.white,
              ),
              title: new Text(
                'Assignment',
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new ViewAssignments())),
            ),
            new ListTile(
              leading: Icon(
                Icons.email,
                size: 30,
                color: Colors.white,
              ),
              title: new Text(
                'Task&Reminder',
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new TaskReminder())),
            ),
            new ListTile(
              leading: Icon(
                Icons.photo_library,
                size: 30,
                color: Colors.white,
              ),
              title: new Text(
                'Events&Holidays',
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new EventsHolidays())),
            ),
            // new Divider(),
            new ListTile(
              leading: Icon(
                Icons.contact_phone,
                size: 30,
                color: Colors.white,
              ),
              title: new Text(
                'Contact US',
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              onTap: () {},
            ),
            new ListTile(
              leading: Icon(
                Icons.lock,
                size: 30,
                color: Colors.white,
              ),
              title: new Text(
                'Change Password',
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new ChangePassword())),
            ),
            new ListTile(
              leading: Icon(
                Icons.exit_to_app,
                size: 30,
                color: Colors.white,
              ),
              title: new Text(
                'LogOut',
                style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new LoginPage())),
            ),
          ],
        )),
      ),
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
