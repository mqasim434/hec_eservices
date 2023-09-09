import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hec_eservices/Models/UserModel.dart';
import 'package:hec_eservices/Screens/More_Screens/Settings_Screens/emailUpdate.dart';
import 'package:hec_eservices/Screens/Navbar_Screens/dashboard.dart';
import 'package:hec_eservices/Screens/Navbar_Screens/morePage.dart';
import 'package:hec_eservices/Screens/Navbar_Screens/notificationPage.dart';
import 'package:hec_eservices/Screens/Navbar_Screens/profile.dart';
import 'package:hec_eservices/Widgets/bottomSheet.dart';
import 'package:hec_eservices/Widgets/toffee.dart';

import '../../../Widgets/bottomNav.dart';
import '../../../Widgets/fab.dart';
import '../../../utils/MyColors.dart';
import '../../../utils/config.dart';

class AccountSetting extends StatefulWidget {
  AccountSetting({Key? key}) : super(key: key);
  static UserModel currentUser = UserModel();

  @override
  _AccountSettingState createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  bool isLoading = true;


  String email = '';
  Future<dynamic> getUserData() async {
    try {
      var cnic = UserModel.CurrentUserCnic.toString();
      var endPoint = "$baseUrl/getUser/$cnic";
      var url = Uri.parse(endPoint);
      var user = await http.get(url);
      if (user.statusCode == 200) {
        AccountSetting.currentUser = UserModel.fromJson(json.decode(user.body));
        setState(() {
          isLoading = false;
        });
        email = AccountSetting.currentUser.email.toString();
      } else {
        print('User Not Found');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.blueGrey[50],
          title: const Text(
            "Account Settings",
            style: TextStyle(color: Colors.black),
          ),
        ),
        // floatingActionButton: AssistFAB(
        body: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
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
                    Subtitle: email,
                    svg: "assets/email.svg",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const EmailUpdate();
                          },
                        ),
                      ).then((value) {
                        setState(() {
                          email = value;
                        });
                      });
                    },
                    type: ToffeeType.profile),
                Toffee2(
                    Title: "Phone",
                    Subtitle: "+92 ${AccountSetting.currentUser.phoneNo}",
                    svg: "assets/phone.svg",
                    onPressed: () {
                      MyBottomSheet().showSnackbar(
                        duration: const Duration(seconds: 6),
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
      floatingActionButton: const CenterDockedFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: MyBottomNav(
          initialSelectedIndex: 3,
          onSeleted: (index) {
            if (index != 3) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return index == 0
                    ? Dashboard()
                    : index == 1
                        ?  ProfilePage()
                        : const NotificationPage();
              }));
            } else {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const MorePage();
              }));
            }
          }),
    );
  }
}
