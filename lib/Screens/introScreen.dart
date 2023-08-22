import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'signIn.dart';
import 'Register.dart';
import 'package:hec_eservices/utils/MyColors.dart';
import 'dart:math';


class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  var tabController = PageController();
  int currentPageIndex = 0;
  late SvgPicture logo;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            PageView(
              onPageChanged: (index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              controller: tabController,
              children: [
                const IntroPage(
                  Pic: "assets/graduation2Pic.jpg",
                  Title: "Sign up for free",
                  Subtitle:
                  "Sign in with your HEC - E Services Account. If you don't already have an HEC - E Services Account, sign up for free by tapping on the sign up button",
                ),
                const IntroPage(
                  Pic: "assets/graduationPic.jpg",
                  Title: "Complete Your Profile",
                  Subtitle:
                  "Complete your common Profile by filling in the profile form",
                ),
                const IntroPage(
                  Pic: "assets/mobileuserPic.jpg",
                  Title: "Make Yourself Eligible",
                  Subtitle:
                  "Apply for Degree Attestation. Select degrees/certificates that you wish to attest and schedule an appointment for degree verification",
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 6,
                            backgroundColor: index == currentPageIndex
                                ? Colors.white
                                : Colors.white38,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Align(
                    child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                                return const SignIn();
                              }));
                        },
                        child: Container(
                            width: double.maxFinite,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: const Center(
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(color: MyColors.greenColor),
                                )))),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return const Register();
                            }));
                      },
                      child: const Text("Sign Up", style: TextStyle(color: Colors.white)))
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 70, right: 20),
                child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                            return const SignIn();
                          }));
                    },
                    child: const Text("Skip", style: TextStyle(color: Colors.white))),
              ),
            )
          ],
        ));
  }
}

class IntroPage extends StatelessWidget {
  final String Title;
  final String Subtitle;
  final String Pic;
  const IntroPage({
    required this.Title,
    required this.Subtitle,
    required this.Pic,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Pic),
                fit: BoxFit.cover,
                opacity: 0.2,
                colorFilter: const ColorFilter.mode(MyColors.greenColor, BlendMode.overlay),
            ),
            gradient: MyColors.gradient1,
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Transform.translate(
              offset: const Offset(0, -50),
              child: SvgPicture.asset(
                'assets/q1Circle.svg',
                height: 200,
              )),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Transform.translate(
              offset: const Offset(100, 100),
              child: Transform.rotate(
                  angle: pi / 12 * 18.2,
                  child: SvgPicture.asset(
                    'assets/fullCircles.svg',
                    height: 200,
                  ))),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(Title,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white)),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  Subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
