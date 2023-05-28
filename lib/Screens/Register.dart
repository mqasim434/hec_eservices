import 'package:hec_eservices/Widgets/rectangleToggle.dart';
import 'package:hec_eservices/utils/MyColors.dart';
import 'package:hec_eservices/Widgets/bottomSheet.dart';
import 'package:flutter/material.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var indetityType = ["CNIC", "POC"];
  var Countries = ["Pakistan", "Turkey", "Australia", "Bangladesh"];
  var Country = TextEditingController();
  var Number = TextEditingController();
  int selectedSearchBy = 0;
  bool isPasswordVisible = false;
  bool rememberMe = false;
  // PhoneNumber number = PhoneNumber(isoCode: 'PK');
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
        child: SingleChildScrollView(
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
                            "Sign Up",
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
                            labelText: "First Name",
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
                        decoration: InputDecoration(
                            labelText: "Last Name",
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
                        controller: Country,
                        // ignore: prefer_const_constructors
                        onTap: () {
                          MyBottomSheet()
                              .showSearchableBottomSheet(
                              context, Countries, "Country")
                              .then((value) {
                            setState(() {
                              Country.text = Countries[value];
                            });
                          });
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                            labelText: "Country",
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Identity Type:",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                          )),
                    ),
                    Row(
                      children: List.generate(indetityType.length, (index) {
                        return RectangleToggleButton(
                          Label: indetityType[index],
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
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: "CNIC",
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Cell Number
                    // Container(
                    //   margin: EdgeInsets.only(top: 10),
                    //   child: TextFormField(
                    //     onTap: (){
                    //     },
                    //     decoration: InputDecoration(
                    //       prefixIcon: Container(
                    //         width: 80,
                    //         child: InkWell(
                    //           onTap: (){
                    //             MyBottomSheet().showSearchableBottomSheet(context, [
                    //               "(+92) Pakistan",
                    //               "(+97) UAE",
                    //             ], "Country Code");
                    //           },
                    //           child: Row(
                    //             children: [
                    //               Icon(Icons.flag_outlined),
                    //               Text("+90"),
                    //               Icon(Icons.arrow_drop_down),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //         labelText: "Cell Number",
                    //         contentPadding: EdgeInsets.all(5),
                    //         border: OutlineInputBorder()),
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    // InternationalPhoneNumberInput(
                    //   onInputChanged: (PhoneNumber number) {
                    //     print(number.phoneNumber);
                    //   },
                    //   onInputValidated: (bool value) {
                    //     print(value);
                    //   },
                    //   spaceBetweenSelectorAndTextField: 0,
                    //   inputDecoration: InputDecoration(
                    //       labelText: "Primary Cell Phone Number",
                    //       contentPadding: EdgeInsets.all(15),
                    //       border: OutlineInputBorder()),
                    //   searchBoxDecoration: InputDecoration(
                    //       labelText: "Search Country Code",
                    //       contentPadding: EdgeInsets.all(15),
                    //       border: OutlineInputBorder()),
                    //   selectorConfig: SelectorConfig(
                    //     selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    //   ),
                    //   ignoreBlank: false,
                    //   autoValidateMode: AutovalidateMode.disabled,
                    //   selectorTextStyle: TextStyle(color: Colors.black),
                    //   initialValue: number,
                    //   textFieldController: Number,
                    //   formatInput: false,
                    //   keyboardType: TextInputType.numberWithOptions(
                    //       signed: true, decimal: true),
                    //   inputBorder: OutlineInputBorder(),
                    //   onSaved: (PhoneNumber number) {
                    //     print('On Saved: $number');
                    //   },
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: "Email",
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      child: InkWell(
                          onTap: () {
                          },
                          child: Container(
                              width: double.maxFinite,

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  gradient: MyColors.gradient3),
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Center(
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(color: Colors.white),
                                  )))),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already Have an Account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Sign In")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
