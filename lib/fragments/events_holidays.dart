import 'package:flutter/material.dart';
import 'package:login/fragments/view_events.dart';
import 'package:login/fragments/view_holidays.dart';

class EventsHolidays extends StatefulWidget {
  //TaskReminder(String s);
  @override
  _EventsHolidays createState() => _EventsHolidays();
}

class _EventsHolidays extends State<EventsHolidays>
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
        title: Text("Events & Holidays"),
        bottom: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.black,
          //controller: _tabController,
          tabs: <Tab>[
            Tab(
              text: "Events",
            ),
            Tab(
              text: "Holidays",
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          new ViewEvents(),
          new ViewHoliDays(),
        ],
        controller: _tabController,
      ),
    );
  }
}