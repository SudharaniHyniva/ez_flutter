import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ViewStudentDetails extends StatelessWidget{
  final String firstName;
  final String lastName;
  var mobileNumber;
  final String image;
  ViewStudentDetails({
    Key key, @required this.firstName,
    @required this.lastName,
    @required this.mobileNumber,
    @required this.image,
  }): super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: true,
          title: Text('Staff Details')),
      body:new Center(
        child: new Column(
          children: <Widget>[
            new SizedBox(height: 15.0,),
            new CircleAvatar(radius: 100.0,backgroundImage: NetworkImage(image),),
            new SizedBox(height: 25.0,),
            new Text(firstName+" "+lastName , style: new TextStyle(
                fontWeight: FontWeight.bold, fontSize: 35.0, color: Colors.black
            ),),
            new SizedBox(height: 25.0,),
            /*new Text(role,style: new TextStyle(
                fontWeight: FontWeight.normal, fontSize: 20.0, color: Colors.black
            ),),*/
            new SizedBox(height: 10.0,),
            /*new FlatButton(
                onPressed: ()=> launch(mobileNumber), child: new Text("call",
              style: new TextStyle(
                  fontSize: 25.0,
                  color: Colors.lightBlue
              ),)),*/
            new SizedBox(height: 10.0,),
            new Text("Mobile No:"+mobileNumber,style: new TextStyle(
                fontWeight: FontWeight.normal, fontSize: 20.0, color: Colors.black
            ),),
            new SizedBox(height: 25.0,),
            /*new Text("Address:"+address,style: new TextStyle(
                fontWeight: FontWeight.normal, fontSize: 20.0, color: Colors.black
            ),),*/
          ],
        ),
      ),
    );
  }
}