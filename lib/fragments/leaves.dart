import "package:flutter/material.dart";
import 'package:login/const/color_const.dart';
import 'package:login/const/page_name_const.dart';

class Leaves extends StatefulWidget {
  @override
  _Leaves createState() => _Leaves();
}
class _Leaves extends State<Leaves>
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
              constraints: BoxConstraints.expand(height: 60),
              child: _tabBarLabel(),
            ),
            Expanded(
              child: Container(
                child: TabBarView(children: [
                  Container(
                    child: Text("Currently there are no leave request for you"),
                  ),
                  Container(
                    child: Text("Currently there are no staff leave request"),
                  ),
                  Container(
                    child: Text("Currently there are no student leave request"),
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
