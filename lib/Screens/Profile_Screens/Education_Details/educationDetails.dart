import 'package:flutter/material.dart';
import 'package:hec_eservices/Screens/Profile_Screens/Education_Details/page1.dart';
import 'package:hec_eservices/Screens/Profile_Screens/Education_Details/page2.dart';
import 'package:hec_eservices/Screens/Profile_Screens/Education_Details/page3.dart';

import '../../../Widgets/bottomNav.dart';
import '../../../Widgets/fab.dart';
import '../../../Widgets/informationCard.dart';
import '../../../utils/MyColors.dart';
import '../../homepage.dart';
import '../../notificationPage.dart';

class EducationDetails extends StatefulWidget {
  final bool isViewOnly;
  const EducationDetails({Key? key, this.isViewOnly = true}) : super(key: key);

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
                InformationCard(data: const {
                  "Qulification Level": "Bachelor 14 Years",
                  "Complete": "True",
                  "Start Date": "12 Aug, 2019",
                  "End Date Date": "12 Aug, 2013",
                }, title: "Qualification", onPressed: () {}),
                InformationCard(data: const {
                  "Country": "Pakistan",
                  "City": "Gujrat",
                  "Awarding Instititute": "University of Gujrat",
                  "Progam Title": "Bs Software Engineering",
                  "Discipline": "Software Engineering",
                  "Campus": "Marghazar Campus",
                  "Department": "Software Engineering",
                  "Degree Type": "Regular",
                  "Session": "Evening",
                  "Major": "Software Engineering",
                  "Area of Research": "Flutter Development",
                }, title: "Degree Awarding Institute", onPressed: () {}),
                InformationCard(data: const {
                  "Registration / Roll No": "19014198-092",
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
                    ? MyHomePage()
                    : index == 2
                    ? const NotificationPage()
                    :  MyHomePage();
              }));
        },
      ),
    );
  }
}
