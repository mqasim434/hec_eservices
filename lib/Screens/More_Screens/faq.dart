import 'package:flutter/material.dart';
import 'package:hec_eservices/Screens/morePage.dart';
import 'package:hec_eservices/Screens/profile.dart';

import 'package:hec_eservices/Widgets/bottomNav.dart';
import 'package:hec_eservices/Widgets/fab.dart';
import 'package:hec_eservices/utils/MyColors.dart';

import '../homepage.dart';
import 'package:hec_eservices/Screens/notificationPage.dart';

class FAQ extends StatefulWidget {
  const FAQ({ Key? key }) : super(key: key);

  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    var textTheme=Theme.of(context).textTheme;
    return Scaffold(

      body: Scaffold(
        appBar: AppBar(
          title: Text("FAQ",style: TextStyle(color: Colors.black),),
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.blueGrey[50],
        ),


        body: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ExpandableFAQ(textTheme: textTheme,
                  Question: "Father's Name of Applicant on all educational document and CNIC Situation: Father's name on CNIC Muhammad Imran and on educational doc M. Imran Father's name on CNIC Muhammad Imran and on SSC Muhammad Imran HSSC and onwards Imran Father's name on CNIC Muhammad Imran and on SSC Muhammad Imran HSSC and onwards M. Imran Father's name on CNIC M. Imran and on educational documents Muhammad Imran",
                  Answer: "Recommendations: Name of applicant's father on CNIC and educational doc as Muhammad and M/Mohd. and likewise will be accepted Name of applicant's father on CNIC as well as on educational documents with the addition of caste/honorific title will be accepted. Third name (Anjum/Danish/ saqib/nayyer etc.) in addition to applicant fathers name will only be accepted on the basis of Degree Supplement Information Form (Copy attached).",
                ),
                ExpandableFAQ(textTheme: textTheme,
                  Question: "What is the procedure of Correction of name/ Father name on Mark sheet?",
                  Answer: "Please contact with relevant University for correction of name / Father's Name.",
                ),
                ExpandableFAQ(textTheme: textTheme,
                  Question: "What is the procedure of change or delete of last name on attestation form?",
                  Answer: "Applicant can modify/update information by signing-in the HEC attestation profile. If degree already attested then applicant need to apply for post attestation correction by generating a ticket at onlinehelp.hec.gov.pk",
                ),
                ExpandableFAQ(textTheme: textTheme,
                  Question: "What is the procedure of changing password, if forgotten?",
                  Answer: "Please click on forget password, a code will be send on your given email address. Applicant may also call at 111-119-432 or 0334-1119432 for the purpose.",
                ),
                ExpandableFAQ(textTheme: textTheme,
                  Question: "Father's Name of Applicant on all educational document and CNIC Situation: Father's name on CNIC Muhammad Imran and on educational doc M. Imran Father's name on CNIC Muhammad Imran and on SSC Muhammad Imran HSSC and onwards Imran Father's name on CNIC Muhammad Imran and on SSC Muhammad Imran HSSC and onwards M. Imran Father's name on CNIC M. Imran and on educational documents Muhammad Imran",
                  Answer: "Recommendations: Name of applicant's father on CNIC and educational doc as Muhammad and M/Mohd. and likewise will be accepted Name of applicant's father on CNIC as well as on educational documents with the addition of caste/honorific title will be accepted. Third name (Anjum/Danish/ saqib/nayyer etc.) in addition to applicant fathers name will only be accepted on the basis of Degree Supplement Information Form (Copy attached).",
                ),
                ExpandableFAQ(textTheme: textTheme,
                  Question: "What is the procedure of Correction of name/ Father name on Mark sheet?",
                  Answer: "Please contact with relevant University for correction of name / Father's Name.",
                ),
                ExpandableFAQ(textTheme: textTheme,
                  Question: "What is the procedure of change or delete of last name on attestation form?",
                  Answer: "Applicant can modify/update information by signing-in the HEC attestation profile. If degree already attested then applicant need to apply for post attestation correction by generating a ticket at onlinehelp.hec.gov.pk",
                ),
                ExpandableFAQ(textTheme: textTheme,
                  Question: "What is the procedure of changing password, if forgotten?",
                  Answer: "Please click on forget password, a code will be send on your given email address. Applicant may also call at 111-119-432 or 0334-1119432 for the purpose.",
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
        ),
        backgroundColor: MyColors.greenColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyBottomNav(
        initialSelectedIndex: 3,
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

class ExpandableFAQ extends StatelessWidget {
  final String Question;
  final String Answer;
  const ExpandableFAQ({
    Key? key,
    required this.textTheme,
    required this.Question,
    required this.Answer,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0,3)
              )
            ]
        ),
        child: ExpansionTile(
          childrenPadding: EdgeInsets.all(10),
          title: Text(Question,style: textTheme.subtitle2,),
          children: [
            Text(Answer)
          ],
        ));
  }
}