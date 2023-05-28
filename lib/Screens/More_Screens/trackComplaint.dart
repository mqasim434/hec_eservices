import 'package:flutter/material.dart';
import 'package:hec_eservices/Screens/More_Screens/addComplaint.dart';
import 'package:hec_eservices/Screens/homepage.dart';
import 'package:hec_eservices/Screens/morePage.dart';
import 'package:hec_eservices/Screens/notificationPage.dart';
import 'package:hec_eservices/Screens/profile.dart';
import 'package:hec_eservices/Widgets/rectangleToggle.dart';
import 'package:hec_eservices/utils/MyColors.dart';

import '../../Widgets/bottomNav.dart';

class TrackComplaint extends StatefulWidget {
  const TrackComplaint({Key? key}) : super(key: key);

  @override
  _TrackComplaintState createState() => _TrackComplaintState();
}

class _TrackComplaintState extends State<TrackComplaint> {
  var searchby = ["CNIC", "Ticket"];
  int selectedSearchBy = 0;
  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: Text(
            "Complaints",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){return AddComplaint();}));
                },
                child: Text("New Complaint"))
          ],
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.blueGrey[50],
        ),
        // floatingActionButton:showFab? AssistFAB():null,
        body: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
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
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Search By:",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Colors.black),
                      )),
                ),
                Row(
                  children: List.generate(searchby.length, (index) {
                    return RectangleToggleButton(
                      Label: searchby[index],
                      svg: "assets/icons/cnic.svg",
                      selected: selectedSearchBy == index ? true : false,
                      onSelected: (value) {
                        setState(() {
                          print("index:index");
                          selectedSearchBy = index;
                        });
                      },
                    );
                  }),
                ),
                // Name on Degree
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: searchby[selectedSearchBy],
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder()),
                  ),
                ),
                Align(
                  child: InkWell(
                      onTap: () {},
                      child: Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: MyColors.gradient3),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Center(
                              child: Text(
                            "Search",
                            style: TextStyle(color: Colors.white),
                          )))),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
        ),
        backgroundColor: MyColors.greenColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyBottomNav(
        initialSelectedIndex: 3,
        onSeleted: (index){
          print("HELLO");
          if (index != 0) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
                  return index == 1
                      ? ProfilePage()
                      : index == 2
                      ? NotificationPage()
                      : MorePage();
                }));
          }
        },
      ),
    );
  }
}
