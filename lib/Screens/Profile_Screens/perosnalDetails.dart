import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../Models/UserModel.dart';
import '../../Widgets/bottomNav.dart';
import '../../Widgets/fab.dart';
import '../../Widgets/informationCard.dart';
import '../../Widgets/rectangleToggle.dart';
import '../../utils/config.dart';
import '../homepage.dart';
import '../notificationPage.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  bool isLoading = true;
  int selectedGenderIndex = 0;
  int selectedMaritalIndex = 0;
  bool isEditing = false;
  var DOB = TextEditingController();

  var genders = [
    {"Label": "Male", "svg": "assets/icons/male.svg"},
    {"Label": "Female", "svg": "assets/icons/female.svg"},
    {"Label": "Other", "svg": "assets/icons/female.svg"},
  ];

  var maritalStatus = [
    {"Label": "Single", "svg": "assets/icons/Single.svg"},
    {"Label": "Married", "svg": "assets/icons/married.svg"},
  ];

  Map<String, String> updatedData = {};

  UserModel currentUser = UserModel();

  Future<dynamic> getUserData() async {
    try {
      var cnic = UserModel.CurrentUserCnic.toString();
      var endPoint = "$baseUrl/getUser/$cnic";
      var url = Uri.parse(endPoint);
      var user = await http.get(url);
      if (user.statusCode == 200) {
        currentUser = UserModel.fromJson(json.decode(user.body));
        setState(() {
          isLoading = false;
        });
      } else {
        print('User Not Found');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateData() async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/update/${currentUser.cnic}'),
        body: updatedData,
      );
      if (response.statusCode == 200) {
        // Data updated successfully
        print('Data updated successfully');
        isLoading = false;
      } else {
        // Failed to update data
        print('Failed to update data');
      }
    } catch (e) {
      // Handle errors
      print('Error: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // Initialize selectedGenderIndex and selectedMaritalIndex based on currentUser data
    if (currentUser.gender == 'Male') {
      selectedGenderIndex = 0;
    } else if (currentUser.gender == 'Female') {
      selectedGenderIndex = 1;
    } else if (currentUser.gender == 'Other') {
      selectedGenderIndex = 2;
    }

    if (currentUser.maritalStatus == 'Single') {
      selectedMaritalIndex = 0;
    } else if (currentUser.maritalStatus == 'Married') {
      selectedMaritalIndex = 1;
    }
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        actions: [
          if (isEditing)
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                updateData();
                getUserData();
                setState(() {
                  isEditing = false;
                });
              },
            )
        ],
        elevation: 0,
        backgroundColor: Colors.blueGrey[50],
        title: const Text(
          "Personal Details",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              floatingActionButton: showFab ? const AssistFAB() : null,
              body: Container(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      !isEditing
                          ?
                          //INFROMATION CARD
                          InformationCard(
                              showButton: true,
                              onPressed: () {
                                setState(() {
                                  isEditing = true;
                                });
                              },
                              data: {
                                "First Name": currentUser.firstName.toString(),
                                "Last Name": currentUser.lastName.toString(),
                                "Father's Name":
                                    currentUser.fatherName.toString(),
                                "Gender": currentUser.gender.toString(),
                                "Marital Status":
                                    currentUser.maritalStatus.toString(),
                                "Date of Birth":
                                    currentUser.dateOfBirth.toString(),
                              },
                              title: "Personal Details",
                            )
                          //FORM
                          : Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 48,
                                  child: Row(
                                    children: [
                                      // TITLE DROP DOWN
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          child: DropdownButtonFormField(
                                              iconSize: 20,
                                              decoration: const InputDecoration(
                                                  labelText: "Title",
                                                  contentPadding:
                                                      EdgeInsets.all(15),
                                                  border: OutlineInputBorder()),
                                              items: const [
                                                DropdownMenuItem(
                                                  value: 0,
                                                  child: Text("Mr."),
                                                ),
                                                DropdownMenuItem(
                                                  value: 1,
                                                  child: Text("Dr."),
                                                ),
                                                DropdownMenuItem(
                                                  value: 2,
                                                  child: Text("Ms."),
                                                ),
                                                DropdownMenuItem(
                                                  value: 3,
                                                  child: Text("Engr."),
                                                ),
                                              ],
                                              onChanged: (value) {}),
                                        ),
                                      ),
                                      // FIRST NAME FIELD
                                      Expanded(
                                        flex: 7,
                                        child: TextFormField(
                                          onChanged: (value) {
                                            updatedData['firstName'] = value;
                                          },
                                          decoration: InputDecoration(
                                              labelText:
                                                  currentUser.firstName !=
                                                          'null'
                                                      ? currentUser.firstName
                                                      : "First Name",
                                              contentPadding:
                                                  EdgeInsets.all(15),
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // LAST NAME FIELD
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      updatedData['lastName'] = value;
                                    },
                                    decoration: InputDecoration(
                                        labelText:
                                            currentUser.lastName != 'null'
                                                ? currentUser.lastName
                                                : "Last Name",
                                        contentPadding: EdgeInsets.all(15),
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                // GENDER TEXT
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Gender",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(color: Colors.black),
                                      )),
                                ),
                                // GENDER TOGGLES
                                Row(
                                  children:
                                      List.generate(genders.length, (index) {
                                    return RectangleToggleButton(
                                      Label: genders[index]["Label"]!,
                                      svg: genders[index]["svg"]!,
                                      selected: selectedGenderIndex == index
                                          ? true
                                          : false,
                                      onSelected: (value) {
                                        setState(() {
                                          print("index:$index");
                                          selectedGenderIndex = index;
                                          if (index == 0) {
                                            updatedData['gender'] = 'Male';
                                          } else if (index == 1) {
                                            updatedData['gender'] = 'Female';
                                          } else if (index == 2) {
                                            updatedData['gender'] = 'Other';
                                          }
                                        });
                                      },
                                    );
                                  }),
                                ),
                                // MARITAL STATUS TEXT
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Marital Status",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(color: Colors.black),
                                      )),
                                ),
                                // MARITAL STATUS TOGGLES
                                Row(
                                  children: List.generate(maritalStatus.length,
                                      (index) {
                                    return RectangleToggleButton(
                                      Label: maritalStatus[index]["Label"]!,
                                      svg: maritalStatus[index]["svg"]!,
                                      selected: selectedMaritalIndex == index
                                          ? true
                                          : false,
                                      onSelected: (value) {
                                        if (selectedMaritalIndex == 0) {
                                          updatedData['maritalStatus'] =
                                              'Single';
                                        } else if (selectedMaritalIndex == 1) {
                                          updatedData['maritalStatus'] =
                                              'Married';
                                        }
                                        setState(() {
                                          print("index:$index");
                                          selectedMaritalIndex = index;
                                        });
                                      },
                                    );
                                  }),
                                ),
                                // DOB FIELD
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: TextFormField(
                                    controller: DOB,
                                    readOnly: true,
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(
                                                  DateTime.now().year - 100),
                                              lastDate: DateTime.now())
                                          .then((value) {
                                        setState(() {
                                          DOB.text = DateFormat("dd, MMMM yyyy")
                                              .format(value!);
                                          updatedData['dateOfBirth'] =
                                              DOB.text.toString();
                                        });
                                      });
                                    },
                                    decoration: InputDecoration(
                                        labelText:
                                            currentUser.dateOfBirth != 'null'
                                                ? currentUser.dateOfBirth
                                                : "Date of Birth",
                                        contentPadding: EdgeInsets.all(15),
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                                // FATHER NAME FIELD
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      updatedData['fatherName'] = value;
                                    },
                                    decoration: InputDecoration(
                                        labelText:
                                            currentUser.fatherName != 'null'
                                                ? currentUser.fatherName
                                                : "Father Name",
                                        contentPadding: EdgeInsets.all(15),
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ],
                            ),
                      const SizedBox(
                        height: 10,
                      ),

                      // INFORMATION CARD
                      InformationCard(
                        type: InformationCardType.Row,
                        onPressed: () {},
                        data: {
                          "Country": currentUser.country.toString(),
                          "CNIC": currentUser.cnic.toString(),
                        },
                        title: "National ID Information",
                      ),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButtonLocation: const FixedCenterDockedFabLocation(),
      floatingActionButton: showFab ? const CenterDockedFAB() : null,
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
          }),
    );
  }
}
