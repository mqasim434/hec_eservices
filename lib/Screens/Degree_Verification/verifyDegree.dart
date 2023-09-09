import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hec_eservices/Models/TemplateModel.dart';
import 'package:hec_eservices/Screens/Navbar_Screens/profile.dart';
import 'package:hec_eservices/Screens/Navbar_Screens/dashboard.dart';
import 'package:hec_eservices/Screens/Navbar_Screens/notificationPage.dart';
import 'package:hec_eservices/Widgets/bottomNav.dart';
import 'package:hec_eservices/Widgets/fab.dart';
import 'package:hec_eservices/utils/MyColors.dart';

class VerifyDocument extends StatefulWidget {
  const VerifyDocument({Key? key}) : super(key: key);

  @override
  _VerifyDocumentState createState() => _VerifyDocumentState();
}

class _VerifyDocumentState extends State<VerifyDocument> {
  String result = 'noResult';
  List jsonData = [];
  var foundTemplate;

  Map<String, dynamic>? findObjectByDegreeTemplate(String template) {
    return jsonData.firstWhere(
          (item) => item[template] == result,
      orElse: () => null,
    );
  }

  Future<void> scanQr(String template) async {
    try {
      result = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'cancel',
        true,
        ScanMode.QR,
      );
      List<Map<String, dynamic>> jsonData = UniversityTemplates.universityTemplatesList.map((template) => template.toJson()).toList();
      //
      // foundTemplate = findObjectByDegreeTemplate(template);
      bool documentExists = jsonData.any((element) => element[template] == result);

      if(documentExists){
        var templateData = jsonData.firstWhere((element) => element[template] == result);
        showDialog(context: context, builder: (context){
          return AlertDialog(
            icon: Icon(Icons.check_circle,color: MyColors.greenColor,),
            title: Text('Document is Verified'),
            content: Text.rich(TextSpan(
              text: 'University Name: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: templateData['University_Name'],
                      style: TextStyle(fontWeight: FontWeight.normal),
                    )
                ],
            )),
          );
        });
      }
      else{
        showDialog(context: context, builder: (context){
          return AlertDialog(
            icon: Icon(Icons.error,color: Colors.red,),
            content: Text('Document is not Verified'),
          );
        });
      }

    } catch (e) {}
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UniversityTemplates.fetchTemplates();
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      extendBody: true,
      body: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.blueGrey[50],
          title: const Text(
            "Scan QR",
            style: TextStyle(color: Colors.black),
          ),
        ),
        floatingActionButton: showFab ? const AssistFAB() : null,
        body: Builder(builder: (context) {
          return Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Select a Document',
                  style: TextStyle(fontSize: 20),
                ),
              )),
              InkWell(
                onTap: () {
                  scanQr('Degree_Template');
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: MyColors.gradient3),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: const Center(
                    child: Text(
                      "Degree",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  scanQr('Transcript_Template');
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: MyColors.gradient3),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: const Center(
                    child: Text(
                      "Transcript",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  scanQr('Provisional_Template');
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: MyColors.gradient3),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: const Center(
                    child: Text(
                      "Provisional Certificate",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  scanQr('Equivalence_Template');
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: MyColors.gradient3),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: const Center(
                    child: Text(
                      "Equivalence Certificate",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
      floatingActionButton: showFab ? const CenterDockedFAB() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
