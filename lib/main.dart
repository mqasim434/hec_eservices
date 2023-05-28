import 'package:flutter/material.dart';
import 'package:hec_eservices/Screens/profile.dart';
import 'package:hec_eservices/test_Screen/test_screen.dart';
import 'Screens/Splash.dart';
import '/Screens/Register.dart';
import '/Screens/signIn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: Scaffold(
          body: Center(
            child: SplashScreen(),
          ),
        ));
  }
}
