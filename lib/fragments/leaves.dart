import "package:flutter/material.dart";
import 'package:login/const/color_const.dart';
import 'package:login/const/page_name_const.dart';

class TabBarLeaveViewPage extends StatefulWidget {
  TabBarLeaveViewPage(String s);

  @override
  _TabBarViewState createState() => _TabBarViewState();
}

class _TabBarViewState extends State<TabBarLeaveViewPage>
    with SingleTickerProviderStateMixin {
  List<Widget> _tabTwoParameters() => [
        Tab(
          text: "My Leaves",
        ),
        Tab(
          text: "Student Leaves",
        ),
        Tab(
          text: "Staff Leaves",
        ),
      ];

  TabBar _tabBarLabel() => TabBar(
        tabs: _tabTwoParameters(),
        labelColor: RED,
        labelPadding: EdgeInsets.symmetric(vertical: 10),
        labelStyle: TextStyle(fontSize: 20),
        unselectedLabelColor: BLUE_LIGHT,
        unselectedLabelStyle: TextStyle(fontSize: 14),
        onTap: (index) {
          var content = "";
          switch (index) {
            case 0:
              content = "Student Attendance";
              break;
            case 1:
              content = "Staff Attendance";
              break;
            case 2:
              content = "Staff Attendance";
              break;
            default:
              content = "Other";
              break;
          }
          print("You are clicking the $content");
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(PageName.LEAVES),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints.expand(height: 75),
              child: _tabBarLabel(),
            ),
            Expanded(
              child: Container(
                child: TabBarView(children: [
                  Container(
                    child: Text("My Leaves"),
                  ),
                  Container(
                    child: Text("Student Leaves"),
                  ),
                  Container(
                    child: Text("Staff Leaves"),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
