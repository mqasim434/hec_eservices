import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hec_eservices/Models/UserModel.dart';
import 'package:hec_eservices/Screens/Profile_Screens/perosnalDetails.dart';
import 'package:hec_eservices/Screens/Authentication/Forgot_Password/getOTP.dart';
import 'package:hec_eservices/Screens/Navbar_Screens/dashboard.dart';
import 'package:hec_eservices/Screens/Navbar_Screens/profile.dart';
import 'package:hec_eservices/utils/MyColors.dart';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isPasswordVisible = false;
  int selectedType = 0;
  bool rememberMe = false;

  TextEditingController emailController = TextEditingController();
  String otp = '';

  Future sendOTP({
    required String name,
    required String email,
  }) async {

    String service_id = 'service_cz7ulau';
    String template_id = 'template_9w0m10v';
    String user_id = 'Wg5cg5VOTDXOCCgHZ';
    final random = Random();
    otp = (random.nextInt(9000) + 1000).toString();

    var response = await http.post(
      Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
      headers: {
        'origin' : 'http://localhost',
        'Content-Type' : 'application/json',
      },
      body: json.encode({
        'service_id': service_id,
        'template_id': template_id,
        'user_id': user_id,
        'template_params': {
          'to_email': email,
          'to_name': name,
          'user_message': otp,
        }
      }),
    );
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.blueGrey[50],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              "assets/logo.png",
              height: 100,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 3))
                  ]),
              child: // Name on Degree
                  Column(
                children: [
                  Container(
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Forgot Password",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.black),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Enter your email:",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    child: InkWell(
                        onTap: () {
                          sendOTP(name: 'name', email: emailController.text.toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OTPScreen(otp: otp,email: emailController.text.toString(),),
                            ),
                          );
                        },
                        child: Container(
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: MyColors.gradient3),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: const Center(
                                child: Text(
                              "Send Code",
                              style: TextStyle(color: Colors.white),
                            ),),),),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
