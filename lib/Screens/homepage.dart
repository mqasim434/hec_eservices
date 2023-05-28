import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hec_eservices/Screens/morePage.dart';
import 'package:hec_eservices/Screens/notificationPage.dart';
import 'package:hec_eservices/Screens/profile.dart';

import 'package:hec_eservices/Widgets/bottomSheet.dart';
import 'package:hec_eservices/utils/MyColors.dart';
import 'package:hec_eservices/Widgets/toffee.dart';
import 'package:hec_eservices/Widgets/bottomNav.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    ProfilePage(),
    NotificationPage(),
    MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        body: Stack(
          children: [
            // WELCOME CARD
            Container(
              decoration: BoxDecoration(
                gradient: MyColors.gradient1,
              ),
              height: 250,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: SvgPicture.asset(
                          'assets/q4circles.svg',
                          height: 100,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Transform.rotate(
                            angle: -pi / 1.0,
                            child: SvgPicture.asset(
                              'assets/q4circles.svg',
                              height: 100,
                            )),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "Hi Muhammad Qasim!\n",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.white)),
                            ]),
                          ),
                        ),
                        Text(
                          "Welcome to HEC",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        Align(
                            child: Text(
                          "Your one stop solution for your education related services",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            MyBottomSheet().showLoginBottomSheet(context, {
                              "Country": "Pakistan",
                              "IP": "168-198-10.10",
                              "City": "Wazirabad",
                              "Date": "Jan 4, 2022",
                            });
                          },
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 20, left: 20, bottom: 20),
                              child: Text(
                                "Last Login Info",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            //CARD
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  color: Colors.blueGrey[50]),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 200),
              child: Column(
                children: [
                  Toffee(
                    Number: 0,
                    Label: "Total Applications",
                    svg: "assets/total.svg",
                    onPressed: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //       return MyApplications();
                      //     }));
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Toffee(
                        Number: 0,
                        numberColor: Colors.green,
                        Label: "Processing Applications",
                        svg: "assets/processing.svg",
                        onPressed: () {},
                      )),
                      Expanded(
                          child: Toffee(
                              Number: 0,
                              numberColor: Colors.teal,
                              Label: "Saved\nApplications",
                              svg: "assets/saved.svg",
                              onPressed: () {})),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Toffee(
                              Number: 0,
                              numberColor: Colors.orange,
                              Label: "Task Assign\nto me",
                              svg: "assets/assignToMe.svg",
                              onPressed: () {})),
                      Expanded(
                        child: Toffee(
                          Number: 0,
                          numberColor: Colors.red,
                          Label: "Rejected Applications",
                          svg: "assets/rejected.svg",
                          onPressed: () {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: MyColors.greenColor,
        child: SvgPicture.asset(
          'assets/degree.svg',
          height: 30,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyBottomNav(
        initialSelectedIndex: 0,
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
