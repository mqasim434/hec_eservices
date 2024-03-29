import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:hec_eservices/Models/ApplicationModel.dart';
import 'package:hec_eservices/Models/UserModel.dart';
import 'package:hec_eservices/Screens/Applicatins_Screens/detailsOfDegree.dart';
import 'package:hec_eservices/Screens/More_Screens/Settings_Screens/accountSettings.dart';
import 'package:hec_eservices/utils/config.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import '../../Widgets/bottomNav.dart';
import '../../Widgets/fab.dart';
import '../../utils/MyColors.dart';
import '../Navbar_Screens/dashboard.dart';
import '../Navbar_Screens/notificationPage.dart';
import '../Navbar_Screens/profile.dart';

class VerifyDetails extends StatefulWidget {
  const VerifyDetails({Key? key}) : super(key: key);

  @override
  _VerifyDetailsState createState() => _VerifyDetailsState();
}

class _VerifyDetailsState extends State<VerifyDetails> {
  bool verify1 = false;
  bool verify2 = false;
  bool isLoading = true;

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
  
  void uploadData() async{
    UserModel.applicationData['userCnic'] = UserModel.CurrentUserCnic.toString();
    var response = await http.post(Uri.parse('$baseUrl/submitApplication'),body: UserModel.applicationData);
    if (response.statusCode == 200) {
      print('Application Submitted');
    } else {
      print('Error Submitting Application');
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
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          backgroundColor: Colors.blueGrey[50],
          title: const Row(
            children: [
              Icon(FontAwesome.doc_text),
              Text(
                " Verify Details",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        floatingActionButton: const AssistFAB(),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            shrinkWrap: true,
            children: [
              const OrangeInforCard(
                  text:
                      "Please review and verify all your application details once before submitting."),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Application Details",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.black),
                    )),
              ),
              const TwoColumnInfo(
                name: "Application Reference",
                Value: "HEC/A&A/DAS/ISL/2021/170623",
              ),
              const TwoColumnInfo(
                name: "Mode of Attestation",
                Value: "Attestation Through Courier",
              ),
              const TwoColumnInfo(
                name: "From Where You Are Sending Documents",
                Value: "Inside Pakistan",
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Personal Details",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.black),
                    )),
              ),
              TwoColumnInfo(
                name: "Full Name",
                Value:
                    '${currentUser.firstName.toString()} ${currentUser.lastName.toString()}',
              ),
              TwoColumnInfo(
                name: "Gender",
                Value: currentUser.gender.toString(),
              ),
              TwoColumnInfo(
                name: "Date of Birth",
                Value: currentUser.dateOfBirth.toString(),
              ),
              TwoColumnInfo(
                name: "Mailing Address",
                Value:
                    "${currentUser.address.toString()}, City ${currentUser.city.toString()}, Tehsil ${currentUser.city.toString()}, District ${currentUser.district.toString()} , ${currentUser.postalCode.toString()}, ${currentUser.country.toString()}",
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 24,
                        width: 24,
                        margin: const EdgeInsets.only(right: 10),
                        child: Checkbox(
                            value: verify1,
                            onChanged: (value) {
                              setState(() {
                                verify1 = value!;
                              });
                            })),
                    const Expanded(
                        child: Text(
                            "Please ensure that there is no variation in your name, father's name and date of birth written in personal details and NADRA detail as mentioned above"))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Selected Degees",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.black),
                    )),
              ),
              Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        const BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(0, 3))
                      ]),
                  child: Container(
                    height: 180,
                    child: ListView.builder(
                        itemCount: UserModel.degrees.length,
                        itemBuilder: (context, index) {
                          return const SelectedDegreeExpansionTile(
                            degree: "Bachelor (14 Years Degree)",
                            department: "Engineering & Technology",
                            year: "2023",
                            university: "University of Gujrat, Gujrat",
                          );
                        }),
                  )),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Selected Degees",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          "PKR 4000",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    )),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 24,
                        width: 24,
                        margin: const EdgeInsets.only(right: 10),
                        child: Checkbox(
                            value: verify2,
                            onChanged: (value) {
                              setState(() {
                                verify2 = value!;
                              });
                            })),
                    const Expanded(
                        child: Text(
                            "I Muhammad Qasim bearing CNIC # 3420118582991 PKR 4000 hereby solemnly declare that all my degree(s)/Transcript(s)/ Certificates including Secondary School Certificate (SSC), Higher Secondary Certificate (HSSC) or Equivalent and all my subsequent degrees/transcripts or equivalent are genuine from recognized university/degree awarding institute and are in line with academic standards.\n\nIf at any stage it is revealed that any of my academic degree(s)/Transcript(s) /Certificates are FAKE/BOGUS or not in line with academic regulations of the university, the HEC would have right to immediately. cancel the attestation done on my degree(s)/Transcript(s)/Certificates. Besides, I would be held accountable for disciplinary and legal.proceedings for concealment of facts and forgery ofacademic documents."))
                  ],
                ),
              ),
              Align(
                child: InkWell(
                  onTap: () {
                    uploadData();
                    showDialog(
                      context: context,
                      builder: (context) => Container(
                        height: 200,
                        child: AlertDialog(
                          title: const Text(
                            'Your Application has been submitted',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => Dashboard(),
                                    ),
                                        (route) => false, // This line clears the stack
                                  );
                                },
                                child: Container(
                                  width: 100,
                                  height: 40,
                                  color: MyColors.greenColor,
                                  child: const Center(
                                    child: Text(
                                      'Ok',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
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
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
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
                        ? ProfilePage()
                        : const NotificationPage();
              }));
            }
          }),
    );
  }
}

class SelectedDegreeExpansionTile extends StatelessWidget {
  final String degree;
  final String department;
  final String year;
  final String university;
  const SelectedDegreeExpansionTile({
    Key? key,
    required this.degree,
    required this.department,
    required this.year,
    required this.university,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        iconColor: Colors.black,
        collapsedIconColor: Colors.black,
        textColor: Colors.black,
        trailing: const Icon(Icons.arrow_forward_ios),
        collapsedTextColor: Colors.black,
        tilePadding: const EdgeInsets.all(0),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                Text("${degree}",
                    style: Theme.of(context).textTheme.headline6!),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${department}"),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("${year}"),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text("${university}"),
          ],
        ),
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Attestation Details",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black),
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text("Rate of Orginal Attestation (PKR):"),
              Text(
                "1000",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text("Rate of Photocopy Attestation (PKR):"),
              Text(
                "7000",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Text(
                  "Document Type",
                  style: TextStyle(
                      color: Colors.blueGrey[400], fontWeight: FontWeight.bold),
                )),
                Expanded(
                    child: Text(
                  "Original Document",
                  style: TextStyle(
                      color: Colors.blueGrey[400], fontWeight: FontWeight.w500),
                )),
                Expanded(
                    child: Text(
                  "Photocopy Document",
                  style: TextStyle(
                      color: Colors.blueGrey[400], fontWeight: FontWeight.w500),
                )),
                Expanded(
                    child: Text(
                  "Amount",
                  style: TextStyle(
                      color: Colors.blueGrey[400], fontWeight: FontWeight.w500),
                )),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: const Row(
              children: [
                Expanded(child: Text("Degree")),
                Expanded(child: Text("1")),
                Expanded(child: Text("0")),
                Expanded(child: Text("1000")),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: const Row(
              children: [
                Expanded(child: Text("Transcript")),
                Expanded(child: Text("1")),
                Expanded(child: Text("0")),
                Expanded(child: Text("1000")),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: const Row(
              children: [
                Expanded(child: Text("Provisional Certificate")),
                Expanded(child: Text("0")),
                Expanded(child: Text("0")),
                Expanded(child: Text("0")),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: const Row(
              children: [
                Expanded(child: Text("Equivalance Certificate")),
                Expanded(child: Text("0")),
                Expanded(child: Text("0")),
                Expanded(child: Text("0")),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}

class TwoColumnInfo extends StatelessWidget {
  final String name;
  final String Value;
  const TwoColumnInfo({
    Key? key,
    required this.name,
    required this.Value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.only(right: 5),
            child: Text("$name:",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.blueGrey[400])),
          )),
          Expanded(child: Text("$Value")),
        ],
      ),
    );
  }
}
