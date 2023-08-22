import 'package:flutter/material.dart';
import 'package:hec_eservices/Models/UserModel.dart';
import 'package:hec_eservices/utils/config.dart';

import '../../../Widgets/bottomNav.dart';
import '../../../Widgets/fab.dart';
import '../../../utils/MyColors.dart';
import '../../homepage.dart';
import '../../morePage.dart';
import '../../notificationPage.dart';
import '../../profile.dart';
import 'package:http/http.dart' as http;



class EmailUpdate extends StatefulWidget {
  const EmailUpdate({Key? key}) : super(key: key);

  @override
  _EmailUpdateState createState() => _EmailUpdateState();
}

class _EmailUpdateState extends State<EmailUpdate> {
  TextEditingController emailController = TextEditingController();

  Future<void> updateData(String email) async {
    var cnic = UserModel.CurrentUserCnic;
    var endPoint = "$baseUrl/update/$cnic";
    try {
      var response = await http.patch(Uri.parse(endPoint), body: email);
      if (response.statusCode == 200) {
        print('Email Updated Successfully');
      } else {
        print('Error Updating Email');
      }
    } catch (error) {
      print(error);
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom==0.0;

    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.blueGrey[50],
          title: Text(
            "Email Update",
            style: TextStyle(color: Colors.black),
          ),
        ),
        floatingActionButton:showFab? AssistFAB():null,
        body: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Name on Degree
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Primary Email",
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder()),
                  ),
                ),
                Align(
                  child: InkWell(
                      onTap: (){
                        String email =  emailController.text.toString();
                        updateData(email);
                      }, child: Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: MyColors.gradient3
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Center(child: Text("Update",style: TextStyle(color: Colors.white),)))),
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
            if(index!=3) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                return index==0?MyHomePage():index==1?ProfilePage():NotificationPage();
              }));
            }else{
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                return MorePage();
              }));
            }
          }),
    );
  }
}