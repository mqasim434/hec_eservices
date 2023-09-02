import 'dart:convert';
import 'dart:io';

import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hec_eservices/utils/config.dart';
import 'package:lottie/lottie.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:http/http.dart' as http;

import '../Screens/homepage.dart';
import '../Screens/notificationPage.dart';
import '../Screens/profile.dart';
import '../Widgets/bottomNav.dart';
import '../Widgets/bottomSheet.dart';
import '../Widgets/fab.dart';
import '../utils/MyColors.dart';
import 'package:hec_eservices/Models/TemplateModel.dart';

class VerifyDegree extends StatefulWidget {
  const VerifyDegree({Key? key}) : super(key: key);

  @override
  _VerifyDegreeState createState() => _VerifyDegreeState();
}

class _VerifyDegreeState extends State<VerifyDegree> {
  File? newFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            "Select Image",
            style: TextStyle(color: Colors.black),
          ),
        ),
        floatingActionButton: showFab ? const AssistFAB() : null,
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: newFile != null
                      ? BoxDecoration(
                          color: Colors.blueGrey[50],
                          image: DecorationImage(
                            image: FileImage(newFile!),
                          ),
                        )
                      : null,
                  child: Center(
                    child: newFile == null
                        ? Lottie.asset("assets/animations/Degree_Cropping.json",
                            reverse: true)
                        // Icon(Icons.image_search,size: 200,)
                        : null,
                  ),
                ),
              ),
              Align(
                child: GestureDetector(
                  onTap: () async {
                    await MyBottomSheet()
                        .showImageSelectorBottomSheet(context)
                        .then((value) async {
                      if (value == 0) {
                        setState(() {});
                      } else {
                        try {
                          newFile = await DocumentScannerFlutter.launch(context,
                              source: ScannerFileSource.GALLERY);
                        } on PlatformException {}
                        setState(() {});
                      }
                    });
                    print("result");
                  },
                  child: Container(
                    width: double.maxFinite,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: MyColors.gradient3,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: const Center(
                      child: Text(
                        "Pick Image",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                child: InkWell(
                  onTap: () {
                    print('verifyButton');
                    if (newFile != null) {
                      print('HELLO');
                    } else {
                      MyBottomSheet().showSnackbar(
                          context: context,
                          msg: "No Image Selected!",
                          type: SnackBarType.Alert);
                    }
                  },
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: newFile == null
                            ? MyColors.gradient2
                            : MyColors.gradient3),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: const Center(
                      child: Text(
                        "Verify",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 80)
            ],
          ),
        ),
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
                    ? MyHomePage()
                    : index == 1
                        ? const ProfilePage()
                        : const NotificationPage();
              }));
            }
          }),
    );
  }
}
