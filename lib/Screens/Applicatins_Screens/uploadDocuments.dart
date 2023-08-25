import 'dart:io';
import 'dart:ui';

import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:hec_eservices/Screens/Applicatins_Screens/detailsOfDegree.dart';
import 'package:hec_eservices/Screens/Applicatins_Screens/questionaire.dart';
import 'package:hec_eservices/Screens/Applicatins_Screens/verifyDetails.dart';
import 'package:hec_eservices/test_Screen/ImageGallery.dart';

import '../../Models/UserModel.dart';
import '../../Widgets/bottomNav.dart';
import '../../Widgets/bottomSheet.dart';
import '../../Widgets/fab.dart';
import '../../utils/MyColors.dart';
import '../homepage.dart';
import '../notificationPage.dart';
import '../profile.dart';

class UploadDocs extends StatefulWidget {
  const UploadDocs({Key? key}) : super(key: key);

  @override
  _UploadDocsState createState() => _UploadDocsState();
}

class _UploadDocsState extends State<UploadDocs> {
  var AttestationMode = TextEditingController();
  var District = TextEditingController();
  int selectedEducationIndex = 0;
  var pageController = PageController();
  var flexibleKey = GlobalKey();
  int selectedMode = 2;
  int originalSum = 0;
  int copySum = 0;
  int currentPage = 0;
  var Modes = ["Yes", "No"];
  bool nextButtonEnabled = false;
  int QuestionsAnswered = 0;
  var others = TextEditingController();
  var otherDocuments = [
    "Stamped Paper",
    "Certified true copies of Admission/Registration form",
    "Award list/Result statement",
    "PMDC for MBBS",
    "PEC for Engineering Students",
    "Industrial Training Certificate for B-TECH students",
    "Supplementary form",
    "Affidevit/Merriage Certificate",
    "Session Clash Letter",
    "Proof of Registration/Accreditation of Professional Body/Council",
    "Proof of PCD (Phd country Directory)",
    "Correction Letter from University",
    "Verification Letter from University",
    "Others"
  ];

  @override
  Widget build(BuildContext context) {
    var imagePath;
    var downloadUrl;

    void uploadDocument(String imageTitle)async{
      try {
        FirebaseStorage storage = FirebaseStorage.instance;
        String imageReference =
            '${UserModel.CurrentUserCnic}/documents/$imageTitle.jpg';
        Reference ref = storage.ref().child(imageReference);
        UploadTask uploadTask =
        ref.putFile(File(imagePath));
        await uploadTask.whenComplete(() async {
          print('Image uploaded successfully');
          // Get the download URL
          downloadUrl = await ref.getDownloadURL();
          setState(() {});
        });
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
    void getImage(var value,String imageTitle) async {
      if (value == 0) {
        try {
          imagePath = await DocumentScannerFlutter.launch(context,
              source: ScannerFileSource.GALLERY);
          uploadDocument(imageTitle);
          setState(() {

          });
        } on PlatformException {
        }
        setState(() {});
      } else if (value == 1) {
        downloadUrl = Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageGallery(),
          ),
        ).then((value) => Navigator.pop(context));
      } else if (value == 2) {
        try {
          imagePath = await DocumentScannerFlutter.launch(context,
              source: ScannerFileSource.CAMERA);
          uploadDocument(imageTitle);
          Navigator.pop(context);
          // Or ScannerFileSource.GALLERY
          // `scannedDoc` will be the image file scanned from scanner
        } on PlatformException {
          // 'Failed to get document path or operation cancelled!';
        }
        setState(() {});

      }
    }

    void showImageSelectorBottomSheet(BuildContext context, String imageTitle) async {
      int selectedIndex = 0;
      await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    color: Colors.white),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Pick Image From',
                          style: TextStyle(fontSize: 20),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close))
                      ],
                    ),
                    SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              onTap: () {
                                selectedIndex = 0;
                                getImage(selectedIndex,imageTitle);
                              },
                              title: const Text("Upload From Gallery"),
                              leading: const Icon(Icons.image),
                            ),
                            ListTile(
                              onTap: () {
                                selectedIndex = 1;
                                getImage(selectedIndex,imageTitle);
                              },
                              title: const Text("Load From Libary"),
                              leading: const Icon(Icons.file_copy),
                            ),
                            ListTile(
                              onTap: () {
                                selectedIndex = 2;
                                getImage(selectedIndex,imageTitle);
                              },
                              title: const Text("Use Camera"),
                              leading: const Icon(Icons.camera),
                            ),
                          ]),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

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
                " Upload Documents",
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
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Next: Verify Details",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.black),
                    )),
              ),
              const WizardIndicator(
                selectedIndex: 3,
                length: 4,
              ),
              const SizedBox(
                height: 10,
              ),
              const OrangeInforCard(
                  text:
                      "Please ensure to upload readable scanned copies of CNIC, Degree(s) along with transcript (s) and other documents (case to case basis)"),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Personal Document",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.black),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              const OrangeInforCard(
                  text:
                      "Note: Please upload the document only in png, jpg or pdf format."),
              const SizedBox(
                height: 10,
              ),
              UploadDocTile(
                Title: "Copy Of CNIC FRONT",
                onPressed: () {
                  showImageSelectorBottomSheet(context,'cnic_front');
                },
              ),
              UploadDocTile(
                Title: "Copy Of CNIC BACK",
                onPressed: () {
                  showImageSelectorBottomSheet(context,'cnic_back');
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Education Document",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.black),
                  ),
                ),
              ),
              UploadDocTile(
                NoOfDocs: 2,
                Title:
                    "Bachelor (16 Years) Degree BS in Software Engineering - Copy of Degree",
                onPressed: () {
                  showImageSelectorBottomSheet(context, 'degree_copy');
                },
              ),
              UploadDocTile(
                Title:
                    "Bachelor (16 Years) Degree BS in Software Engineering - Copy of Transcript",
                onPressed: () {
                  showImageSelectorBottomSheet(context,'transcript_copy');
                },
              ),
              UploadDocTile(
                Title:
                    "Bachelor (16 Years) Degree - BS in Software Engineering - Copy of Provisional Certificate",
                onPressed: () {
                  showImageSelectorBottomSheet(context,'provisional_certificate_copy');
                },
              ),
              UploadDocTile(
                Title:
                    "Bachelor (16 Years) Degree - BS in Software Engineering - Copy of Equivalence Certificate",
                onPressed: () {
                  showImageSelectorBottomSheet(context,'equivalence_certificate_copy');
                },
              ),
              // Container(
              //   margin: const EdgeInsets.only(top: 10),
              //   child: Align(
              //       alignment: Alignment.centerLeft,
              //       child: Text(
              //         "Other Document",
              //         style: Theme.of(context)
              //             .textTheme
              //             .headline6!
              //             .copyWith(color: Colors.black),
              //       )),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     Expanded(
              //       flex: 7,
              //       child: Container(
              //         margin: const EdgeInsets.only(top: 10),
              //         child: TextFormField(
              //           controller: others,
              //           // ignore: prefer_const_constructors
              //           onTap: () {
              //             MyBottomSheet()
              //                 .showSearchableBottomSheet(
              //                     context, otherDocuments, "Other Documents")
              //                 .then((value) {
              //               setState(() {
              //                 others.text = otherDocuments[value];
              //               });
              //             });
              //           },
              //           readOnly: true,
              //           decoration: const InputDecoration(
              //               suffixIcon: Icon(Icons.arrow_drop_down_sharp),
              //               labelText: "Other Documents",
              //               contentPadding: EdgeInsets.all(15),
              //               border: OutlineInputBorder()),
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       flex: 3,
              //       child: GestureDetector(
              //         onTap: () {
              //           showImageSelectorBottomSheet(context);
              //         },
              //         child: const Column(
              //           children: [
              //             Icon(
              //               Icons.file_upload,
              //               color: MyColors.blueColor,
              //             ),
              //             Text("Upload")
              //           ],
              //         ),
              //       ),
              //     )
              //   ],
              // ),
              Align(
                child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const VerifyDetails();
                      }));
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
                          "Next",
                          style: TextStyle(color: Colors.white),
                        )))),
              ),
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

class UploadDocTile extends StatelessWidget {
  final String? Image;
  final String Title;

  final int? NoOfDocs;
  final VoidCallback onPressed;
  const UploadDocTile({
    required this.Title,
    this.Image,
    this.NoOfDocs,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            const BoxShadow(
                color: Colors.black12, blurRadius: 5, offset: Offset(0, 3))
          ]),
      child: Tooltip(
        message: Title,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 40,
              height: 20,
              child: const Icon(
                Icons.image,
                color: Colors.black38,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Title,
                    style: const TextStyle(fontSize: 16),
                    maxLines: NoOfDocs != null ? 1 : 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (NoOfDocs != null)
                    const SizedBox(
                      height: 10,
                    ),
                  if (NoOfDocs != null)
                    Text(
                      "No. of Document $NoOfDocs",
                      style: Theme.of(context).textTheme.caption,
                    ),
                ],
              ),
            ),
            InkWell(
              onTap: onPressed,
              child: CircleAvatar(
                backgroundColor: Colors.blueGrey[50],
                child: const Icon(
                  Icons.file_upload,
                  color: MyColors.blueColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
