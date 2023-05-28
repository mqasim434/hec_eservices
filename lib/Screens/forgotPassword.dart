import 'package:flutter/material.dart';
import 'package:hec_eservices/Widgets/rectangleToggle.dart';
import 'package:hec_eservices/utils/MyColors.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isPasswordVisible = false;
  int selectedType=0;
  bool rememberMe = false;
  var Types = ["CNIC/POC", "Email"];
  var siteKey="6LfhvPIdAAAAAGXEXoD3kOv7EN-0xbMNdKP10iKO";
  var secretKey="6LfhvPIdAAAAAGXEXoD3kOv7EN-0xbMNdKP10iKO";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.blueGrey[50],

      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              "assets/logo.png",
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
                          "Forgot Password",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.black),
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Recover Using:",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black),
                        )),
                  ),
                  Row(
                    children: List.generate(Types.length, (index) {
                      return RectangleToggleButton(
                        Label: Types[index],
                        svg: "assets/icons/email.svg",
                        selected: selectedType == index ? true : false,
                        onSelected: (value) {
                          setState(() {
                            print("index:index");
                            selectedType = index;
                          });
                        },
                      );
                    }),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: Types[selectedType],
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Align(
                    child: InkWell(
                        onTap: (){

                        }, child: Container(
                        width: double.maxFinite,

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: MyColors.gradient3
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Center(child: Text("Send Code",style: TextStyle(color: Colors.white),)))),
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
