import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hec_eservices/Screens/homepage.dart';
import 'package:hec_eservices/Screens/morePage.dart';
import 'package:hec_eservices/Screens/profile.dart';
import 'package:hec_eservices/Widgets/bottomNav.dart';
import 'package:hec_eservices/Widgets/toffee.dart';
import 'package:hec_eservices/utils/MyColors.dart';

import '../Widgets/fab.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blueGrey[50],
          automaticallyImplyLeading: false,
          title: const Text(
            "Notifications",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 40,
              backgroundColor: Colors.blueGrey[50],
              floating: true,
              automaticallyImplyLeading: false,
              title: const Text("Earlier",
                  style: TextStyle(color: Colors.black, fontSize: 14)),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              var tempIndex = index % 3;
              return NotificationTile(
                notificationType: tempIndex == 0
                    ? NotificationType.information
                    : tempIndex == 1
                        ? NotificationType.success
                        : NotificationType.alert,
              );
            }, childCount: 20))
          ],
        ),
        floatingActionButton: AssistFAB(),
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CenterDockedFAB(),
      bottomNavigationBar: MyBottomNav(
          initialSelectedIndex: 2,
          onSeleted: (index) {
            if (index != 2)
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return index == 0
                    ? MyHomePage()
                    : index == 1
                        ? ProfilePage()
                        : MorePage();
              }));
          }),
    );
  }
}
