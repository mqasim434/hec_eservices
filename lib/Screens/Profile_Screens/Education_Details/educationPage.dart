import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hec_eservices/utils/config.dart';

import '../../../Models/UserModel.dart';
import '../../../Widgets/bottomNav.dart';
import '../../../Widgets/fab.dart';
import '../../../Widgets/informationCard.dart';
import '../../Applicatins_Screens/detailsOfDegree.dart';
import '../../Navbar_Screens/dashboard.dart';
import '../../Navbar_Screens/notificationPage.dart';
import 'educationDetails.dart';
import 'package:http/http.dart' as http;

class EducationPage extends StatefulWidget {
  const EducationPage({Key? key}) : super(key: key);

  static Future<List<dynamic>> getEducationData(String cnic) async {
    final response =
    await http.get(Uri.parse('$baseUrl/getEducationData/$cnic'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('No Complaint Found');
    }
  }

  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  int selectedPageIndex = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        floatingActionButton: const AssistFAB(),
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          actions: [
            TextButton(
              child: const Text("Save"),
              onPressed: () {},
            )
          ],
          backgroundColor: Colors.blueGrey[50],
          title: const Text(
            "Education Details",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            DottedButton(
                Label: "+ Add Details of Degree",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EducationDetails(isViewOnly: false);
                  }));
                }),
            // Degree Cards
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: EducationPage.getEducationData(UserModel.CurrentUserCnic),
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
                          discipline: data['department'],
                          session: data['sessionType'],
                          program: data['programTitle'],
                          university: data['universityName'],
                          title: data['qualificationLevel'],
                          onView: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return EducationDetails(
                                  isViewOnly: true, data: data);
                            }));
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
          ]),
        ),
      ),
      floatingActionButton: const CenterDockedFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: MyBottomNav(
        initialSelectedIndex: 1,
        onSeleted: (index) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return index == 0
                ? Dashboard()
                : index == 2
                    ? const NotificationPage()
                    : Dashboard();
          }));
        },
      ),
    );
  }
}
