import 'package:flutter/material.dart';
import 'package:hec_eservices/Screens/Profile_Screens/Education_Details/page1.dart';
import 'package:hec_eservices/Screens/Profile_Screens/Education_Details/page2.dart';
import 'package:hec_eservices/Screens/Profile_Screens/Education_Details/page3.dart';

import '../../../Widgets/bottomNav.dart';
import '../../../Widgets/fab.dart';
import '../../../Widgets/informationCard.dart';
import '../../../utils/MyColors.dart';
import '../../Navbar_Screens/dashboard.dart';
import '../../Navbar_Screens/notificationPage.dart';

class EducationDetails extends StatefulWidget {
  final bool isViewOnly;
  dynamic data;
  EducationDetails({Key? key, this.isViewOnly = true,this.data}) : super(key: key);

  @override
  _EducationDetailsState createState() => _EducationDetailsState();
}

class _EducationDetailsState extends State<EducationDetails> {
  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    var pageController = PageController(initialPage: selectedPageIndex);
    return Scaffold(
      body: Scaffold(
        floatingActionButton: showFab ? const AssistFAB() : null,
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.blueGrey[50],
          title: const Text(
            "Education Details",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: widget.isViewOnly
              ? SingleChildScrollView(
            child: Column(
              children: [
                InformationCard(data: {
                  "Qualification Level": widget.data['qualificationLevel'].toString(),
                  "Complete": widget.data['education'].toString(),
                  "Start Date": widget.data['startDate'].toString(),
                  "End Date": widget.data['expectedEndDate'].toString(),
                }, title: "Qualification", onPressed: () {}),
                InformationCard(data: {
                  "Country": widget.data['country'].toString(),
                  "City": widget.data['country'].toString(),
                  "Awarding Institute": widget.data['degreeAwardInstitute'].toString(),
                  "Program Title": widget.data['programTitle'].toString(),
                  // "Discipline": 'discipline',
                  "Campus": widget.data['campus'].toString(),
                  "Department": widget.data['department'].toString(),
                  "Degree Type": widget.data['degreeType'].toString(),
                  "Session": widget.data['sessionType'].toString(),
                  "Major": 'major',
                  "Area of Research": widget.data['areaOfResearch'].toString(),
                }, title: "Degree Awarding Institute", onPressed: () {}),
                InformationCard(data: {
                  "Registration / Roll No": widget.data['rollNo'].toString(),
                }, title: "Degree", onPressed: () {}),
                const SizedBox(
                  height: 70,
                )
              ],
            ),
          )
              : Column(
            children: [
              // STEPPER
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Expanded(flex: 2, child: SizedBox()),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedPageIndex = 0;
                          pageController.animateToPage(
                            selectedPageIndex,
                            curve: Curves.decelerate,
                            duration: const Duration(milliseconds: 300),
                          );
                        });
                      },
                      child: Icon(
                        Icons.looks_one,
                        color: selectedPageIndex == 0
                            ? MyColors.greenColor
                            : Colors.black,
                      ),
                    ),
                    const Expanded(
                        flex: 4,
                        child: Divider(
                          color: Colors.black,
                        )),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedPageIndex = 1;
                          pageController.animateToPage(
                            selectedPageIndex,
                            curve: Curves.decelerate,
                            duration: const Duration(milliseconds: 300),
                          );
                        });
                      },
                      child: Icon(
                        Icons.looks_two,
                        color: selectedPageIndex == 1
                            ? MyColors.greenColor
                            : Colors.black,
                      ),
                    ),
                    const Expanded(
                        flex: 4,
                        child: Divider(
                          color: Colors.black,
                        )),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedPageIndex = 3;
                          pageController.animateToPage(
                            selectedPageIndex,
                            curve: Curves.decelerate,
                            duration: const Duration(milliseconds: 300),
                          );
                        });
                      },
                      child: Icon(
                        Icons.looks_3,
                        color: selectedPageIndex == 2
                            ? MyColors.greenColor
                            : Colors.black,
                      ),
                    ),
                    const Expanded(flex: 2, child: SizedBox())
                  ]),
              Expanded(
                flex: 9,
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      selectedPageIndex = value;
                    });
                    pageController.animateToPage(selectedPageIndex,
                        curve: Curves.ease,
                        duration: const Duration(milliseconds: 300));
                  },
                  controller: pageController,
                  children: [
                    Page1(
                      onPressed: () {
                        setState(() {
                          selectedPageIndex++;
                        });
                        pageController.animateToPage(
                          selectedPageIndex,
                          curve: Curves.decelerate,
                          duration: const Duration(milliseconds: 300),
                        );
                      },
                    ),
                    Page2(
                      onPressed: () {
                        setState(() {
                          selectedPageIndex++;
                        });
                        pageController.animateToPage(
                          selectedPageIndex,
                          curve: Curves.decelerate,
                          duration: const Duration(milliseconds: 300),
                        );
                      },
                    ),
                    Page3(
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: showFab ? CenterDockedFAB() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: MyBottomNav(
        initialSelectedIndex: 1,
        onSeleted: (index) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return index == 0
                    ? Dashboard()
                    : index == 2
                    ? const NotificationPage()
                    :  Dashboard();
              }));
        },
      ),
    );
  }
}
