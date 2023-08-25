import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hec_eservices/Screens/homepage.dart';
import 'package:hec_eservices/Screens/notificationPage.dart';
import 'package:hec_eservices/Screens/profile.dart';
import 'package:hec_eservices/Widgets/bottomNav.dart';
import 'package:hec_eservices/Widgets/bottomSheet.dart';
import 'package:hec_eservices/Widgets/toffee.dart';
import 'package:hec_eservices/utils/MyColors.dart';

import '../Widgets/fab.dart';
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
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueGrey[50],
          title: const Text(
            "More",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Toffee2(
                Title: "HEC Contact",
                svg: "assets/contact.svg",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const HECContact();
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
                      return const FAQ();
                    }));
                  },
                  type: ToffeeType.setting),
              Toffee2(
                  Title: "User Guide",
                  svg: "assets/userGuide.svg",
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const UserGuide();
                    }));
                  },
                  type: ToffeeType.setting),
              Toffee2(
                  Title: "Online Help",
                  svg: "assets/onlineHelp.svg",
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const TrackComplaint();
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
                          return const Settings();
                        },
                      ),
                    );
                  },
                  type: ToffeeType.setting),
            ],
          ),
        ),
        floatingActionButton: AssistFAB(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CenterDockedFAB(),
      extendBody: true,
      bottomNavigationBar: MyBottomNav(
          initialSelectedIndex: 3,
          onSeleted: (index) {
            if (index != 3)
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return index == 0
                    ? MyHomePage()
                    : index == 1
                        ? ProfilePage()
                        : NotificationPage();
              }));
          }),
    );
  }
}
