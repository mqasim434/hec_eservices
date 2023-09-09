import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:hec_eservices/Screens/Applicatins_Screens/detailsOfDegree.dart';
import 'package:hec_eservices/Screens/Applicatins_Screens/questionaire.dart';
import 'package:hec_eservices/Screens/Applicatins_Screens/verifyDetails.dart';
import 'package:hec_eservices/Screens/Degree_Verification/placeQR.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../Models/UserModel.dart';
import '../../Widgets/bottomNav.dart';
import '../../Widgets/fab.dart';
import '../../utils/MyColors.dart';
import '../Navbar_Screens/dashboard.dart';
import '../Navbar_Screens/notificationPage.dart';
import '../Navbar_Screens/profile.dart';

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
    var downloadUrl;
    final ImagePicker _imagePicker = ImagePicker();

    Future<void> uploadDocument(String imageTitle, XFile? scannedDocument) async {
      final userCnic = UserModel.CurrentUserCnic;

      final databaseRef = imageTitle.contains('cnic')
          ? '$userCnic/cnic/$imageTitle.jpg'
          : '$userCnic/documents/$imageTitle.jpg';

      final Reference storageRef = FirebaseStorage.instance.ref(databaseRef);
      try {

        await storageRef.putFile(
          File(scannedDocument!.path),
          SettableMetadata(contentType: 'image/jpeg'),
        );

        final String url = await storageRef.getDownloadURL();
        setState(() {
          downloadUrl = url;

        });
      } catch (error) {
        print('Error uploading document: $error');
      }
      if(imageTitle=='cnic_front'){
        UserModel.applicationData['cnicFront'] = downloadUrl;
      }
      else if(imageTitle=='cnic_back'){
        UserModel.applicationData['cnicBack'] = downloadUrl;
      }
    }

      Future<void> _pickDocument(int pickerIndex,String documentTitle,int index,String templateType) async {
      if(pickerIndex==0){
        final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          if(!(documentTitle.contains('cnic'))){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PlaceQR(
              imageFile: File(image.path.toString()),
              upload:uploadDocument(documentTitle, image),
              index: index,
              templateType: templateType.toString(),
            )));
            print("????????????? ${templateType.toString()}");
          }
          else{
            await uploadDocument(documentTitle, image);
          }
        }
      }
      else{
        final XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
        if (image != null) {
          await uploadDocument(documentTitle, image);
        }
      }
    }

    void showImageSelectorBottomSheet(
        BuildContext context, String imageTitle,int index,String templateType) async {
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
                                _pickDocument(selectedIndex, imageTitle,index,templateType);
                              },
                              title: const Text("Upload From Gallery"),
                              leading: const Icon(Icons.image),
                            ),
                            ListTile(
                              onTap: () {
                                selectedIndex = 1;
                                _pickDocument(selectedIndex, imageTitle,index,templateType);
                              },
                              title: const Text("Load From Libary"),
                              leading: const Icon(Icons.file_copy),
                            ),
                            ListTile(
                              onTap: () {
                                selectedIndex = 2;
                                _pickDocument(selectedIndex, imageTitle,index,templateType);
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
                  showImageSelectorBottomSheet(context, 'cnic_front',-1,'none');
                },
              ),
              UploadDocTile(
                Title: "Copy Of CNIC BACK",
                onPressed: () {
                  showImageSelectorBottomSheet(context, 'cnic_back',-1,'none');
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Education Documents",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.black),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 10),
                height: UserModel.degrees.length * 300,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: UserModel.degrees.length,
                    itemBuilder: (context, index) {
                      final data = UserModel.degrees[index];
                      return Column(
                        children: [
                          UploadDocTile(
                              Title:
                              '${data['qualificationLevel']} - Degree',
                              onPressed: () {
                                showImageSelectorBottomSheet(context, 'degree',index,'Degree_Template');
                              }),
                          UploadDocTile(
                              Title:
                              '${data['qualificationLevel']} - Transcript',
                              onPressed: () {
                                showImageSelectorBottomSheet(context, 'transcript',index,'Transcript_Template');
                              }),
                          UploadDocTile(
                              Title:
                              '${data['qualificationLevel']} - Provisional Certificate',
                              onPressed: () {
                                showImageSelectorBottomSheet(context, 'provisional_certificate',index,'Provisional_Template');
                              }),
                          UploadDocTile(
                              Title:
                              '${data['qualificationLevel']} - Equivalence Certificate',
                              onPressed: () {
                                showImageSelectorBottomSheet(context, 'equivalence_certificate',index,'Equivalence_Template');
                              }),
                        ],
                      );
                    }),
              ),
              Align(
                child: InkWell(
                    onTap: () {
                      print(UserModel.applicationData);
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
