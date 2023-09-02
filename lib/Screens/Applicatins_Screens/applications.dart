import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import '../../Models/ApplicationModel.dart';
import '../../Widgets/bottomNav.dart';
import '../../Widgets/fab.dart';
import '../homepage.dart';
import '../notificationPage.dart';
import '../profile.dart';

class MyApplications extends StatefulWidget {
  const MyApplications({Key? key}) : super(key: key);

  @override
  _MyApplicationsState createState() => _MyApplicationsState();
}

class _MyApplicationsState extends State<MyApplications> {



  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.blueGrey[50],
          title: const Text(
            "Total Applications",
            style: TextStyle(color: Colors.black),
          ),
        ),
        floatingActionButton:showFab?const AssistFAB():null,
        body: Container(
          padding: const EdgeInsets.all(10),
          child: CustomScrollView(

            slivers: [
              SliverAppBar(
                titleSpacing: 0,
                toolbarHeight: 60,
                backgroundColor: Colors.white,
                floating: true,
                automaticallyImplyLeading: false,
                title:
                // Search Field
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Search by Application ID",
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder()),
                ),
              )
              ,
              SliverList(
                  delegate: SliverChildBuilderDelegate((context,int index){
                    return ApplicationCard(
                      onPressed: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context){return DetailsofDegree();}));
                      },
                      Status: "Saved",
                      date: DateTime.now(),
                      Service: "Degree Attestation Service",
                      ApplicationID: '00000${index+1}',
                    );
                  },childCount: Application.applicationCount
                  ))
            ],

          ),
        ),
      ),
      floatingActionButton:showFab? const CenterDockedFAB():null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: MyBottomNav(
          initialSelectedIndex: 3,
          onSeleted: (index) {
            if (index != 3) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return index == 0
                        ? MyHomePage()
                        : index == 1
                        ? const ProfilePage()
                        : const NotificationPage();
                  }));
            }
          }),
    );
  }
}

class ApplicationCard extends StatelessWidget {
  final String Status;
  final String Service;
  final DateTime date;
  final String ApplicationID;
  final VoidCallback onPressed;

  const ApplicationCard({
    required this.onPressed,
    required this.ApplicationID,
    required this.Service,
    required this.Status,
    required this.date,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 3))
              ]),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 10),
                    child: Text(Status,style: TextStyle(color: Colors.amber[800]),),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.orange[50],
                    ),
                  ),
                  Text(DateFormat("dd/mm/yyyy").format(date))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      Service,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios)
                ],
              ),
              Row(
                children: [
                  const Text("Application ID: "),
                  Text(
                    ApplicationID,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
