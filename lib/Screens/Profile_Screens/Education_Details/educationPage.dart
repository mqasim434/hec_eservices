import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hec_eservices/utils/config.dart';

import '../../../Models/UserModel.dart';
import '../../../Widgets/bottomNav.dart';
import '../../../Widgets/fab.dart';
import '../../../Widgets/informationCard.dart';
import '../../Applicatins_Screens/detailsOfDegree.dart';
import '../../homepage.dart';
import '../../notificationPage.dart';
import 'educationDetails.dart';
import 'package:http/http.dart' as http;

class EducationPage extends StatefulWidget {
  const EducationPage({Key? key}) : super(key: key);

  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  int selectedPageIndex=0;

  Future<List<dynamic>> getEducationData(String cnic) async {
    final response = await http.get(Uri.parse('$baseUrl/getEducationData/$cnic'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('No Complaint Found');
    }
  }


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
            TextButton(child: const Text("Save"),onPressed: (){

            },)
          ],

          backgroundColor: Colors.blueGrey[50],
          title: const Text(
            "Education Details",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
              children: [
                DottedButton(Label: "+ Add Details of Degree", onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const EducationDetails(isViewOnly: false,);
                  }));
                }),
                // Degree Cards
                Expanded(
                  child: FutureBuilder<List<dynamic>>(
                    future: getEducationData(UserModel.CurrentUserCnic),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator()); // Loading indicator while data is fetched
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Text('No users found');
                      } else {
                        // Display the list of users
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            final data = snapshot.data?[index];
                            return DegreeInformationCard(
                              discipline: data['universityName'],
                              session: data['universityName'],
                              program: data['universityName'],
                              university: data['universityName'],
                              title: data['programTitle'],
                              onView: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return const EducationDetails(isViewOnly: true,);
                                }));
                              },
                              onEdit: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return const EducationDetails(isViewOnly: false,);
                                }));
                              },
                              onDelete: (){},
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ]
          ),
        ),
      ),
      floatingActionButton: CenterDockedFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: MyBottomNav(
        initialSelectedIndex: 1,
        onSeleted: (index) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                return index == 0
                    ?  MyHomePage(

                )
                    : index == 2
                    ? const NotificationPage()
                    :  MyHomePage();
              }));
        },
      ),
    );
  }
}
