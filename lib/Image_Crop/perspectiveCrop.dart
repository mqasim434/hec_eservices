import 'dart:io';

import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hec_eservices/Models/UserModel.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Screens/homepage.dart';
import '../Screens/notificationPage.dart';
import '../Screens/profile.dart';
import '../Widgets/bottomNav.dart';
import '../Widgets/bottomSheet.dart';
import '../Widgets/fab.dart';
import '../utils/MyColors.dart';

class PerspectiveCrop extends StatefulWidget {
  const PerspectiveCrop({Key? key}) : super(key: key);

  @override
  _PerspectiveCropState createState() => _PerspectiveCropState();
}

class _PerspectiveCropState extends State<PerspectiveCrop> {
  File? newFile;
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
                    var result = await MyBottomSheet()
                        .showImageSelectorBottomSheet(context)
                        .then((value) async {
                      if (value == 0) {
                        try {
                          newFile = await DocumentScannerFlutter.launch(context,
                              source: ScannerFileSource.CAMERA);
                          // Or ScannerFileSource.GALLERY
                          // `scannedDoc` will be the image file scanned from scanner
                        } on PlatformException {
                          // 'Failed to get document path or operation cancelled!';
                        }
                        setState(() {});
                      } else {
                        try {
                          newFile = await DocumentScannerFlutter.launch(context,
                              source: ScannerFileSource.GALLERY);
                          // Or ScannerFileSource.GALLERY
                          // `scannedDoc` will be the image file scanned from scanner
                        } on PlatformException {
                          // 'Failed to get document path or operation cancelled!';
                        }
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
                    onTap: () async {
                      // var template =
                      // Provider.of<MyTemplate>(context, listen: false);

                      if (newFile != null) {
                        // template.SimpleImage = await newFile!.readAsBytes();
                        // Navigator.push(context,
                        // MaterialPageRoute(builder: (conetext) {
                        //   return CreateOrVerify();
                        // }));
                        try {
                          FirebaseStorage storage = FirebaseStorage.instance;
                          String imagePath =
                              '${UserModel.CurrentUserCnic}/documents/${DateTime.now().millisecondsSinceEpoch}.jpg';
                          Reference ref = storage.ref().child(imagePath);
                          UploadTask uploadTask =
                              ref.putFile(File(newFile!.path));
                          await uploadTask.whenComplete(() async {
                            print('Image uploaded successfully');

                            // Get the download URL
                            var downloadUrl = await ref.getDownloadURL();

                            setState(() {});
                          });
                        } catch (e) {
                          print('Error uploading image: $e');
                        }
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
                          "Next",
                          style: TextStyle(color: Colors.white),
                        )))),
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
