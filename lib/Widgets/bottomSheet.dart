// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:hec_eservices/utils/MyColors.dart';
import 'package:flutter/material.dart';
class MyBottomSheet{
  showLoginBottomSheet(BuildContext context,Map data){
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  color: Colors.white
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Last Login Info',style: TextStyle(fontSize: 20),),
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: Icon(Icons.close))
                    ],
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: List.generate(data.length, (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${data.keys.elementAt(index)}:",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 11)),
                                Text(data.values.elementAt(index)),
                              ],),
                            SizedBox(height: 5,),
                          ],
                        );
                      }),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

  }

  Future<int> showSearchableBottomSheet(BuildContext context,List data,String Label,) async {
    int selectedIndex=0;
    var Controller=TextEditingController();
    List sortedData=Controller.text.isNotEmpty?data.where((e)=>e.toString().contains(Controller.text)).toList():data;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,

      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(

          builder: (context, setState) {

            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,top: 20,left: 20,right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        color: Colors.white
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Label,style: TextStyle(fontSize: 20),),
                            IconButton(onPressed: (){
                              Navigator.pop(context);
                            }, icon: Icon(Icons.close))
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: TextFormField(
                            controller: Controller,
                            onChanged: (value){
                              setState((){
                                sortedData=data.where((e)=>e.toString().toLowerCase().contains(Controller.text.toLowerCase())).toList();
                              });
                            },
                            decoration: InputDecoration(
                                labelText: "Search ${Label}",
                                contentPadding: EdgeInsets.all(15),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        Container(
                          height: 300,
                          child: ListView(
                            children: List.generate(sortedData.length, (index) {
                              return ListTile(
                                onTap: (){

                                  selectedIndex=index;

                                  Navigator.pop(context);
                                },
                                title: Text(sortedData[index].toString()),
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
      ),
    );
    return data.indexWhere((element) => element==sortedData[selectedIndex]);

  }

  showSnackbar({required BuildContext context,required String msg,SnackBarType type=SnackBarType.Success,Duration? duration}){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: duration??Duration(seconds: 4),
            backgroundColor: type==SnackBarType.Success?MyColors.greenColor:type==SnackBarType.Danger?Colors.red[900]:MyColors.yellowColor,
            content: Text(msg,style: TextStyle(color: type==SnackBarType.Alert?Colors.black:Colors.white),))
    );
  }





  Future<int> showImageSelectorBottomSheet(BuildContext context,) async {
    int selectedIndex=0;
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  color: Colors.white
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pick Image From',style: TextStyle(fontSize: 20),),
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: Icon(Icons.close))
                    ],
                  ),
                  SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          ListTile(
                            onTap: (){
                              selectedIndex=0;
                              Navigator.pop(context);

                            },
                            title: Text("Camera"),
                            leading: Icon(Icons.camera),
                          ),
                          ListTile(
                            onTap: (){
                              selectedIndex=1;
                              Navigator.pop(context);

                            },
                            title: Text("Gallary"),
                            leading: Icon(Icons.image),
                          )
                        ]
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
    return selectedIndex;

  }
}
enum SnackBarType{
  Danger,
  Success,
  Alert
}