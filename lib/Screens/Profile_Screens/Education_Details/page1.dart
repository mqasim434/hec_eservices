import 'package:flutter/material.dart';
import 'package:hec_eservices/Models/UserModel.dart';
import 'package:intl/intl.dart';

import '../../../Widgets/bottomSheet.dart';
import '../../../Widgets/rectangleToggle.dart';
import '../../../utils/MyColors.dart';
import 'package:hec_eservices/Models/EducationModel.dart';

class Page1 extends StatefulWidget {
  final Function onPressed;
  const Page1({ Key? key,required this.onPressed }) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  int selectedTabIndex = 0;
  bool isComplete = false;
  bool isEnrolled = false;

  var Qualification = TextEditingController();
  var DateStart = TextEditingController();
  var ExactName = TextEditingController();
  var DateEnd = TextEditingController();
  var QualificationLevels = [
    "Bachelor (14 Years) Degree",
    "Bachelor (15 Years) Degree",
    "Bachelor (16 Years) Degree",
    "Master (16 Years) Degree",
    "Master (17 Years) Degree",
    "Master/ MS (18 Years) Degree",
    "M-Phill (18 Years) Degree",
    "MS Leading to PHD (14 Years) Degree",
    "PGD"
  ];
  var EducationStatus = ["Complete", "Incomplete"];
  int selectedEducationIndex = 0;
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(

        children: [

          // EDUCATION TEXT
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Qualification",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black),
                )),
          ),
          // QUALIFICATION LEVEL
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: Qualification,
              // ignore: prefer_const_constructors
              onTap: () {
                MyBottomSheet()
                    .showSearchableBottomSheet(
                    context, QualificationLevels, "Qualification Level")
                    .then((value) {
                  setState(() {
                    Qualification.text = QualificationLevels[value];
                  });
                });
              },
              readOnly: true,
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                  labelText: "Qualification Level",
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder()),
            ),
          ),
          // EDUCATION TEXT
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "EDUCATION",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.black),
                )),
          ),
          // MARITAL STATUS TOGGLES
          Container(
            margin: const EdgeInsets.only(left: 2),
            child: Row(
              children: List.generate(EducationStatus.length, (index) {
                return RectangleToggleButton2(
                  Label: EducationStatus[index],
                  selected: selectedEducationIndex == index ? true : false,
                  onSelected: (value) {
                    setState(() {
                      print("index:index");
                      selectedEducationIndex = index;
                    });
                  },
                );
              }),
            ),
          ),
          // START FIELD
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: DateStart,
              readOnly: true,
              onTap: () {
                showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 100),
                    lastDate: DateTime.now())
                    .then((value) {
                  setState(() {
                    //selectedDateOfBirth=value;
                    DateStart.text =
                        DateFormat("dd, MMMM yyyy").format(value!);
                  });
                });
              },
              decoration: const InputDecoration(
                  labelText: "Start Date",
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder()),
            ),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                isEnrolled=!isEnrolled;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10,right: 10,bottom: 10),
                  height: 20,
                  width: 24,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        activeColor: MyColors.greenColor,
                        value: isEnrolled, onChanged: (value){
                      setState(() {
                        isEnrolled=value!;
                      });
                    }),
                  ),
                ),
                const Text("Currently Enrolled")
              ],
            ),
          ),
          // EXPECTED END FIELD
          Container(
            child: TextFormField(
              controller: DateEnd,
              readOnly: true,
              onTap: () {
                showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 100),
                    lastDate: DateTime.now())
                    .then((value) {
                  setState(() {
                    //selectedDateOfBirth=value;
                    DateEnd.text =
                        DateFormat("dd, MMMM yyyy").format(value!);
                  });
                });
              },
              decoration: const InputDecoration(
                  labelText: "Expected End Date",
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder()),
            ),
          ),
          // Name on Degree
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: TextFormField(
              controller: ExactName,
              decoration: const InputDecoration(
                  labelText: "Name on Degree",
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder()),
            ),
          ),
          // DEGREE NAME EXACT
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Please enter your exact name as written on degree",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.black),
                )),
          ),
          Align(
            child: InkWell(
                onTap: (){
                  addData();
                  widget.onPressed();
                }, child: Container(
                width: double.maxFinite,
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: MyColors.gradient3
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: const Center(child: Text("Next",style: TextStyle(color: Colors.white),)))),
          ),
        ],
      ),
    );
  }

  void addData(){
    String qualificationLevel = Qualification.text.toString();
    String education;
    if(selectedEducationIndex==0){
      education = 'Complete';
    }
    else{
      education = 'Incomplete';
    }
    String startDate = DateStart.text.toString();
    String endDate = DateEnd.text.toString();
    bool currentlyEnrolled = isEnrolled;
    String nameOnDegree = ExactName.text.toString();

    educationModel.userCnic = UserModel.CurrentUserCnic.toString();
    educationModel.qualificationLevel = qualificationLevel;
    educationModel.education = education;
    educationModel.startDate = startDate;
    educationModel.currentlyEnrolled = currentlyEnrolled.toString();
    educationModel.endDate = endDate;
    educationModel.nameOnDegree = nameOnDegree;
  }
}