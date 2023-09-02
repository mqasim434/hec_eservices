import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hec_eservices/Notes/Model/NotesModel.dart';
import 'package:hec_eservices/Notes/Screens/add_note.dart';
import 'package:hec_eservices/Notes/Screens/update_note.dart';
import 'package:hec_eservices/Notes/Widgets/notes_widget.dart';

import 'package:http/http.dart' as http;

class NotesScreen extends StatefulWidget {
  NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  bool isLoading = true;

  Future<List<NotesModel>> fetchNotes() async {
    final response = await http.get(Uri.parse(
        'https://notes-app-backend-9f6c04079851.herokuapp.com/getNotes'));

    if (response.statusCode == 200) {
      final List<dynamic> notesJson = json.decode(response.body);
      List<NotesModel> notesList = [];

      for (var noteJson in notesJson) {
        notesList.add(NotesModel.fromJson(noteJson));
      }
      setState(() {
        isLoading = false;
      });
      return notesList;
    } else {
      throw Exception('Failed to load notes');
    }
  }

  List<NotesModel> notesList = [];

  @override
  Widget build(BuildContext context) {
    fetchNotes().then((value) {
      setState(() {
        notesList = value;
        print("Note ${notesList[0].toString()}");
      });
    });
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNote(),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text(
            'Your Notes',
          ),
          centerTitle: true,
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                  NotesModel currentNote = notesList[notesList.length-index-1];
                  return NoteWidget(
                    Note: currentNote,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateNote(
                            Note: currentNote,
                          ),
                        ),
                      );
                    },
                    onLongPress: () {},
                  );
                }),
      ),
    );
  }
}
