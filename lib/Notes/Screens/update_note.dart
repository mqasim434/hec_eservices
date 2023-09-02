import 'package:flutter/material.dart';
import 'package:hec_eservices/Notes/Model/NotesModel.dart';
import 'package:http/http.dart' as http;

class UpdateNote extends StatelessWidget {
  UpdateNote({super.key, required this.Note});

  NotesModel Note;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void updateNote(String title, String description) async {
    final response = await http.patch(
        Uri.parse(
            'https://notes-app-backend-9f6c04079851.herokuapp.com/updateNote/${Note.id.toString()}'),
        body: {
          'title': title,
          'description': description,
        });

    if (response.statusCode == 200) {
      print('Note Updated Successfully');
    } else {
      throw Exception('Failed to update note');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Note',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: Note.title,
              ),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: Note.description,
              ),
            ),
            InkWell(
              onTap: () {
                String title = titleController.text.toString();
                String description = descriptionController.text.toString();
                updateNote(title, description);
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
