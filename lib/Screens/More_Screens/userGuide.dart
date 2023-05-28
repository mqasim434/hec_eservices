import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hec_eservices/Screens/homepage.dart';
import 'package:hec_eservices/Screens/morePage.dart';
import 'package:hec_eservices/Screens/notificationPage.dart';
import 'package:hec_eservices/Screens/profile.dart';
import 'package:hec_eservices/Widgets/bottomSheet.dart';
import 'package:hec_eservices/utils/MyColors.dart';

import '../../Widgets/bottomNav.dart';

class UserGuide extends StatefulWidget {
  const UserGuide({Key? key}) : super(key: key);

  @override
  _UserGuideState createState() => _UserGuideState();
}

class _UserGuideState extends State<UserGuide> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: Text(
            "User Guides",
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.blueGrey[50],
        ),
        // floatingActionButton: AssistFAB(),
        body: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ManualDownloadContainer(
                  textTheme: textTheme,
                  Name: "Dashboard Manual",
                  Size: "1.0",
                  onPresses: () {
                    MyBottomSheet().showSnackbar(
                      context: context,
                      msg: "Download Started..",
                    );
                  },
                ),
                ManualDownloadContainer(
                  textTheme: textTheme,
                  Name: "Mobile Application Manual",
                  Size: "1.0",
                  onPresses: () {
                    MyBottomSheet().showSnackbar(
                        context: context,
                        msg: "Download Failed!",
                        type: SnackBarType.Danger);
                  },
                ),
                ManualDownloadContainer(
                  textTheme: textTheme,
                  Name: "Profile Manual",
                  Size: "1.0",
                  onPresses: () {
                    MyBottomSheet().showSnackbar(
                        context: context,
                        msg: "Try Again",
                        type: SnackBarType.Alert);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: SvgPicture.asset(
          'assets/degree.svg',
          height: 30,
          color: Colors.white,
        ),
        backgroundColor: MyColors.greenColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyBottomNav(
        initialSelectedIndex: 3,
        onSeleted: (index){
          print("HELLO");
          if (index != 0) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
                  return index == 1
                      ? ProfilePage()
                      : index == 2
                      ? NotificationPage()
                      : MorePage();
                }));
          }
        },
      ),
    );
  }
}

class ManualDownloadContainer extends StatelessWidget {
  final String Name;
  final String Size;
  final String Trailing;
  final VoidCallback onPresses;
  final IconData icon;

  ManualDownloadContainer({
    Key? key,
    this.icon = Icons.download,
    this.Trailing = "Download",
    required this.textTheme,
    required this.Name,
    required this.Size,
    required this.onPresses,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onPresses,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 5, offset: Offset(0, 3))
            ]),
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(Name),
                  Text("${Size} MB", style: textTheme.caption),
                ],
              ),
            ),
            Icon(icon),
            SizedBox(
              width: 10,
            ),
            Text(
              Trailing,
            )
          ],
        ),
      ),
    );
  }
}
