import "package:flutter/material.dart";
import 'package:login/const/color_const.dart';
import 'package:login/const/page_name_const.dart';

class EventsHolidays extends StatefulWidget {
  EventsHolidays(String s);

  @override
  _TabBarViewState createState() => _TabBarViewState();
}

class _TabBarViewState extends State<EventsHolidays>
    with SingleTickerProviderStateMixin {
  List<Widget> _tabTwoParameters() => [
    Tab(
      text: "Events",
    ),
    Tab(text: "Holidays",
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
          content = "Events";
          break;
        case 1:
          content = "Holidays";
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
        title: Text(PageName.EventsHolidays),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
//              constraints: BoxConstraints.expand(height: 50),
              child: _tabBarLabel(),
            ),
            Expanded(
              child: Container(
                child: TabBarView(children: [
                  Container(
                    child: Text("Events"),
                  ),
                  Container(
                    child: Text("Holidays"),
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
