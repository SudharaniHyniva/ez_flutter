import 'package:flutter/material.dart';
import 'package:login/fragments/add_Task.dart';
import 'package:login/fragments/view_reminders.dart';
import 'package:login/fragments/view_tasks.dart';
import 'add_Reminder.dart';

class TaskReminder extends StatefulWidget {
  @override
  _TaskReminder createState() => _TaskReminder();
}

class _TaskReminder extends State<TaskReminder>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    )..addListener(() {
      setState(() {});
    });
  }
 /* @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);

  }
*/
 @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Task & Reminder"),
        bottom: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.black,
          //controller: _tabController,
          tabs: <Tab>[
            Tab(
              text: "Task",
            ),
            Tab(
              text: "Reminder",
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          new ViewTasks(),
          new ViewReminders(),
        ],
        controller: _tabController,
      ),
      floatingActionButton: _tabController.index ==0
          ? FloatingActionButton(
        backgroundColor: Colors.pink,
        child: Icon(Icons.add),
        onPressed: () {Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddTask()),
        );},
      )
          : FloatingActionButton(
        backgroundColor: Colors.pink,
        child: Icon(Icons.add),
        onPressed: () {Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddReminder()),
        );},
      ),
    );
  }
}