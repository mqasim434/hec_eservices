import 'package:hec_eservices/Screens/Register.dart';
import 'package:hec_eservices/Screens/homepage.dart';
import 'package:hec_eservices/utils/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:hec_eservices/Screens/forgotPassword.dart';
// import 'package:fluttericon/font_awesome5_icons.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isPasswordVisible = false;
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              "assets/HEC-Logo.png",
              height: 100,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
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
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "CNIC/Passport",
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                          // suffixIcon: IconButton(
                          //   onPressed: () {
                          //     setState(() {
                          //       isPasswordVisible = !isPasswordVisible;
                          //     });
                          //   },
                          //   // icon: Icon(
                          //   //   !isPasswordVisible
                          //   //       ? FontAwesome5.eye
                          //   //       : FontAwesome5.eye_slash,
                          //   //   size: 20,
                          //   //   color: Colors.black26,
                          //   // ),
                          // ),
                          labelText: "Password",
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder()),
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
                              margin: EdgeInsets.only(
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
                            Text("Remember Me")
                          ],
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ForgotPassword();
                                },
                              ),
                            );
                          },
                          child: Text("Forgot Your Password?")),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){return MyHomePage();}));
                        },
                        child: Container(
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: MyColors.gradient3),
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Center(
                                child: Text(
                              "SIGN IN",
                              style: TextStyle(color: Colors.white),
                            )))),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't Have Account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Register();
                      }));
                    },
                    child: Text("Sign up Now!")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
