import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:hec_eservices/Screens/Applicatins_Screens/detailsOfDegree.dart';
import 'package:hec_eservices/Screens/Applicatins_Screens/questionaire.dart';

import '../../Widgets/bottomNav.dart';
import '../../Widgets/bottomSheet.dart';
import '../../Widgets/fab.dart';
import '../../Widgets/rectangleToggle.dart';
import '../../utils/MyColors.dart';
import '../homepage.dart';
import '../notificationPage.dart';
import '../profile.dart';

class AttestationDetails extends StatefulWidget {
  const AttestationDetails({Key? key}) : super(key: key);

  @override
  _AttestationDetailsState createState() => _AttestationDetailsState();
}

class _AttestationDetailsState extends State<AttestationDetails> {
  var AttestationMode = TextEditingController();
  var District = TextEditingController();
  int selectedMode = 0;
  var Modes = ["Inside Pakistan", "Outside Pakistan"];
  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;

    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          backgroundColor: Colors.blueGrey[50],
          title: Row(
            children: const [
              Icon(FontAwesome.doc_text),
              Text(
                " Attestation Details",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        floatingActionButton: showFab?const AssistFAB():null,
        body: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Next: Documents Details",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Colors.black),
                      )),
                ),
                const WizardIndicator(
                  selectedIndex: 0,
                  length: 4,
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black12,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: AttestationMode,
                    // ignore: prefer_const_constructors
                    onTap: () {
                      MyBottomSheet()
                          .showSearchableBottomSheet(
                          context,
                          [
                            'Attestation Through Courrier',
                            'Walk-In Attestation'
                          ],
                          "Qualification Level")
                          .then((value) {
                        setState(() {
                          AttestationMode.text = [
                            'Attestation Through Courrier',
                            'Walk-In Attestation'
                          ][value];
                        });
                      });
                    },
                    readOnly: true,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                        labelText: "Attestation Mode",
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: List.generate(Modes.length, (index) {
                    return RectangleToggleButton(
                      Label: Modes[index],
                      selected: selectedMode == index ? true : false,
                      onSelected: (value) {
                        setState(() {

                          selectedMode = index;
                        });
                      },
                      svg: 'assets/cnic.svg',
                    );
                  }),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: District,
                  // ignore: prefer_const_constructors
                  onTap: () {
                    MyBottomSheet()
                        .showSearchableBottomSheet(
                        context,
                        [
                          'Gujranwala',
                          'Lahore'
                        ],
                        "District")
                        .then((value) {
                      setState(() {
                        District.text = [
                          'Gujranwala',
                          'Lahore'
                        ][value];
                      });
                    });
                  },
                  readOnly: true,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                      labelText: "District",
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                const OrangeInforCard(
                    text:
                    "Please carefully select the district from where you would send your document for attestation through courier Service. Wrong selection of a district may result in rejection of your case at a later stage."),
                Align(
                  child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return const Questionaire();
                        }));
                      }, child: Container(
                      width: double.maxFinite,
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: MyColors.gradient3
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: const Center(child: Text("Next",style: TextStyle(color: Colors.white),)))),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton:showFab? CenterDockedFAB():null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: MyBottomNav(
          initialSelectedIndex: 3,
          onSeleted: (index) {
            if (index != 3) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return index == 0
                        ?  MyHomePage()
                        : index == 1
                        ? const ProfilePage()
                        : const NotificationPage();
                  }));
            }
          }),
    );
  }
}


