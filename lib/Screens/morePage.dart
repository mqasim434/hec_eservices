import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hec_eservices/Screens/notificationPage.dart';
import 'package:hec_eservices/Screens/profile.dart';
import 'package:hec_eservices/Widgets/bottomNav.dart';
import 'package:hec_eservices/Widgets/bottomSheet.dart';
import 'package:hec_eservices/Widgets/toffee.dart';
import 'package:hec_eservices/utils/MyColors.dart';

import 'More_Screens/faq.dart';
import 'More_Screens/hecContact.dart';
import 'More_Screens/settings.dart';
import 'More_Screens/trackComplaint.dart';
import 'More_Screens/userGuide.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  _MorePageState createState() => _MorePageState();
}


class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        extendBody: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueGrey[50],
          title: Text(
            "More",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Toffee2(
                Title: "HEC Contact",
                svg: "assets/contact.svg",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HECContact();
                  }));
                },
                type: ToffeeType.setting,
              ),
              Toffee2(
                  Title: "FAQ",
                  svg: "assets/FAQ.svg",
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FAQ();
                    }));
                  },
                  type: ToffeeType.setting),
              Toffee2(
                  Title: "User Guide",
                  svg: "assets/userGuide.svg",
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return UserGuide();
                    }));
                  },
                  type: ToffeeType.setting),
              Toffee2(
                  Title: "Online Help",
                  svg: "assets/onlineHelp.svg",
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TrackComplaint();
                    }));
                  },
                  type: ToffeeType.setting),
              Toffee2(
                  enabled: false,
                  Title: "Change Authorized Person",
                  svg: "assets/authPerson.svg",
                  onPressed: () {
                    MyBottomSheet().showSnackbar(
                        context: context,
                        msg: "You Don't Have Access to This Page.",
                        type: SnackBarType.Alert);
                  },
                  type: ToffeeType.setting),
              Toffee2(
                  Title: "Settings",
                  svg: "assets/setting.svg",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Settings();
                        },
                      ),
                    );
                  },
                  type: ToffeeType.setting),
            ],
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
