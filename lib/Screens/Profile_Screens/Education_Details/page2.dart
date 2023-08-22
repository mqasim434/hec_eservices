import 'package:flutter/material.dart';

import '../../../Models/EducationModel.dart';
import '../../../Widgets/bottomSheet.dart';
import '../../../utils/MyColors.dart';

class Page2 extends StatefulWidget {
  final Function onPressed;
  Page2({ Key? key,required this.onPressed }) : super(key: key);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  var Countries=["Pakistan","Australia","Turkey","NewZealand"];
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
  var Institutes = [
    "Allama Iqbal Open University, Islamabad",
    "Bacha Khan University, Charsadda",
    "COMSATS University, Islamabad",
    "Darul Uloom, Karachi",
    "Fatima Jinnah Medical University, Lahore",
    "Hamdard University, Karachi",
    "Islamia University, Bahawalpur",
    "Kind Edward Medical University, Lahore",
    "National College of Arts, Lahore",
    "University of Gujrat, Gujrat",
    "University of Jhang",
    "University of Wah, Wah"
        "Women University, Mardan"
  ];
  var Degrees = [
    "B. Arch",
    "B.Com",
    "B.Sc (PASS)",
    "BA","BSc","BSSE","Bachelor of Arts", "Bachelor of Commerce","Bachelor of Science",
    "Associate Degree in Hotel and Restaurant Managen"
  ];
  var Campuses = [
    "Hafiz Hayat Campus",
    "Fawara Chowk Campus",
    "City Campus",
    "Marghazar Campus",

  ];
  var Departments = [
    "Department of Software Engineering",
    "Department of Computer Science",
    "Department of Information Technolony",
  ];
  var DegreeTypes = [
    "Regular",
  ];
  var Sessions = [
    "Morning",
    "Evening",
    "Weekend",
  ];
  var Country=TextEditingController();
  var QualificationLevel=TextEditingController();
  var Institute2=TextEditingController();
  var Institute=TextEditingController();
  var Degree=TextEditingController();
  var Campus=TextEditingController();
  var Department=TextEditingController();
  var DegreeType=TextEditingController();
  var Session=TextEditingController();
  var AreaOfResearch=TextEditingController();


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
                  "Degree Awarding Institute",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black),
                )),
          ),
          // COUNTRY
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextFormField(
              controller: Country,
              // ignore: prefer_const_constructors
              onTap: () {
                MyBottomSheet()
                    .showSearchableBottomSheet(
                    context, Countries, "Country")
                    .then((value) {
                  setState(() {
                    Country.text = Countries[value];
                  });
                });
              },
              readOnly: true,
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                  labelText: "Country",
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder()),
            ),
          ),
          // Degree Awarding Istitute
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextFormField(
              controller: Institute2,
              // ignore: prefer_const_constructors
              onTap: () {
                MyBottomSheet()
                    .showSearchableBottomSheet(
                    context, Institutes, "Degree Award Institute")
                    .then((value) {
                  setState(() {
                    Institute2.text = Institutes[value];
                  });
                });
              },
              readOnly: true,
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                  labelText: "Degree Award Institute",
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder()),
            ),
          ),
          // Program Title
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextFormField(
              controller: Degree,
              // ignore: prefer_const_constructors
              onTap: () {
                MyBottomSheet()
                    .showSearchableBottomSheet(
                    context, Degrees, "Program Title")
                    .then((value) {
                  setState(() {
                    Degree.text = Degrees[value];
                  });
                });
              },
              readOnly: true,
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                  labelText: "Program Title",
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder()),
            ),
          ),
          // University Name on Degree
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextFormField(
              controller: Institute2,
              // ignore: prefer_const_constructors
              onTap: () {
                MyBottomSheet()
                    .showSearchableBottomSheet(
                    context, Institutes, "University Name on Degree")
                    .then((value) {
                  setState(() {
                    Institute2.text = Institutes[value];
                  });
                });
              },
              readOnly: true,
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                  labelText: "University Name on Degree",
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder()),
            ),
          ),
          // Campus
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextFormField(
              controller: Campus,
              // ignore: prefer_const_constructors
              onTap: () {
                MyBottomSheet()
                    .showSearchableBottomSheet(
                    context, Campuses, "Campus")
                    .then((value) {
                  setState(() {
                    Campus.text = Campuses[value];
                  });
                });
              },
              readOnly: true,
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                  labelText: "Campus",
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder()),
            ),
          ),
          // Department
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextFormField(
              controller: Department,
              // ignore: prefer_const_constructors
              onTap: () {
                MyBottomSheet()
                    .showSearchableBottomSheet(
                    context, Departments, "Department")
                    .then((value) {
                  setState(() {
                    Department.text = Departments[value];
                  });
                });
              },
              readOnly: true,
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                  labelText: "Department",
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder()),
            ),
          ),
          // Degree Type
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextFormField(
              controller: DegreeType,
              // ignore: prefer_const_constructors
              onTap: () {
                MyBottomSheet()
                    .showSearchableBottomSheet(
                    context, DegreeTypes, "Degree Type")
                    .then((value) {
                  setState(() {
                    DegreeType.text = DegreeTypes[value];
                  });
                });
              },
              readOnly: true,
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                  labelText: "Degree Type",
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder()),
            ),
          ),
          // Session Type
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextFormField(
              controller: Session,
              // ignore: prefer_const_constructors
              onTap: () {
                MyBottomSheet()
                    .showSearchableBottomSheet(
                    context, Sessions, "Session Type")
                    .then((value) {
                  setState(() {
                    Session.text = Sessions[value];
                  });
                });
              },
              readOnly: true,
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                  labelText: "Session Type",
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder()),
            ),
          ),

          // Area of Research
          Container(
            margin: const EdgeInsets.only(top: 20),

            child: TextFormField(
              controller: AreaOfResearch,
              // ignore: prefer_const_constructors

              decoration: const InputDecoration(

                  labelText: "Area of Research",
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder()),
            ),
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
          const SizedBox(height: 70,)

        ],

      ),
    );
  }

  void addData() {
    String country = Country.text.toString();
    String degreeAwardInstitute = Institute2.text.toString();
    String programTitle = Degree.text.toString();
    String universityName = Country.text.toString();
    String campus = Institute.text.toString();
    String department = Department.text.toString();
    String degreeType = DegreeType.text.toString();
    String sessionType = Session.text.toString();
    String areaOfResearch = AreaOfResearch.text.toString();

    educationModel.country = country;
    educationModel.degreeAwardInstitute = degreeAwardInstitute;
    educationModel.programTitle = programTitle;
    educationModel.universityName = universityName.toString();
    educationModel.campus = campus;
    educationModel.department = department;
    educationModel.degreeType = degreeType;
    educationModel.sessionType = sessionType;
    educationModel.areaOfResearch = areaOfResearch;
  }
}