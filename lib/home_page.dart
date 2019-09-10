import 'package:flutter/material.dart';

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
           // onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=> new KeyValuePairDropdown("studentFargment"))),
          ),
          new ListTile(
            title: new Text('Staff'),
            onTap: () {},
          ),
          new ListTile(
            title: new Text('Attendance'),
            onTap: () {},
          ),
          new ListTile(
            title: new Text('SMS/Email'),
            onTap: () {},
          ),
          new ListTile(
            title: new Text('Leaves'),
            onTap: () {},
          ),
          new ListTile(
            title: new Text('Assignment'),
            onTap: () {},
          ),
          new ListTile(
            title: new Text('Task&Reminder'),
            onTap: () {},
          ),
          new ListTile(
            title: new Text('Events&Holidays'),
            onTap: () {},
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
