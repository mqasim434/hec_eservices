import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hec_eservices/Screens/Profile_Screens/Education_Details/educationPage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Models/UserModel.dart';
import '../../Widgets/bottomNav.dart';
import '../../Widgets/fab.dart';
import '../../Widgets/informationCard.dart';
import '../../utils/MyColors.dart';
import '../../utils/config.dart';
import '../Profile_Screens/Education_Details/educationDetails.dart';
import '../homepage.dart';
import '../notificationPage.dart';
import 'attestationDetails.dart';
import 'package:http/http.dart' as http;

class DetailsofDegree extends StatefulWidget {
  const DetailsofDegree({Key? key}) : super(key: key);

  @override
  _DetailsofDegreeState createState() => _DetailsofDegreeState();
}

class _DetailsofDegreeState extends State<DetailsofDegree> {
  int selectedPageIndex = 0;
  @override
  void initState() {
    super.initState();
    UserModel.degrees!.clear();
    Future.delayed(const Duration(seconds: 1), () {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            var style = const TextStyle(color: Colors.black);
            return const InstructionDialog();
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    int? length = 0;
    return Scaffold(
      body: Scaffold(
        floatingActionButton: showFab ? const AssistFAB() : null,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          actions: [
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
          backgroundColor: Colors.blueGrey[50],
          title: const Text(
            "Detail of Degree(s)",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Please select the degree you want to get attested",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.black),
                  )),
            ),
            OrangeInforCard(
              text:
                  "This page shows details of only those qualification(s) which are attested by HEC. To view your other qualification (s), which were saved at eservices.hec gov.pks",
              onPressed: () {
                // launch("https://eservices.hec.gov.pk");
              },
              buttonText: "PLEASE CLICK HERE",
            ),
            const SizedBox(
              height: 20,
            ),

            DottedButton(
              Label: "+ Add Details of Degree",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EducationDetails(
                    isViewOnly: false,
                  );
                }));
              },
            ),
            // Degree Cards
            SizedBox(
              height: 320,
              child: FutureBuilder<List<dynamic>>(
                future:
                    EducationPage.getEducationData(UserModel.CurrentUserCnic),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Loading indicator while data is fetched
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No users found');
                  } else {
                    // Display the list of users
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data?[index];

                        return DegreeInformationCard(
                          type: DegreeInformationCardType.selectable,
                          discipline: data['department'],
                          session: data['sessionType'],
                          program: data['programTitle'],
                          university: data['universityName'],
                          title: data['qualificationLevel'],
                          onView: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return EducationDetails(
                                    isViewOnly: true, data: data);
                              }),
                            );
                          },
                          onEdit: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return EducationDetails(
                                  isViewOnly: false, data: data);
                            }));
                          },
                          onDelete: () async {
                            final cnic = UserModel.CurrentUserCnic;
                            final recordId = data['recordId'].toString();
                            final url = Uri.parse(
                                '$baseUrl/deleteEducationData/$cnic/$recordId');
                            try {
                              final response = await http.delete(url);

                              if (response.statusCode == 204) {
                                print('Education record deleted successfully.');
                              } else if (response.statusCode == 404) {
                                print('Education record not found.');
                              } else {
                                // Handle other error cases
                                print(
                                    'Failed to delete education record. Status code: ${response.statusCode}');
                              }
                            } catch (e) {
                              print('Error: $e');
                            }
                            setState(() {});
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            Align(
              child: InkWell(
                  onTap: () {
                    if (UserModel.degrees!.isEmpty) {
                      Fluttertoast.showToast(
                        msg: 'No Degree Selected',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                      );
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const AttestationDetails();
                      }));
                    }
                  },
                  child: Container(
                      width: double.maxFinite,
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
          ]),
        ),
      ),
      floatingActionButton: showFab ? const CenterDockedFAB() : null,
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
                    : MyHomePage();
          }));
        },
      ),
    );
  }
}

class InstructionDialog extends StatefulWidget {
  const InstructionDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<InstructionDialog> createState() => _InstructionDialogState();
}

class _InstructionDialogState extends State<InstructionDialog> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Instructions"),
      content: Column(
        children: [
          Expanded(
            flex: 11,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Please read the following instructions. carefully before filling in the form:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const BulletedRow(
                    bullet: "i.",
                    text:
                        "This Mobile app is meant for attestation of degrees awarded by recognized Universitites/Dgeree Awarding Institutes(DAIS) of Paksitan.",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const BulletedRow(
                    bullet: "ii.",
                    text:
                        "Degrees awarded by foreignt Universities/DAls are not attested by HEC. HEC issue equivalence letters against foreign qualifications and ONLY such equivalence letters are attested by HEC through this web portal.",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const BulletedRow(
                    bullet: "iii.",
                    text:
                        "Following documents are mandatory for attestation of degrees:",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      const Expanded(
                        flex: 9,
                        child: Column(
                          children: [
                            BulletedRow(
                              bullet: "a.",
                              text:
                                  "Duly filled, printed and signed application form ",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            BulletedRow(
                              bullet: "b.",
                              text:
                                  "Original degree along with original transcript (Degree(s) will not be attested without provision of original transcript(s)",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            BulletedRow(
                              bullet: "c.",
                              text:
                                  "Copy of CNIC or Passport (only in case of foreign national",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            BulletedRow(
                              bullet: "d.",
                              text:
                                  "Attestation Fee as mentioned on application form",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            BulletedRow(
                              bullet: "e.",
                              text:
                                  "Photocopy of all above mentioned documents",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const BulletedRow(
                    bullet: "iv.",
                    text:
                        "Please ensure that all information (name, father's name, date of birth, registration: number, degree title, marks, etc. are same on your all documents including degree, transcript, CINC, etc. However, presence/non- presence of Honorific title/caste, etc, such as Muhammad, Syed, Awan, Khan, Malik, Haji, etc. are acceptable.",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const BulletedRow(
                    bullet: "v.",
                    text:
                        "Please ensure that there is no erasing/misprint or any unreadable alphabet/word on all documents including your degree(s), transcript(s), etc.",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const BulletedRow(
                    bullet: "vi.",
                    text:
                        "Only Transcript (if degree is not issued) is attested by HEC subject to the condition that the said original transcript is verified by the Controller of Examination of concerned university on back side or provide a verified photocopy of the transcript.",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const BulletedRow(
                    bullet: "vii.",
                    text:
                        "In case your transcript/marks sheet is not issued by the examination department of University/DAI rather it has been issued by an affiliated college/institute/Department then please ensure that such transcript/marks sheet is duly countersigned by Controller of Examination of concerned University/DAI",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const BulletedRow(
                    bullet: "viii.",
                    text:
                        "HEC has authorized only TCS for transportation of educational documents of applicants across the Pakistan whot applies through Courier mode of Attestation. Therefore, please visit only authorized TCS Center nearest to your location",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const BulletedRow(
                    bullet: "ix.",
                    text:
                        "Please upload courier receipt in system (for applicants who applied for attestation. through Courier) at the earliest. Application will be rejected if Courier Receipt is not uploaded",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const BulletedRow(
                    bullet: "x.",
                    text:
                        "If your degrees are already attested by HEC, please send your original documents or photocopies of documents (degree & transcript) (front and back) duly verified by the Controller of Examination of your university, with original signatures and stamp. Your case may be rejected if above requirements are not fulfilled",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const BulletedRow(
                    bullet: "xi.",
                    text:
                        "Extra care may be exercised while selecting level of education (14 years, 16 years, 17 years, 18 years, etc.). Case will) be rejected if wrong level of education is selected",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Note: Level of MBBS, LLB, DVM, etc. is 16 years.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const BulletedRow(
                    bullet: "i.",
                    text:
                        "If you are a professional degree holder then please upload your professional registration card/certificate OR proof of accreditation of your batch/session by the relevant professional body/council such as PEC, PMDC/PMC, PCATP, PVMC, Bar Council, Nursing Council, Pharmacy Council, etc..",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const BulletedRow(
                    bullet: "ii.",
                    text:
                        "Normally it takes minimum ten working days if documents are sent for attestation through designated courier company. However, due to prevailing Covid-19 pandemic, the attestation and return of documents may take some extra time",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const BulletedRow(
                    bullet: "iii.",
                    text:
                        "The applications submitted under Urgent Attestation Service are processed and finalized on scheduled date of visit",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const BulletedRow(
                    bullet: "iv.",
                    text: "For further details please visit web link:",
                  ),
                  TextButton(
                      onPressed: () {
                        launch("https://hec.gov.pk");
                      },
                      child: const Text("CLICK HERE")),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isSelected = !isSelected;
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                        value: isSelected,
                        onChanged: (val) {
                          setState(() {
                            isSelected = val!;
                          });
                        })),
                const Expanded(
                    child: Text(
                        "I confirm that I have read and understood the above instructions in its entirety."))
              ],
            ),
          ),
          Align(
            child: InkWell(
                onTap: () {
                  if (isSelected == false) {
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Container(
                    width: double.maxFinite,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: isSelected
                            ? MyColors.gradient3
                            : MyColors.gradient2),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: const Center(
                        child: Text(
                      "Proceed",
                      style: TextStyle(color: Colors.white),
                    )))),
          ),
        ],
      ),
    );
  }
}

class BulletedRow extends StatelessWidget {
  final String bullet;
  final String text;
  const BulletedRow({
    required this.bullet,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text("$bullet"),
        ),
        Expanded(
          flex: 9,
          child: Text("$text"),
        ),
      ],
    );
  }
}

class OrangeInforCard extends StatelessWidget {
  final String text;
  final String? buttonText;
  final VoidCallback? onPressed;
  const OrangeInforCard({
    required this.text,
    this.onPressed,
    this.buttonText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.amber[50],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(color: Colors.black45),
          ),
          if (onPressed != null)
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: onPressed,
                child: Text(
                  buttonText ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: MyColors.greenColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class DottedButton extends StatelessWidget {
  final String Label;
  final VoidCallback onPressed;
  const DottedButton({
    required this.Label,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        onPressed();
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        child: DottedBorder(
          radius: const Radius.circular(5),
          borderType: BorderType.RRect,
          strokeWidth: 1,
          padding: const EdgeInsets.all(0),
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                Label,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
