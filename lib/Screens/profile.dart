import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hec_eservices/Screens/morePage.dart';
import 'package:hec_eservices/Screens/notificationPage.dart';
import 'package:hec_eservices/Screens/personalDetails.dart';
import 'package:hec_eservices/Widgets/bottomNav.dart';
import 'package:hec_eservices/utils/MyColors.dart';
import 'package:hec_eservices/Widgets/toffee.dart';
import 'package:hec_eservices/Widgets/bottomSheet.dart';
import 'package:image_picker/image_picker.dart';
import 'contactDetails.dart';
import 'educationPage.dart';
import 'homepage.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>{
  Uint8List? profilePic;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(gradient: MyColors.gradient3),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(height: 80),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage:profilePic==null?
                              NetworkImage("https://scontent.flhe7-1.fna.fbcdn.net/v/t39.30808-6/339975164_3465336383704360_8715378302897710276_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeFLsh-jlmn4MGaJQWce1sXcesVOVctVmRV6xU5Vy1WZFYHHYrkb20FFZy6c3T3nSWpvYnjPlgX5cPLQIeuP-ecs&_nc_ohc=FrC5GPh5Cl0AX8OMYq0&_nc_zt=23&_nc_ht=scontent.flhe7-1.fna&oh=00_AfAOJRFzBmHLmMR0QwDjSrOAEWiF9-bAUZg7SFAeQIB86w&oe=6438598C"):MemoryImage(profilePic!) as ImageProvider,
                            ),
                            Align(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                  radius: 15,
                                  child: InkWell(
                                      onTap: () {
                                        MyBottomSheet()
                                            .showImageSelectorBottomSheet(context)
                                            .then((value) async {
                                          if(value==0){
                                            PickedFile? image=await ImagePicker.platform.pickImage(source: ImageSource.camera);
                                            if(image!=null){
                                              profilePic=await image.readAsBytes();
                                              setState(() {});
                                            }

                                          }else{
                                            PickedFile? image=await ImagePicker.platform.pickImage(source: ImageSource.gallery);
                                            if(image!=null){
                                              profilePic=await image.readAsBytes();
                                              setState(() {});
                                            }
                                          }
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(50),
                                      child: Icon(Icons.camera_alt_outlined)),
                                  backgroundColor: Colors.blueGrey[50],
                                )),
                          ],
                        ),
                      ),
                    ),
                    Align(
                        child: Text(
                          "Muhammad Qasim",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.white, height: 2),
                        )),
                    Align(
                        child: Text(
                          "mq30003@gmail.com",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.white54, height: 2),
                        )),
                    Align(
                        child: Text(
                          "342011233",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.white54, height: 2),
                        )),
                  ],
                ),

                Column(
                  children: [
                    Text(
                      "Profile Strength 100%",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.white, height: 2),
                    ),
                    Divider(
                      thickness: 10,
                      color: MyColors.yellowColor,
                    ),
                    Toffee2(
                      type: ToffeeType.profile,
                      Title: "Personal",
                      Subtitle: "Tell us about yourself",
                      svg: "assets/icons/personal.svg",
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return PersonalDetails();
                        }));
                      },
                    ),
                    Toffee2(
                      type: ToffeeType.profile,
                      Title: "Contact",
                      Subtitle: "How can we reach you",
                      svg: "assets/icons/contact.svg",
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ContactDetails();
                        }));
                      },
                    ),
                    Toffee2(
                        type: ToffeeType.profile,
                        Title: "Education",
                        Subtitle: "Share your education details",
                        svg: "assets/icons/education.svg",
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return EducationPage();
                            }),
                          );
                        }),
                    SizedBox(height: 60,)
                  ],
                ),

              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: SvgPicture.asset(
          'assets/degree.svg',
          height: 30,
          color: Colors.white,
        ),
        backgroundColor: MyColors.greenColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyBottomNav(
        initialSelectedIndex: 1,
        onSeleted: (index){
          print("HELLO");
          if (index != 0) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
                  return index == 1
                      ? ProfilePage()
                      : index == 2
                      ? NotificationPage()
                      : MorePage();
                }));
          }
        },
      ),
    );

  }

}

