import 'package:flutter/material.dart';
import 'package:hec_eservices/Notes/Model/NotesModel.dart';

class NoteWidget extends StatelessWidget {
  NoteWidget(
      {super.key,
      required this.Note,
      required this.onTap,
      required this.onLongPress});

  NotesModel Note;
  var onLongPress;
  var onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: 150,
          height: 150,
          decoration: const BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Note.title.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                Text(
                  Note.description.toString(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
