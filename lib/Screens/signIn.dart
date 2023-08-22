import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:hec_eservices/Screens/Register.dart';
import 'package:hec_eservices/Screens/homepage.dart';
import 'package:hec_eservices/utils/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:hec_eservices/Screens/forgotPassword.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:hec_eservices/utils/config.dart';
import 'package:http/http.dart' as http;
import 'package:hec_eservices/Models/UserModel.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isPasswordVisible = false;
  bool rememberMe = false;

  TextEditingController _cnicController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    String cnic = _cnicController.text.toString();
    String password = _passwordController.text.toString();

    var endPoint = "$baseUrl/login";
    print('login');
    try {
      var response = await http.post(
        Uri.parse(endPoint),
        body: {
          'cnic': cnic,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        print('Login successful');
        UserModel.CurrentUserCnic = _cnicController.text.toString();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Successfull'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MyHomePage();
                  }));
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Login failed, handle the response accordingly
        // Fluttertoast.showToast(
        //   msg: 'Login error: ${response.statusCode}',
        //   toastLength: Toast.LENGTH_SHORT,
        // );
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Failed'),
            content: Text('Error Code: ${response.statusCode}'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      // Fluttertoast.showToast(
      //   msg: 'Login error: $error',
      //   toastLength: Toast.LENGTH_SHORT,
      // );
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              "assets/HEC-Logo.png",
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
                          "Sign In",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.black),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: _cnicController,
                      decoration: const InputDecoration(
                          labelText: "CNIC",
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                            icon: Icon(
                              !isPasswordVisible
                                  ? FontAwesome5.eye
                                  : FontAwesome5.eye_slash,
                              size: 20,
                              color: Colors.black26,
                            ),
                          ),
                          labelText: "Password",
                          contentPadding: const EdgeInsets.all(15),
                          border: const OutlineInputBorder()),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            rememberMe = !rememberMe;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10, right: 10, bottom: 10),
                              height: 20,
                              width: 24,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Checkbox(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.padded,
                                    activeColor: MyColors.greenColor,
                                    value: rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        rememberMe = value!;
                                      });
                                    }),
                              ),
                            ),
                            const Text("Remember Me")
                          ],
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const ForgotPassword();
                                },
                              ),
                            );
                          },
                          child: const Text("Forgot Your Password?")),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    child: InkWell(
                      onTap: () {
                        loginUser(context);
                      },
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: MyColors.gradient3),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: const Center(
                          child: Text(
                            "SIGN IN",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't Have Account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const Register();
                      }));
                    },
                    child: const Text("Sign up Now!")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
