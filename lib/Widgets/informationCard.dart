import 'package:flutter/material.dart';
import 'package:hec_eservices/Models/UserModel.dart';
import 'package:hec_eservices/utils/MyColors.dart';
import '../utils/MyColors.dart';

enum InformationCardType { ExpandedTwoColumn, Row, ValuesOnly }

class InformationCard extends StatelessWidget {
  final bool showButton;
  final Map<String, String> data;
  final InformationCardType type;
  final String title;
  final VoidCallback onPressed;
  InformationCard(
      {Key? key,
        this.showButton = false,
        this.type = InformationCardType.ExpandedTwoColumn,
        required this.data,
        required this.title,
        required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            const BoxShadow(
                color: Colors.black12, blurRadius: 5, offset: Offset(0, 3))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  if (showButton == true)
                    IconButton(
                        onPressed: onPressed,
                        icon: const Icon(
                          Icons.edit,
                          size: 20,
                        ))
                ],
              )),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(data.length, (index) {
                if (type == InformationCardType.ExpandedTwoColumn) {
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Text("${data.keys.elementAt(index)}:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blueGrey[400]))),
                          Expanded(child: Text(data.values.elementAt(index))),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                } else if (type == InformationCardType.Row) {
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${data.keys.elementAt(index)}: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blueGrey[700])),
                          Text(data.values.elementAt(index)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.values.elementAt(index)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                }
              }))
        ],
      ),
    );
  }
}

enum DegreeInformationCardType{
  selectable,
  deletable,
  viewOnly
}

class DegreeInformationCard extends StatefulWidget {
  final DegreeInformationCardType type;
  final bool showButton;
  final String discipline;
  final String session;
  final String program;
  final String university;
  final String title;
  final VoidCallback onView;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  static bool selected=false;

  DegreeInformationCard({
    this.type=DegreeInformationCardType.deletable,
    Key? key,
    this.showButton = false,
    required this.discipline,
    required this.session,
    required this.program,
    required this.university,
    required this.title,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<DegreeInformationCard> createState() => _DegreeInformationCardState();
}

class _DegreeInformationCardState extends State<DegreeInformationCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 5, offset: Offset(0, 3))
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                        widget.title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      )),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: widget.onView,
                          child: const Icon(
                            Icons.remove_red_eye,
                            size: 20,
                            color: MyColors.greenColor,
                          )),
                      if(widget.type!=DegreeInformationCardType.viewOnly)
                        GestureDetector(
                            onTap: widget.onEdit,
                            child: const Icon(Icons.edit,
                                size: 20, color: MyColors.blueColor)),
                      if(widget.type!=DegreeInformationCardType.selectable)
                        GestureDetector(
                            onTap: widget.onDelete,
                            child: const Icon(Icons.delete_forever,
                                size: 20, color: Colors.red)),
                      if(widget.type==DegreeInformationCardType.selectable)
                        SizedBox(
                          height: 20,
                          width: 24,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Checkbox(
                                materialTapTargetSize: MaterialTapTargetSize.padded,
                                activeColor: MyColors.greenColor,
                                value: DegreeInformationCard.selected, onChanged: (value){
                              setState(() {
                                if(value==true) {
                                  UserModel.degrees.add({
                                    'department': widget.discipline.toString(),
                                    'sessionType': widget.session.toString(),
                                    'programTitle': widget.program.toString(),
                                    'universityName': widget.university.toString(),
                                    'qualificationLevel': widget.title.toString(),
                                    'oSum' : 0,
                                    'cSum' : 0,
                                  });
                                  print(UserModel.degrees);
                                }
                                DegreeInformationCard.selected=value!;
                              });
                            }),
                          ),
                        ),
                    ],
                  )
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("${widget.discipline}"),
                  const SizedBox(
                    width: 10,
                  ),
                  const CircleAvatar(
                    radius: 4,
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("${widget.session}"),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text("${widget.program}"),
              const SizedBox(
                height: 10,
              ),
              Text("${widget.university}"),
            ],
          ),
        ]));
  }
}
