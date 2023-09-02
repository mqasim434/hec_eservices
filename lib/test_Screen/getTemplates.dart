import 'package:flutter/material.dart';
import 'package:hec_eservices/Models/TemplateModel.dart';

class UniversityTemplatesScreen extends StatefulWidget {
  const UniversityTemplatesScreen({super.key});

  @override
  State<UniversityTemplatesScreen> createState() =>
      _UniversityTemplatesScreenState();
}

class _UniversityTemplatesScreenState extends State<UniversityTemplatesScreen> {
  @override
  void getTemplates() async {
    await UniversityTemplates.fetchTemplates();
    ;
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getTemplates();
  }

  @override
  Widget build(BuildContext context) {
    var data = UniversityTemplates.universityTemplatesList;
    return Scaffold(
        body: Center(
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Text('University Name: ${data[index].University_Name}'),
                Text('Degree Template: ${data[index].Degree_Template}'),
                Text('Transcript Template: ${data[index].Transcript_Template}'),
                Text(
                    'Provisional Template: ${data[index].Provisional_Template}'),
                Text(
                    'Equivalence Template: ${data[index].Equivalence_Template}'),
                Divider(
                  thickness: 2,
                ),
              ],
            );
          }),
    ));
  }
}
