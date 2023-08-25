import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:hec_eservices/Screens/More_Screens/Settings_Screens/accountSettings.dart';
import 'package:hec_eservices/Screens/homepage.dart';
import 'package:hec_eservices/Screens/morePage.dart';
import 'package:hec_eservices/Screens/notificationPage.dart';
import 'package:hec_eservices/Screens/profile.dart';
import 'package:hec_eservices/utils/MyColors.dart';

import 'package:http/http.dart' as http;

import '../../../Models/UserModel.dart';
import '../../../utils/config.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  void updatePassword(String oldPass, String newPass) async {
    var cnic = UserModel.CurrentUserCnic;

    if (AccountSetting.currentUser.password == oldPass) {
      var endPoint = "$baseUrl/update/$cnic";
      try {
        var response = await http.patch(Uri.parse(endPoint), body: {
          'password': newPass,
          'confirmPassword': newPass,
        });
        if (response.statusCode == 200) {
          print('Password Updated Successfully');
        } else {
          print('Error Updating Password');
        }
      } catch (error) {
        print(error);
      }
      setState(() {});
    } else {
      throw 'Old and New Password are not same';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.blueGrey[50],
          title: const Text(
            "Set Your Password",
            style: TextStyle(color: Colors.black),
          ),
        ),
        // floatingActionButton:showFab?AssistFAB():null,
        body: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Change Password for your Account.",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Colors.black),
                      )),
                ),
                // Name on Degree
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: oldPassController,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            !isPasswordVisible
                                ? FontAwesome5.eye
                                : FontAwesome5.eye_slash,
                            size: 20,
                            color: Colors.black26,
                          ),
                        ),
                        labelText: "Old Password",
                        contentPadding: const EdgeInsets.all(15),
                        border: const OutlineInputBorder()),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Name on Degree
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: newPassController,
                    obscureText: !isNewPasswordVisible,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isNewPasswordVisible = !isNewPasswordVisible;
                            });
                          },
                          icon: Icon(
                            !isNewPasswordVisible
                                ? FontAwesome5.eye
                                : FontAwesome5.eye_slash,
                            size: 20,
                            color: Colors.black26,
                          ),
                        ),
                        labelText: "New Password",
                        contentPadding: const EdgeInsets.all(15),
                        border: const OutlineInputBorder()),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Name on Degree
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: confirmPassController,
                    obscureText: !isConfirmPasswordVisible,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isConfirmPasswordVisible =
                                  !isConfirmPasswordVisible;
                            });
                          },
                          icon: Icon(
                            !isConfirmPasswordVisible
                                ? FontAwesome5.eye
                                : FontAwesome5.eye_slash,
                            size: 20,
                            color: Colors.black26,
                          ),
                        ),
                        labelText: "Confirm New Password",
                        contentPadding: const EdgeInsets.all(15),
                        border: const OutlineInputBorder()),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  child: InkWell(
                      onTap: () {
                        String oldPassword = oldPassController.text.toString();
                        String newPassword = newPassController.text.toString();
                        String confirmPassword =
                            confirmPassController.text.toString();
                        if (newPassword == confirmPassword) {
                          updatePassword(oldPassword, newPassword);
                          Navigator.pop(context);
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text(
                                        'New Password and Confirm Password are not same'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            oldPassController.clear();
                                            newPassController.clear();
                                            confirmPassController.clear();
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Ok'))
                                    ],
                                  ));
                        }
                      },
                      child: Container(
                          width: double.maxFinite,
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: MyColors.gradient3),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: const Center(
                              child: Text(
                            "Update",
                            style: TextStyle(color: Colors.white),
                          )))),
                )
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
        shape: const CircularNotchedRectangle(),
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
                    child: const Column(
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
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                    child: const Column(
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
              const SizedBox(
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
                          builder: (context) => const NotificationPage(),
                        ),
                      );
                    },
                    child: const Column(
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
                          builder: (context) => const MorePage(),
                        ),
                      );
                    },
                    child: const Column(
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
