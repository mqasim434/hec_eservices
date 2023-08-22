import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hec_eservices/Models/UserModel.dart';
import 'package:hec_eservices/Screens/More_Screens/Settings_Screens/emailUpdate.dart';
import 'package:hec_eservices/Screens/homepage.dart';
import 'package:hec_eservices/Screens/morePage.dart';
import 'package:hec_eservices/Screens/notificationPage.dart';
import 'package:hec_eservices/Screens/profile.dart';
import 'package:hec_eservices/Widgets/bottomSheet.dart';
import 'package:hec_eservices/Widgets/toffee.dart';

import '../../../utils/MyColors.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  _AccountSettingState createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(

        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.blueGrey[50],
          title: Text(
            "Account Settings",
            style: TextStyle(color: Colors.black),
          ),
        ),
        // floatingActionButton: AssistFAB(
        body: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Change Your Account Settings",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.black),
                      )),
                ),
                Toffee2(
                    Title: "Email",
                    Subtitle: '',
                    svg: "assets/email.svg",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return EmailUpdate();
                      }));
                    },
                    type: ToffeeType.profile),
                Toffee2(
                    Title: "Phone",
                    Subtitle: "+92",
                    svg: "assets/phone.svg",
                    onPressed: () {
                      MyBottomSheet().showSnackbar(
                        duration: Duration(seconds: 6),
                        context: context,
                        msg:
                            "To Update contact number kindly contact call center (051 111-119-432) or online help (onlinehelp.hec.gov.pk) and register your complaint for support.",
                        type: SnackBarType.Alert,
                      );
                    },
                    type: ToffeeType.profile),
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
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.dashboard,
                        ),
                        Text('Dashboard'),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_2_rounded,
                        ),
                        Text('Profile'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Row(
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationPage(),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notification_important,
                        ),
                        Text('Notifications'),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MorePage(),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.more_horiz_rounded,
                        ),
                        Text('More'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
