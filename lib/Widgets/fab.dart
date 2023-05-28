import 'package:hec_eservices/Screens/perspectiveCrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/linearicons_free_icons.dart';

import 'package:hec_eservices/utils/MyColors.dart';

class CenterDockedFAB extends StatelessWidget {
  const CenterDockedFAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(blurRadius: 5, offset: Offset(0, 4), color: Colors.black26)
      ], borderRadius: BorderRadius.circular(50), gradient: MyColors.gradient2),
      child: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.transparent,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return PerspectiveCrop();
          }));
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
    return Container(
      margin: EdgeInsets.only(bottom: 70),
      child: SpeedDial(
        backgroundColor: Color(0xff344164),
        child: SvgPicture.asset(
          'assets/icons/assist.svg',
          color: Colors.white,
          height: 30,
        ),
        renderOverlay: false,
        overlayOpacity: 0,
        buttonSize: Size(45, 45),
        childrenButtonSize: Size(45, 45),
        children: [
          SpeedDialChild(
              child: Icon(
                FontAwesome5.file_alt,
                size: 18,
              ),
              label: "Read Instructions"),
          SpeedDialChild(
              child: Icon(
                LineariconsFree.download,
                size: 18,
              ),
              label: "Download Manual"),
          SpeedDialChild(
              child: SvgPicture.asset(
                'assets/icons/chat.svg',
                width: 18,
              ),
              label: "Online Help"),
          SpeedDialChild(
              child: SvgPicture.asset(
                'assets/icons/chat.svg',
                width: 18,
              ),
              label: "Chat"),
        ],
      ),
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
