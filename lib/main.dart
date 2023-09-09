import 'package:flutter/material.dart';
import 'Screens/Splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/Authentication/signIn.dart';

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
        '/SignIn' : (context)=> const SignIn(),
      },
      home: const Scaffold(
        body: Center(
          // child: ContactDetails(),
          child: SplashScreen(),
        ),
      ),
    );
  }
}



