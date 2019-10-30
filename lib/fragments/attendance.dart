import 'package:flutter/material.dart';
import 'package:login/fragments/staff_attendance.dart';
import 'package:login/fragments/view_events.dart';
import 'package:login/fragments/view_holidays.dart';

class Attendance extends StatefulWidget {
  //TaskReminder(String s);
  @override
  _Attendance createState() => _Attendance();
}

class _Attendance extends State<Attendance>
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
        title: Text("Attendance"),
        bottom: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.black,
          //controller: _tabController,
          tabs: <Tab>[
            Tab(
              text: "Student",

            ),
            Tab(
              text: "Staff",
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          Tab(
            text: "hjvaldksv",
          ),
          StaffAttendance(),
        ],
        controller: _tabController,
      ),
    );
  }
}