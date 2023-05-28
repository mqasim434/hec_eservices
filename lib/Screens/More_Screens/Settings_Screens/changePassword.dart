import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:hec_eservices/Screens/homepage.dart';
import 'package:hec_eservices/Screens/morePage.dart';
import 'package:hec_eservices/Screens/notificationPage.dart';
import 'package:hec_eservices/Screens/profile.dart';
import 'package:hec_eservices/utils/MyColors.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isPasswordVisible=false;
  bool isNewPasswordVisible=false;
  bool isConfirmPasswordVisible=false;
  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.blueGrey[50],
          title: Text(
            "Set Your Password",
            style: TextStyle(color: Colors.black),
          ),
        ),
        // floatingActionButton:showFab?AssistFAB():null,
        body: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
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
                  margin: EdgeInsets.only(top: 10),
                  child: TextFormField(
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
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(height: 10,),
                // Name on Degree
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: TextFormField(
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
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(height: 10,),
                // Name on Degree
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    obscureText: !isConfirmPasswordVisible,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isConfirmPasswordVisible = !isConfirmPasswordVisible;
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
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(height: 10,),
                Align(
                  child: InkWell(
                      onTap: (){

                      }, child: Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: MyColors.gradient3
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Center(child: Text("Update",style: TextStyle(color: Colors.white),)))),
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

