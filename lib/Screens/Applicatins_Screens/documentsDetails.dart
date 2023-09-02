import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:hec_eservices/Models/UserModel.dart';
import 'package:hec_eservices/Screens/Applicatins_Screens/detailsOfDegree.dart';
import 'package:hec_eservices/Screens/Applicatins_Screens/questionaire.dart';
import 'package:hec_eservices/Screens/Applicatins_Screens/uploadDocuments.dart';

import '../../Widgets/bottomNav.dart';
import '../../Widgets/fab.dart';
import '../../Widgets/rectangleToggle.dart';
import '../../utils/MyColors.dart';
import '../homepage.dart';
import '../notificationPage.dart';
import '../profile.dart';

class DocumentsDetails extends StatefulWidget {
  const DocumentsDetails({Key? key}) : super(key: key);

  @override
  _DocumentsDetailsState createState() => _DocumentsDetailsState();
}

class _DocumentsDetailsState extends State<DocumentsDetails> {
  int originalSum = 0;
  int copySum = 0;

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0,
          backgroundColor: Colors.blueGrey[50],
          title: const Row(
            children: [
              Icon(FontAwesome.doc_text),
              Text(
                " Document Details",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        floatingActionButton: showFab ? const AssistFAB() : null,
        body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Next: Upload Documents",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.black),
                    )),
              ),
              const WizardIndicator(
                selectedIndex: 2,
                length: 4,
              ),
              const SizedBox(
                height: 10,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 300),
                child: Column(
                  children: List.generate(
                    UserModel.degrees!.length,
                    (index) => ExpandableQuantitySelector(
                      titleInfo: UserModel.degrees![index],
                      onSumChange: (oSum, cSum) {
                        setState(() {
                            UserModel.degrees[index]["oSum"] = oSum;
                            UserModel.degrees[index]["cSum"] = cSum;
                            int newOSum = 0;
                            int newCSum = 0;
                            for (var a in UserModel.degrees) {
                              newOSum = newOSum + ((a["oSum"]) as int);
                              newCSum = newCSum + ((a["cSum"]) as int);
                            }
                            originalSum = newOSum;
                            copySum = newCSum;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Align(
                child: InkWell(
                    onTap: () {
                      UserModel.applicationData['originalDocumentFee'] = originalSum.toString();
                      UserModel.applicationData['photocopyDocumentFee'] = originalSum.toString();
                      print('HEELO');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return UploadDocs();
                          },
                        ),
                      );
                    },
                    child: Container(
                        width: double.maxFinite,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: MyColors.gradient3),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: const Center(
                            child: Text(
                          "Next",
                          style: TextStyle(color: Colors.white),
                        )))),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                color: Colors.green[50],
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          flex: 8,
                          child: Text(
                            "Original Degree Attestation Fee",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            "PKR $originalSum",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 8,
                          child: Text(
                            "Photocopy Degree Attestation Fee",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            "PKR $copySum",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 8,
                          child: Text(
                            "Grand Total",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            "PKR ${originalSum + copySum}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: showFab ? const CenterDockedFAB() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: MyBottomNav(
          initialSelectedIndex: 3,
          onSeleted: (index) {
            if (index != 3) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return index == 0
                    ? MyHomePage()
                    : index == 1
                        ? const ProfilePage()
                        : const NotificationPage();
              }));
            }
          }),
    );
  }
}

// ignore: non_constant_identifier_names
class QuantityDoc {
  String DocName;
  int UnitPrice;
  int sum = 0;
  QuantityDoc({required this.DocName, required this.UnitPrice});
}

class ListofDocQuantity extends StatefulWidget {
  List<QuantityDoc> list;
  final Function(int)? onSumChanged;
  ListofDocQuantity({
    this.onSumChanged,
    required this.list,
    Key? key,
  }) : super(key: key);

  @override
  State<ListofDocQuantity> createState() => _ListofDocQuantityState();
}

class _ListofDocQuantityState extends State<ListofDocQuantity> {
  int Sum = 0;
  List<int> sums = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: List.generate(widget.list.length, (index) {
            return DocQuantity(
              DocName: widget.list[index].DocName,
              UnitPrice: widget.list[index].UnitPrice,
              onChange: (sum) {
                Sum = 0;
                setState(() {
                  widget.list[index].sum = sum;
                });
                for (var element in widget.list) {
                  setState(() {
                    Sum += element.sum;
                  });
                }
                if (widget.onSumChanged != null) {
                  widget.onSumChanged!(Sum);
                }
              },
            );
          }),
        ),
        Row(
          children: [
            const Expanded(
              flex: 8,
              child: Text(
                "Total Amount",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                "PKR $Sum",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class DocQuantity extends StatefulWidget {
  final String DocName;
  final int UnitPrice;
  final Function(int)? onChange;
  const DocQuantity({
    required this.DocName,
    required this.UnitPrice,
    this.onChange,
    Key? key,
  }) : super(key: key);

  @override
  State<DocQuantity> createState() => _DocQuantityState();
}

class _DocQuantityState extends State<DocQuantity> {
  var Qty = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      height: 60,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 4,
                child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.all(10),
                    child: Text(widget.DocName))),
            Expanded(
                flex: 1,
                child: InkWell(
                    onTap: () {
                      if (Qty > 0) {
                        setState(() {
                          Qty--;
                          widget.onChange!(Qty * widget.UnitPrice);
                        });
                      }
                    },
                    child: Container(
                        alignment: Alignment.center,
                        color: Colors.blue[50],
                        child: const Icon(Entypo.minus)))),
            Expanded(
                flex: 1,
                child: Container(
                    alignment: Alignment.center, child: Text(Qty.toString()))),
            Expanded(
                flex: 1,
                child: InkWell(
                    onTap: () {
                      setState(() {
                        Qty++;
                        if (widget.onChange != null) {
                          widget.onChange!(Qty * widget.UnitPrice);
                        }
                      });
                    },
                    child: Container(
                        alignment: Alignment.center,
                        color: Colors.blue[50],
                        child: const Icon(Entypo.plus)))),
            Expanded(
                flex: 4,
                child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.all(10),
                    child: Text("PKR ${widget.UnitPrice}"))),
          ],
        ),
      ),
    );
  }
}

class ExpandableQuantitySelector extends StatefulWidget {
  final Function(int, int) onSumChange;
  final Map titleInfo;
  const ExpandableQuantitySelector(
      {Key? key, required this.onSumChange, required this.titleInfo})
      : super(key: key);

  @override
  _ExpandableQuantitySelectorState createState() =>
      _ExpandableQuantitySelectorState();
}

class _ExpandableQuantitySelectorState
    extends State<ExpandableQuantitySelector> {
  var list = [
    QuantityDoc(DocName: "Degree", UnitPrice: 1000),
    QuantityDoc(DocName: "Transcript", UnitPrice: 1000),
    QuantityDoc(DocName: "Provisional Certificate", UnitPrice: 1000),
    QuantityDoc(DocName: "Equivalence Certificate", UnitPrice: 1000),
  ];
  var list2 = [
    QuantityDoc(DocName: "Degree", UnitPrice: 1000),
    QuantityDoc(DocName: "Transcript", UnitPrice: 1000),
    QuantityDoc(DocName: "Provisional Certificate", UnitPrice: 1000),
    QuantityDoc(DocName: "Equivalence Certificate", UnitPrice: 1000),
  ];
  int selectedEducationIndex = 0;
  int originalSum = 0;
  int copySum = 0;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: Colors.black,
      collapsedIconColor: Colors.black,
      textColor: Colors.black,
      collapsedTextColor: Colors.black,
      tilePadding: const EdgeInsets.all(0),
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(widget.titleInfo['department']),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(widget.titleInfo['sessionType'].toString()),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(widget.titleInfo['qualificationLevel'].toString()),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(widget.titleInfo['universityName'].toString()),
          ],
        ),
      ),
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Is this degree attested before?",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.black),
                  )),
            ),
            const OrangeInforCard(
                text:
                    "Has your degree already been attested by HEC in between. march 2009 to May 28, 2017? If yes then please click on option \"Yes\", enter attestation ticket number and validate it. Applicant whose degree has been attested during aforementioned period and now they are applying for attestation of Duplicate/Revised degree will proceed with option \"No\". Applicants whose degree has been attested before March 2009 will also proceed with option \"No\"."),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 1),
              child: Row(
                children: List.generate(['Yes', 'No'].length, (index) {
                  return RectangleToggleButton(
                    Label: ['Yes', 'No'][index],
                    selected: selectedEducationIndex == index ? true : false,
                    onSelected: (value) {
                      setState(() {
                        selectedEducationIndex = index;
                      });
                    },
                    svg: index == 0
                        ? 'assets/icons/verified.svg'
                        : 'assets/icons/notVerified.svg',
                  );
                }),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Name on Degree
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Stamp Number",
                    contentPadding: EdgeInsets.all(15),
                    border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Pages of Original Documents",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.black),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            ListofDocQuantity(
              onSumChanged: (sum) {
                setState(() {
                  originalSum = sum;
                  widget.onSumChange(originalSum, copySum);
                });
              },
              list: list,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Pages of Photocopy Documents",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.black),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            ListofDocQuantity(
              onSumChanged: (sum) {
                setState(() {
                  copySum = sum;
                  widget.onSumChange(originalSum, copySum);
                });
              },
              list: list2,
            )
          ],
        ),
      ],
    );
  }
}
