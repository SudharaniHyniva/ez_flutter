import "package:flutter/material.dart";
import 'package:login/const/color_const.dart';
import 'package:login/const/page_name_const.dart';

class TabBarSMSAndEmailViewPage extends StatefulWidget {
  TabBarSMSAndEmailViewPage(String s);

  @override
  _TabBarViewState createState() => _TabBarViewState();
}

class _TabBarViewState extends State<TabBarSMSAndEmailViewPage>
    with SingleTickerProviderStateMixin {
  List<Widget> _tabTwoParameters() => [
    Tab(
      text: "Send SMS",
    ),
    Tab(text: "Send Email",
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
          content = "Send SMS";
          break;
        case 1:
          content = "Send Email";
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
        title: Text(PageName.SMS),
      ),
      body: DefaultTabController(
        length: 2,
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
                    child: Text("Send SMS"),
                  ),
                  Container(
                    child: Text("Send Email"),
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
