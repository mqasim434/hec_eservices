import 'package:dotted_border/dotted_border.dart';
import 'package:hec_eservices/utils/MyColors.dart';
import 'package:flutter/material.dart';

class RectangleToggleButton extends StatefulWidget {
  final Function(bool) onSelected;
  final bool? selected;
  final String Label;
  final String svg;
  RectangleToggleButton({
    required this.onSelected,
    required this.Label,
    required this.svg,
    this.selected,
    Key? key,
  }) : super(key: key);

  @override
  State<RectangleToggleButton> createState() => _RectangleToggleButtonState();
}

class _RectangleToggleButtonState extends State<RectangleToggleButton> {
  bool? isSelected;
  @override
  Widget build(BuildContext context) {
    isSelected=widget.selected??false;
    return InkWell(
      onTap: (){
        setState(() {
          isSelected=!isSelected!;
          widget.onSelected(isSelected!);
        });
      },
      child:
      isSelected!?
      Container(
        width: 70,
        height: 70,
        margin: EdgeInsets.only(top: 5,right: 5,bottom: 5),

        decoration:
        BoxDecoration(gradient: MyColors.gradient1,borderRadius: BorderRadius.circular(5))
        ,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SvgPicture.asset(widget.svg,color: Colors.white,height: 30,),
                  Text(widget.Label,style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),textAlign: TextAlign.center,)
                ],
              ),
            ),
            Align(
                alignment: Alignment.topRight,
                child: Container(padding: EdgeInsets.all(5),child: CircleAvatar(child: Icon(Icons.check,size: 20,),radius: 10,backgroundColor: Colors.white,))),
          ],
        ),
      ):
      Container(
        margin: EdgeInsets.only(top: 5,right: 5,bottom: 5),

        child: DottedBorder(
          radius: Radius.circular(5),
          borderType: BorderType.RRect,
          strokeWidth: 1,
          padding: EdgeInsets.all(0),
          child: Container(
            width: 70,
            height: 70,


            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SvgPicture.asset(widget.svg,color: Colors.black,height: 30,),
                      Text(widget.Label,style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.black),textAlign: TextAlign.center)
                    ],
                  ),
                ),
                if(isSelected!)Align(
                    alignment: Alignment.topRight,
                    child: Container(padding: EdgeInsets.all(5),child: CircleAvatar(child: Icon(Icons.check,size: 20,),radius: 10,backgroundColor: Colors.white,))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class RectangleToggleButton2 extends StatefulWidget {
  final Function(bool) onSelected;
  final bool? selected;
  final String Label;

  RectangleToggleButton2({
    required this.onSelected,
    required this.Label,

    this.selected,
    Key? key,
  }) : super(key: key);

  @override
  State<RectangleToggleButton2> createState() => _RectangleToggleButton2State();
}

class _RectangleToggleButton2State extends State<RectangleToggleButton2> {
  bool? isSelected;
  @override
  Widget build(BuildContext context) {
    isSelected=widget.selected??false;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: (){
        setState(() {
          isSelected=!isSelected!;
          widget.onSelected(isSelected!);
        });
      },
      child:
      isSelected!?
      Container(

        height: 30,
        margin: EdgeInsets.only(top: 5,right: 5,bottom: 5),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration:
        BoxDecoration(gradient: MyColors.gradient1,borderRadius: BorderRadius.circular(5))
        ,
        child: Align(
          alignment: Alignment.center,
          child: Text(widget.Label,style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),),
        ),
      ):
      Container(
        margin: EdgeInsets.only(top: 5,right: 5,bottom: 5),
        child: DottedBorder(
          radius: Radius.circular(5),
          borderType: BorderType.RRect,
          strokeWidth: 1,
          padding: EdgeInsets.all(0),
          child: Container(

            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 10),

            child: Align(
              alignment: Alignment.center,
              child: Text(widget.Label,style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.black),),
            ),
          ),
        ),
      ),
    );
  }
}