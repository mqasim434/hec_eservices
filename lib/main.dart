import 'package:flutter/material.dart';
import 'package:hec_eservices/Screens/Applicatins_Screens/applications.dart';
import 'package:hec_eservices/Screens/Applicatins_Screens/attestationDetails.dart';
import 'package:hec_eservices/Screens/Applicatins_Screens/detailsOfDegree.dart';
import 'package:hec_eservices/Screens/Applicatins_Screens/uploadDocuments.dart';
import 'package:hec_eservices/Screens/Applicatins_Screens/verifyDetails.dart';
import 'package:hec_eservices/Screens/homepage.dart';
import 'package:hec_eservices/Screens/profile.dart';
import 'package:hec_eservices/test_Screen/getUser.dart';
import 'package:hec_eservices/test_Screen/test_screen.dart';
import 'Screens/Applicatins_Screens/questionaire.dart';
import 'Screens/Splash.dart';
import 'Screens/Register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/signIn.dart';
import 'Screens/Profile_Screens/contactDetails.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        '/SignIn' : (context)=> SignIn(),
      },
      home: Scaffold(
        body: Center(
          // child: ContactDetails(),
          child: SplashScreen(),
        ),
      ),
    );
  }
}



