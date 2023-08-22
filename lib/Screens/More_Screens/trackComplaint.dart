import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hec_eservices/Models/ComplaintModel.dart';
import 'package:hec_eservices/Models/UserModel.dart';
import 'package:hec_eservices/Screens/More_Screens/addComplaint.dart';
import 'package:hec_eservices/Screens/homepage.dart';
import 'package:hec_eservices/Screens/morePage.dart';
import 'package:hec_eservices/Screens/notificationPage.dart';
import 'package:hec_eservices/Screens/profile.dart';
import 'package:hec_eservices/Widgets/rectangleToggle.dart';
import 'package:hec_eservices/utils/MyColors.dart';
import 'package:http/http.dart' as http;

import '../../Widgets/bottomNav.dart';
import '../../utils/config.dart';

class TrackComplaint extends StatefulWidget {
  const TrackComplaint({Key? key}) : super(key: key);

  @override
  _TrackComplaintState createState() => _TrackComplaintState();
}

class _TrackComplaintState extends State<TrackComplaint> {
  var searchby = ["CNIC", "Ticket"];
  int selectedSearchBy = 0;
  bool isSearching = false;

  TextEditingController cnicController = TextEditingController();

  Future<List<dynamic>> getComplaint(String cnic) async {
    final response = await http.get(Uri.parse('$baseUrl/getComplaint/$cnic'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      isSearching = false;
      return data;
    } else {
      throw 'No Complaints found';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Complaints",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AddComplaint();
                }));
              },
              child: const Text("New Complaint"),
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.blueGrey[50],
        ),
        // floatingActionButton:showFab? AssistFAB():null,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Track Complaint Ticket",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.black),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Container(
                    //   margin: const EdgeInsets.only(bottom: 10),
                    //   child: Align(
                    //       alignment: Alignment.centerLeft,
                    //       child: Text(
                    //         "Search By:",
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .bodyText2!
                    //             .copyWith(color: Colors.black),
                    //       )),
                    // ),
                    // Row(
                    //   children: List.generate(searchby.length, (index) {
                    //     return RectangleToggleButton(
                    //       Label: searchby[index],
                    //       svg: "assets/cnic.svg",
                    //       selected: selectedSearchBy == index ? true : false,
                    //       onSelected: (value) {
                    //         setState(() {
                    //           print("index:index");
                    //           selectedSearchBy = index;
                    //         });
                    //       },
                    //     );
                    //   }),
                    // ),
                    // Name on Degree
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        controller: cnicController,
                        decoration: InputDecoration(
                            labelText: searchby[selectedSearchBy],
                            contentPadding: const EdgeInsets.all(15),
                            border: const OutlineInputBorder()),
                      ),
                    ),
                    Align(
                      child: InkWell(
                        onTap: () {
                          isSearching = true;
                          setState(() {

                          });
                          print('search');
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
                              "Search",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    isSearching
                        ? SizedBox(
                            height: 250,
                            child: FutureBuilder<List<dynamic>>(
                              future:
                                  getComplaint(cnicController.text.toString()),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  ); // Loading indicator while data is fetched
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Text('No Complaints found');
                                } else {
                                  // Display the list of users
                                  return ListView.builder(
                                    itemCount: snapshot.data?.length,
                                    itemBuilder: (context, index) {
                                      final data = snapshot.data?[index];
                                      return Card(
                                        elevation: 3,
                                        child: ListTile(
                                          leading: Text(data['applicationId']),
                                          title: Text(data['service']),
                                          trailing: Text(
                                            data['fullName'],
                                          ),
                                          subtitle: Text(data['issue']),
                                          isThreeLine: true,
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          )
                        : const Text('')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddComplaint(),
            ),
          );
        },
        backgroundColor: MyColors.greenColor,
        child: const Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyBottomNav(
        initialSelectedIndex: 3,
        onSeleted: (index) {
          print("HELLO");
          if (index != 0) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return index == 1
                  ? const ProfilePage()
                  : index == 2
                      ? const NotificationPage()
                      : const MorePage();
            }));
          }
        },
      ),
    );
  }
}
