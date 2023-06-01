// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:hec_eservices/Widgets/bottomSheet.dart';
import 'package:hec_eservices/Widgets/fab.dart';
import 'package:hec_eservices/Widgets/bottomNav.dart';
import 'package:hec_eservices/Widgets/informationCard.dart';
import 'package:hec_eservices/Screens/homepage.dart';
import 'package:hec_eservices/Screens/notificationPage.dart';

import 'package:flutter/material.dart';

import '../../Widgets/bottomNav.dart';
import '../../Widgets/bottomSheet.dart';
import '../../Widgets/fab.dart';
import '../homepage.dart';
import '../notificationPage.dart';

class ContactDetails extends StatefulWidget {
  const ContactDetails({Key? key}) : super(key: key);

  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  int selectedGenderIndex = 0;
  int selectedMaritalIndex = 0;
  bool isEditing=false;
  DateTime? selectedDateOfBirth;
  var Country= TextEditingController();
  var City= TextEditingController();
  var District= TextEditingController();
  var Address= TextEditingController();
  var Postal= TextEditingController();

  var genders = [
    {"Label": "Male", "svg": "assets/male.svg"},
    {"Label": "Female", "svg": "assets/female.svg"},
    {"Label": "Other", "svg": "assets/female.svg"},
  ];

  var Countries=["Pakistan","Australia","Turkey","NewZealand"];
  var Cities=["Karachi","Lahore","Peshawar","Gujranwala","Islamabad","Wazirabad"];
  var Districts=["Gujranwala","Lahore","Gujrat","Sialkot"];
  var PostalCodes=["52000","52310","45632","45687"];

  var maritalStatus = [
    {"Label": "Single", "svg": "assetsSingle.svg"},
    {"Label": "Married", "svg": "assets/icons/married.svg"},
  ];
  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        actions: [
          if(isEditing)TextButton(child: Text("Save"),onPressed: (){
            setState(() {
              isEditing=false;
            });
          },)
        ],
        elevation: 0,

        backgroundColor: Colors.blueGrey[50],
        title: Text(
          "Contact Details",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Scaffold(
        floatingActionButton: showFab?AssistFAB():null,
        body: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                !isEditing?
                //INFROMATION CARD
                InformationCard(
                  showButton: true,
                  onPressed: (){
                    setState(() {
                      isEditing=true;
                    });
                  },
                  data: {
                    "Country":"Pakistan",
                    "City":"Gujrat",
                    "District":"Gujrat",
                    "Address":"Baba Shah Hussain Chock",
                    "Postal / Zip Code":"50900",
                  },
                  title: "Mailing Address",)
                //FORM
                    :Column(
                  children: [
                    // COUNTRY FIELD
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: Country,
                        onTap: (){
                          MyBottomSheet().showSearchableBottomSheet(context,
                              Countries
                              , "Country").then((value){
                            setState(() {
                              Country.text= Countries[value];
                            });
                          });

                        },
                        readOnly: true,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                            labelText: "Country",
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder()),
                      ),
                    ),
                    // CITY DROP DOWN
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: City,
                        onTap: (){
                          MyBottomSheet().showSearchableBottomSheet(context,
                              Cities, "City").then((value){
                            setState(() {
                              City.text=Cities[value];
                            });

                          });
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                            labelText: "City",
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder()),
                      ),
                    ),
                    // DISTRICT DROP DOWN
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: District,
                        onTap: (){
                          MyBottomSheet().showSearchableBottomSheet(context,
                              Districts, "District").then((value){
                            setState(() {
                              District.text=Districts[value];
                            });

                          });
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                            labelText: "District",
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder()),
                      ),
                    ),
                    // ADRESS DROP DOWN
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: Address,
                        decoration: InputDecoration(
                            labelText: "Address",
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder()),
                      ),
                    ),
                    // POSTAL / ZIP CODE FIELD
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        controller: Postal,
                        onTap: (){
                          MyBottomSheet().showSearchableBottomSheet(context,
                              PostalCodes, "Postal/Zip Code").then((value){
                            setState(() {
                              Postal.text=PostalCodes[value];
                            });
                          });
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                            labelText: "Postal/Zip Code",
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder()),
                      ),
                    ),
                    // POSTAL/ZIP CODE DROP DOWN


                  ],
                ),
                // INFORMATION CARD
                InformationCard(
                  type: InformationCardType.ValuesOnly,
                  onPressed: (){},
                  data: {
                    "Email":"mq30003@gmail.com",
                    "Phone":"0304-6268933",
                  },
                  title: "Contact Information",),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: showFab?CenterDockedFAB():null,
      extendBody: true,
      bottomNavigationBar: MyBottomNav(
          initialSelectedIndex: 1,
          onSeleted: (index) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
                  return index == 0
                      ? MyHomePage(

                  )
                      : index == 2
                      ? NotificationPage()
                      : MyHomePage();
                }));
          }),
    );

  }
}
