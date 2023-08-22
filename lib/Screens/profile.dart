import 'dart:io';
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hec_eservices/Models/UserModel.dart';
import 'package:hec_eservices/Screens/homepage.dart';
import 'package:hec_eservices/Screens/morePage.dart';
import 'package:hec_eservices/Screens/notificationPage.dart';
import 'package:hec_eservices/Widgets/bottomNav.dart';
import 'package:hec_eservices/utils/MyColors.dart';
import 'package:hec_eservices/Widgets/toffee.dart';
import 'package:hec_eservices/Widgets/bottomSheet.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/config.dart';
import 'Profile_Screens/contactDetails.dart';
import 'Profile_Screens/perosnalDetails.dart';
import 'Profile_Screens/Education_Details/educationPage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  XFile? profilePic;
  String? profilePicLink = '';
  bool isLoading = true;

  final picker = ImagePicker();

  UserModel currentUser = UserModel();

  Future<dynamic> getUserData() async {
    try {
      var cnic = UserModel.CurrentUserCnic.toString();
      var endPoint = "$baseUrl/getUser/$cnic";
      print('get user cnic: $cnic');
      var url = Uri.parse(endPoint);
      var user = await http.get(url);
      print("User:$user");
      if (user.statusCode == 200) {
        currentUser = UserModel.fromJson(json.decode(user.body));
      } else {
        print('User Not Found');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    profilePicLink = currentUser.imageUrl.toString();
    print('Profile Link: $profilePicLink');
    ImagePicker pick = ImagePicker();
    return Scaffold(
      body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        decoration:
                            const BoxDecoration(gradient: MyColors.gradient3),
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
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 80),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    child: profilePicLink == 'null'
                                        ? const Icon(Icons.add_a_photo)
                                        : Image.network(
                                            profilePicLink.toString(),
                                          ),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.blueGrey[50],
                                        child: InkWell(
                                            onTap: () {
                                              MyBottomSheet()
                                                  .showImageSelectorBottomSheet(
                                                      context)
                                                  .then((value) async {
                                                if (value == 0) {
                                                  profilePic = await pick.pickImage(source: ImageSource.camera);
                                                  try {
                                                    FirebaseStorage storage = FirebaseStorage.instance;
                                                    String imagePath =
                                                        '${UserModel.CurrentUserCnic}/profile_pic/${DateTime.now().millisecondsSinceEpoch}.jpg';
                                                    Reference ref = storage.ref().child(imagePath);
                                                    UploadTask uploadTask =
                                                    ref.putFile(File(profilePic!.path));
                                                    await uploadTask.whenComplete(() async {
                                                      print('Image uploaded successfully');
                                                      var downloadUrl = await ref.getDownloadURL();
                                                      profilePicLink = downloadUrl.toString();
                                                      setState(() {});
                                                    });
                                                  } catch (e) {
                                                    print('Error uploading image: $e');
                                                  }
                                                } else {
                                                  profilePic = await pick.pickImage(source: ImageSource.gallery);
                                                  try {
                                                    FirebaseStorage storage = FirebaseStorage.instance;
                                                    String imagePath =
                                                        '${UserModel.CurrentUserCnic}/profile_pic/${DateTime.now().millisecondsSinceEpoch}.jpg';
                                                    Reference ref = storage.ref().child(imagePath);
                                                    UploadTask uploadTask =
                                                    ref.putFile(File(profilePic!.path));
                                                    await uploadTask.whenComplete(() async {
                                                      print('Image uploaded successfully');
                                                      var downloadUrl = await ref.getDownloadURL();
                                                      profilePicLink = downloadUrl;
                                                      print('profile$profilePicLink');
                                                      setState(() {});
                                                    });
                                                  } catch (e) {
                                                    print('Error uploading image: $e');
                                                  }

                                                }
                                              });
                                            },
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: const Icon(
                                                Icons.camera_alt_outlined)),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          Align(
                              child: Text(
                            "${currentUser.firstName.toString()} ${currentUser.lastName.toString()}",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.white, height: 2),
                          )),
                          Align(
                              child: Text(
                                currentUser.email.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.white54, height: 2),
                          )),
                          Align(
                              child: Text(
                                currentUser.cnic.toString(),
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
                            "Profile Strength 30%",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.white, height: 2),
                          ),
                          const Divider(
                            endIndent: 250,
                            thickness: 10,
                            color: MyColors.yellowColor,
                          ),
                          Toffee2(
                            type: ToffeeType.profile,
                            Title: "Personal",
                            Subtitle: "Tell us about yourself",
                            svg: "assets/personal.svg",
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const PersonalDetails();
                              }));
                            },
                          ),
                          Toffee2(
                            type: ToffeeType.profile,
                            Title: "Contact",
                            Subtitle: "How can we reach you",
                            svg: "assets/contact.svg",
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const ContactDetails();
                              }));
                            },
                          ),
                          Toffee2(
                              type: ToffeeType.profile,
                              Title: "Education",
                              Subtitle: "Share your education details",
                              svg: "assets/education.svg",
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return const EducationPage();
                                  }),
                                );
                              }),
                          const SizedBox(
                            height: 60,
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: MyColors.greenColor,
        child: SvgPicture.asset(
          'assets/degree.svg',
          height: 30,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MyBottomNav(
        initialSelectedIndex: 1,
        onSeleted: (index) {
          print(index);
          if (index != 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return index == 0
                      ? MyHomePage()
                      : index == 2
                          ? const NotificationPage()
                          : index == 3
                              ? const MorePage()
                              : const ProfilePage();
                },
              ),
            );
          }
        },
      ),
    );
  }
}
