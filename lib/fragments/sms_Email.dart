import 'package:flutter/material.dart';
import 'package:login/fragments/send_Email.dart';
import 'package:login/fragments/send_sms.dart';

class SmsAndEmail extends StatefulWidget {
  @override
  _SmsAndEmail createState() => _SmsAndEmail();
}

class _SmsAndEmail extends State<SmsAndEmail>
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
        title: Text("SMS / Email"),
        bottom: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.black,
          //controller: _tabController,
          tabs: <Tab>[
            Tab(
              text: "SMS",
            ),
            Tab(
              text: "E-MAIL",
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          new SendSMS(),
          new SendEmail(),
        ],
        controller: _tabController,
      ),
    );
  }
}
