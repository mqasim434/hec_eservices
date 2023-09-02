class NotesModel {
  String id;
  String title;
  String description;

  NotesModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      id: json['_id'].toString(),
      title: json['title'].toString(),
      description: json['description'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id.toString(),
      'title': title.toString(),
      'description': description.toString(),
    };
  }
}
