import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hec_eservices/Models/TemplateModel.dart';
import 'package:hec_eservices/Screens/Applicatins_Screens/applications.dart';
import 'package:hec_eservices/test_Screen/ImageGallery.dart';
import 'package:hec_eservices/utils/config.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:hec_eservices/Screens/morePage.dart';
import 'package:hec_eservices/Screens/notificationPage.dart';
import 'package:hec_eservices/Screens/profile.dart';
import 'package:hec_eservices/Widgets/bottomSheet.dart';
import 'package:hec_eservices/Widgets/fab.dart';
import 'package:hec_eservices/utils/MyColors.dart';
import 'package:hec_eservices/Widgets/toffee.dart';
import 'package:hec_eservices/Widgets/bottomNav.dart';
import 'package:hec_eservices/Models/UserModel.dart';

import '../Models/ApplicationModel.dart';
import '../Models/dropdownsModel.dart';
import '../test_Screen/getTemplates.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  bool isLoading = true;

  final List<Widget> screens = [
    const ProfilePage(),
    const NotificationPage(),
    const MorePage(),
  ];

  UserModel currentUser = UserModel();

  Future<dynamic> getUserData() async {
    try {
      var cnic = UserModel.CurrentUserCnic.toString();
      var endPoint = "$baseUrl/getUser/$cnic";
      var url = Uri.parse(endPoint);
      var user = await http.get(url);
      if (user.statusCode == 200) {
        currentUser = UserModel.fromJson(json.decode(user.body));
        setState(() {
          isLoading = false;
        });
      } else {
        print('User Not Found');
      }
    } catch (e) {
      print(e);
    }
  }

  void getDropdowns() async{
    await DropdownDataSingleton.fetchData();
  }
  Future<void> getApplications() async{
    await Application.fetchApplications();
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    getDropdowns();
    getApplications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // WELCOME CARD
            Container(
              decoration: const BoxDecoration(
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
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: "Hi ${currentUser.firstName}"
                                            "${currentUser.lastName}!\n",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(color: Colors.white)),
                                  ]),
                                ),
                        ),
                        const Text(
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
                              "Country": currentUser.country,
                              "IP": IpAddress.version.characters.toString(),
                              "City": currentUser.city,
                              "Date":
                                  '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
                            });
                          },
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              padding: const EdgeInsets.only(
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
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  color: Colors.blueGrey[50]),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 200),
              child: Column(
                children: [
                  Toffee(
                    Number: Application.applicationCount,
                    Label: "Total Applications",
                    svg: "assets/total.svg",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const MyApplications();
                      }));
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
                          Label: "Rejected\nApplications",
                          svg: "assets/rejected.svg",
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UniversityTemplatesScreen(),
                        ),
                      );
                    },
                    child: const Text('Document Gallery'),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: const AssistFAB(),
      ),
      floatingActionButton: const CenterDockedFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: MyBottomNav(
        initialSelectedIndex: 0,
        onSeleted: (index) {
          print("HELLO");
          if (index != 0) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return index == 1
                  ? const ProfilePage()
                  : index == 2
                      ? const NotificationPage()
                      : const MorePage();
            }));
          }
        },
      ),
    );
  }
}
