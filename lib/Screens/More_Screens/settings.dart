import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hec_eservices/Screens/More_Screens/Settings_Screens/accountSettings.dart';
import 'package:hec_eservices/Screens/More_Screens/Settings_Screens/changePassword.dart';
import 'package:hec_eservices/Screens/morePage.dart';
import 'package:hec_eservices/Screens/notificationPage.dart';
import 'package:hec_eservices/Screens/profile.dart';
import 'package:hec_eservices/Widgets/toffee.dart';
import 'package:hec_eservices/utils/MyColors.dart';

import '../../Widgets/bottomNav.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blueGrey[50],
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Settings",
            style: TextStyle(color: Colors.black),
          ),
        ),
        // floatingActionButton: AssistFAB(),
        body: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Toffee2(
                    Title: "Account Setting",
                    svg: "assets/accountSetting.svg",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AccountSetting();
                      }));
                    },
                    type: ToffeeType.setting),
                Toffee2(
                    Title: "Change Password",
                    svg: "assets/changePassword.svg",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ChangePassword();
                      }));
                    },
                    type: ToffeeType.setting),
                Toffee2(
                    Title: "Log Out",
                    svg: "assets/logOut.svg",
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Attention"),
                              content:
                                  Text("Are you sure you want to log out?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.popUntil(
                                        context, ModalRoute.withName('/home'));
                                  },
                                  child: Text("Ok"),
                                ),
                              ],
                            );
                          });
                    },
                    type: ToffeeType.setting),
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
        onSeleted: (index) {
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
