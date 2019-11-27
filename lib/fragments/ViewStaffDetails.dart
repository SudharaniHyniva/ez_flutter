import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewStaffDetails extends StatelessWidget {
  final String firstName;
  final String lastName;
  var mobileNumber;
  final String role;
  final String address;
  final String addess2;
  final String image;
  ViewStaffDetails({
    Key key,
    @required this.firstName,
    @required this.lastName,
    @required this.mobileNumber,
    @required this.role,
    @required this.address,
    @required this.addess2,
    @required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(centerTitle: true, title: Text('Staff Details')),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new SizedBox(
              height: 15.0,
            ),
            new CircleAvatar(
              radius: 100.0,
              backgroundImage: NetworkImage(image),
            ),
            /*new FadeInImage(
              //radius: 100.0,
              height: 200.0,
              image: NetworkImage(image),
              placeholder: AssetImage('person-male.jpg'),
            ),*/
            new SizedBox(
              height: 25.0,
            ),
            new Text(
              firstName + " " + lastName,
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35.0,
                  color: Colors.black),
            ),
            new SizedBox(
              height: 25.0,
            ),
            new Text(
              role,
              style: new TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                  color: Colors.black),
            ),
            new SizedBox(
              height: 10.0,
            ),
            /*new FlatButton(
                onPressed: () => launch(mobileNumber),
                child: new Text(
                  "call",
                  style: new TextStyle(fontSize: 25.0, color: Colors.lightBlue),
                )),*/
            new SizedBox(
              height: 10.0,
            ),
            new Text(
              "Mobile No:" + mobileNumber,
              style: new TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                  color: Colors.black),
            ),
            new SizedBox(
              height: 25.0,
            ),
            new Text(
              "Address:" + address,
              style: new TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
