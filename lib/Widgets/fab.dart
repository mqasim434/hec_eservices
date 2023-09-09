import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:hec_eservices/Screens/Applicatins_Screens/detailsOfDegree.dart';
import 'package:hec_eservices/Screens/Degree_Verification/verifyDegree.dart';

import 'package:hec_eservices/utils/MyColors.dart';

class CenterDockedFAB extends StatelessWidget {
  const CenterDockedFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(blurRadius: 5, offset: Offset(0, 4), color: Colors.black26)
      ], borderRadius: BorderRadius.circular(50), gradient: MyColors.gradient2),
      child: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.transparent,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return VerifyDocument();
              });
        },
        tooltip: 'Increment',
        child: SvgPicture.asset(
          'assets/degree.svg',
          color: Colors.white,
          height: 30,
        ),
      ),
    );
  }
}

class AssistFAB extends StatelessWidget {
  const AssistFAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 70.0,left: 30.0),
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(blurRadius: 5, offset: Offset(0, 4), color: Colors.black26)
            ], borderRadius: BorderRadius.circular(50), color: MyColors.blueColor),
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: Colors.transparent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsofDegree(),
                  ),
                );
              },
              tooltip: 'Increment',
              child:Icon(Icons.add),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 70),
          child: SpeedDial(
            backgroundColor: const Color(0xff344164),
            renderOverlay: false,
            overlayOpacity: 0,
            buttonSize: const Size(45, 45),
            childrenButtonSize: const Size(45, 45),
            children: [
              SpeedDialChild(
                  child: const Icon(
                    FontAwesome5.file_alt,
                    size: 18,
                  ),
                  label: "Read Instructions"),
              SpeedDialChild(
                  child: const Icon(
                    LineariconsFree.download,
                    size: 18,
                  ),
                  label: "Download Manual"),
              SpeedDialChild(
                  child: SvgPicture.asset(
                    'assets/chat.svg',
                    width: 18,
                  ),
                  label: "Online Help"),
              SpeedDialChild(
                  child: SvgPicture.asset(
                    'assets/chat.svg',
                    width: 18,
                  ),
                  label: "Chat"),
            ],
            child: SvgPicture.asset(
              'assets/assist.svg',
              color: Colors.white,
              height: 30,
            ),
          ),
        ),
      ],
    );
  }
}

class FixedCenterDockedFabLocation extends StandardFabLocation
    with FabCenterOffsetX, FabDockedOffsetY {
  const FixedCenterDockedFabLocation();

  @override
  String toString() => 'FloatingActionButtonLocation.fixedCenterDocked';

  @override
  double getOffsetY(
      ScaffoldPrelayoutGeometry scaffoldGeometry, double adjustment) {
    final double contentBottom = scaffoldGeometry.contentBottom;
    final double bottomMinInset = scaffoldGeometry.minInsets.bottom;
    if (bottomMinInset > 0) {
      // Hide if there's a keyboard
      return contentBottom;
    }
    return super.getOffsetY(scaffoldGeometry, adjustment);
  }
}
