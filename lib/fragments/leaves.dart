import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/fragments/StaffLeaves.dart';
import 'package:login/fragments/studentLeaves.dart';

import 'MyLeaves.dart';

class Leaves extends StatefulWidget {
  @override
  _TabsDemoState createState() => _TabsDemoState();
}

class _TabsDemoState extends State<Leaves>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Leaves'),

          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                text: "My Leaves",
              ),
              Tab(
                text: "Student Leaves",
              ),
              Tab(
                text: "Staff Leaves",
              ),
            ],
          ),
        ), //   floatingActionButton: _buildFloatingActionButton(context),
        body: TabBarView(
          children: <Widget>[
            new MyLeaves(),
            new ViewStudentLeaves(),
            new ViewStaffLeaves(),
          ],
          controller: _tabController,
        ),
        //floatingActionButton: _bottomButtons(),
      ),
    );
  }
}