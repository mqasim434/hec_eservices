import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hec_eservices/Models/EducationModel.dart';
import 'package:hec_eservices/Models/UserModel.dart';

import '../../../utils/config.dart';
import '../../../utils/MyColors.dart';
import 'package:http/http.dart' as http;

class Page3 extends StatefulWidget {
  final Function onPressed;
  Page3({Key? key, required this.onPressed}) : super(key: key);

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  var RegistrationNo = TextEditingController();

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
                  "Degree",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black),
                )),
          ),

          // Area of Research
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextFormField(
              controller: RegistrationNo,
              // ignore: prefer_const_constructors

              decoration: const InputDecoration(
                  labelText: "Registration / Roll No",
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder()),
            ),
          ),
          Align(
            child: InkWell(
              onTap: () {
                addData();
                widget.onPressed();
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
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addData() {
    String rollNo = RegistrationNo.text.toString();
    educationModel.rollNo = rollNo;
    Random random = Random();
    var url =
        "$baseUrl/addEducationData";
    var endPoint = Uri.parse(url);

    var response = http.post(
      endPoint,
      body: {
        "recordId" : (random.nextInt(100) + 1).toString(),
        "userCnic" : educationModel.userCnic,
        "qualificationLevel" : educationModel.qualificationLevel,
        "education" : educationModel.education,
        "startDate" : educationModel.startDate,
        "currentlyEnrolled" : educationModel.currentlyEnrolled,
        "expectedEndDate" : educationModel.endDate,
        "nameOnDegree" : educationModel.nameOnDegree,
        "country" : educationModel.country,
        "degreeAwardInstitute" : educationModel.degreeAwardInstitute,
        "programTitle" : educationModel.programTitle,
        "universityName" : educationModel.universityName,
        "campus" : educationModel.campus,
        "department" : educationModel.department,
        "degreeType" : educationModel.degreeType,
        "sessionType" : educationModel.sessionType,
        "areaOfResearch" : educationModel.areaOfResearch,
        "rollNo" : educationModel.rollNo
      },
    );
  }
}
