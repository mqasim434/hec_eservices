import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hec_eservices/utils/MyColors.dart';

class MyBottomNav extends StatefulWidget {
  final int initialSelectedIndex;
  final Function(int) onSeleted;
  const MyBottomNav({
    required this.initialSelectedIndex,
    required this.onSeleted,
    Key? key,
  }) : super(key: key);

  @override
  State<MyBottomNav> createState() => _MyBottomNavState();
}

class _MyBottomNavState extends State<MyBottomNav> {
  int? selectedIndex;
  @override
  void initState() {
    selectedIndex = widget.initialSelectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      //bottom navigation bar on scaffold

      shape: CircularNotchedRectangle(), //shape of notch
      notchMargin: 10, //notche margin between floating button and bottom appbar
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                  widget.onSeleted(0);
                });
              },
              child: SizedBox(
                height: 60,
                width: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      "assets/dashboard.svg",
                      height: 25,
                      color: selectedIndex == 0
                          ? MyColors.greenColor
                          : Colors.black54,
                    ),
                    Text(
                      "Dashboard",
                      style: selectedIndex == 0
                          ? TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: MyColors.greenColor)
                          : TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                  widget.onSeleted(1);
                });
              },
              child: SizedBox(
                height: 60,
                width: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      "assets/profile.svg",
                      height: 25,
                      color: selectedIndex == 1
                          ? MyColors.greenColor
                          : Colors.black54,
                    ),
                    Text("Profile",
                        style: selectedIndex == 1
                            ? TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: MyColors.greenColor)
                            : TextStyle(fontSize: 12))
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 80,
              height: 60,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                  widget.onSeleted(2);
                });
              },
              child: SizedBox(
                height: 60,
                width: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      children: [
                        SvgPicture.asset(
                          "assets/Notification.svg",
                          height: 25,
                          color: selectedIndex == 2
                              ? MyColors.greenColor
                              : Colors.black54,
                        ),
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.red,
                        )
                      ],
                    ),
                    Text("Notification",
                        style: selectedIndex == 2
                            ? TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: MyColors.greenColor)
                            : TextStyle(fontSize: 12))
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 3;
                  widget.onSeleted(3);
                });
              },
              child: SizedBox(
                height: 60,
                width: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.more_horiz,
                      color: selectedIndex == 3
                          ? MyColors.greenColor
                          : Colors.black54,
                    ),
                    Text("More",
                        style: selectedIndex == 3
                            ? TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: MyColors.greenColor)
                            : TextStyle(fontSize: 12))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
