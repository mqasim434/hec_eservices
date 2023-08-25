import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:hec_eservices/Screens/Applicatins_Screens/documentsDetails.dart';

import '../../Widgets/bottomNav.dart';
import '../../Widgets/bottomSheet.dart';
import '../../Widgets/fab.dart';
import '../../Widgets/rectangleToggle.dart';
import '../../utils/MyColors.dart';
import '../homepage.dart';
import '../notificationPage.dart';
import '../profile.dart';

class Questionaire extends StatefulWidget {
  const Questionaire({Key? key}) : super(key: key);

  @override
  _QuestionaireState createState() => _QuestionaireState();
}

class _QuestionaireState extends State<Questionaire> {
  var AttestationMode = TextEditingController();
  var District = TextEditingController();
  var pageController = PageController();
  int selectedMode = 2;
  int currentPage = 0;
  var Modes = ["Yes", "No"];
  bool nextButtonEnabled=false;
  int QuestionsAnswered=0;
  List<Map> myQuestions=[
    { "Selected":null,
      "Question":"Is your name, father's name including date of birth on your CNIC and your educational documents same?"},
    { "Selected":null,
      "Question":"Are all information including name, father's name, degree title, registration number, marks, etc. same on your degree and your transcripts?"},
    { "Selected":null,
      "Question":"Please confirm there is no erasing /misprint or any unreadable alphabet/word on your degrees or transcripts?"},
    { "Selected":null,
      "Question":"Do you have your valid original CNIC or Passport (for foreigner only) and original degrees along with transcripts to be presented at time of attestation?"},

  ];

  @override
  Widget build(BuildContext context) {
    var listofSeleted=[];
    for (var element in myQuestions) {listofSeleted.add(element['Selected']);}
    if(listofSeleted.contains(null)){
      nextButtonEnabled=false;
    }else{nextButtonEnabled=true;}

    QuestionsAnswered=listofSeleted.where((e)=>e!=null).toList().length;


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
                " Questionnaire",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        floatingActionButton: const AssistFAB(),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Next: Documents Details",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.black),
                    )),
              ),
              const WizardIndicator(
                selectedIndex: 1,
                length: 4,
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Question Answered: $QuestionsAnswered")),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                child: PageView(
                  onPageChanged: (index){
                    setState(() {
                      currentPage=index;
                    });
                  },
                  controller: pageController,
                  children: List.generate(myQuestions.length, (index) {
                    return Column(
                      children: [
                        Expanded(flex: 7,
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(myQuestions[index]["Question"], style: const TextStyle(fontSize: 18),)),),
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(Modes.length, (ModeIndex) {
                              return RectangleToggleButton(
                                Label: Modes[ModeIndex],
                                selected: myQuestions[index]["Selected"]==null?false:Modes[myQuestions[index]["Selected"] as int]==Modes[ModeIndex]?true:false,
                                onSelected: (value) {
                                  setState(() {
                                    pageController.animateToPage(currentPage+1, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                                    myQuestions[index]["Selected"]=ModeIndex;
                                  });
                                },
                                svg: index==0?'assets/smile.svg':'assets/sad.svg',
                              );
                            }),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
              Align(
                child: InkWell(
                    onTap: () {
                      if(nextButtonEnabled==false){
                        MyBottomSheet().showSnackbar(context: context, msg: "Please Answer All Questions.",type: SnackBarType.Alert);
                      }else{
                        Navigator.push(context, MaterialPageRoute(builder: (context){return const DocumentsDetails();}));
                      }
                    },
                    child: Container(
                        width: double.maxFinite,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: nextButtonEnabled?MyColors.gradient3:MyColors.gradient2),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: const Center(
                            child: Text(
                              "Next",
                              style: TextStyle(color: Colors.white),
                            )))),
              ),
              const SizedBox(height: 70,)
            ],
          ),
        ),
      ),
      floatingActionButton: const CenterDockedFAB(),
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

class WizardIndicator extends StatelessWidget {
  final int selectedIndex;
  final int length;
  const WizardIndicator({
    this.selectedIndex = 0,
    required this.length,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: (selectedIndex + 1).toString(),
                  style: const TextStyle(fontSize: 15, color: MyColors.greenColor)),
              TextSpan(
                  text: "/${length.toString()}",
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ]),
          ),
        ),
        Row(
            children: List.generate(
              length,
                  (index) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        gradient:
                        index <= selectedIndex ? MyColors.gradient3 : null,
                        color: index > selectedIndex ? Colors.black12 : null),
                    height: 5,
                  ),
                );
              },
            ))
      ],
    );
  }
}
