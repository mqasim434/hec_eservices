import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddNote extends StatelessWidget {
   AddNote({super.key});

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

   void addNote(String title, String description) async {
     final response = await http.post(
         Uri.parse(
             'https://notes-app-backend-9f6c04079851.herokuapp.com/saveNote'),
         body: {
           'title': title,
           'description': description,
         });

     if (response.statusCode == 200) {
       print('Note Added Successfully');
     } else {
       throw Exception('Failed to Add notes');
     }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Note',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
              ),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Description',
              ),
            ),
            InkWell(
              onTap: () {
                String title = titleController.text.toString();
                String description = descriptionController.text.toString();
                addNote(title, description);
                Navigator.pop(
                  context,
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  width: 150,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
