import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  Material myItems(IconData icon, String heading, int color) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0x802196F3),
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  //text
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(heading,
                      style: TextStyle(
                        color: new Color(color),
                        fontSize: 20.0,
                      ),
                     ),
                    ),
                  ),


                  // Icon
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        color: new Color(color),
                        borderRadius: BorderRadius.circular(24.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(
                            icon,
                            color: Colors.white,
                            size: 20.0,
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard',
        style: TextStyle(
         color: Colors.white,
        ),
        ),
      ),
      body: StaggeredGridView.count
        (crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          myItems(Icons.graphic_eq, "Students", 0xffff9800),
          myItems(Icons.graphic_eq, "Staff", 0xffff5722),
          myItems(Icons.bookmark, "SMS & Email", 0xff3399fe),
          myItems(Icons.notifications, "Attendance", 0xffe91E63),
          myItems(Icons.message, "Events", 0xff622F74),
          myItems(Icons.group_work, "Leaves", 0xff26cb3c),

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