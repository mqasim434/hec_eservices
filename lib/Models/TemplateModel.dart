import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hec_eservices/utils/config.dart';
import 'package:http/http.dart' as http;

// Define a model class to represent the data
class UniversityTemplates {
  final String id;
  final String University_Name;
  final String Degree_Template;
  final String Provisional_Template;
  final String Equivalence_Template;
  final String Transcript_Template;

  UniversityTemplates({
    required this.id,
    required this.University_Name,
    required this.Degree_Template,
    required this.Provisional_Template,
    required this.Equivalence_Template,
    required this.Transcript_Template,
  });

  factory UniversityTemplates.fromJson(Map<String, dynamic> json) {
    return UniversityTemplates(
      id: json['_id'],
      University_Name: json['University_Name'],
      Degree_Template: json['Degree_Template'],
      Provisional_Template: json['Provisional_Template'],
      Equivalence_Template: json['Equivalence_Template'],
      Transcript_Template: json['Transcript_Template'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'University_Name': University_Name,
      'Degree_Template': Degree_Template,
      'Provisional_Template': Provisional_Template,
      'Equivalence_Template': Equivalence_Template,
      'Transcript_Template': Transcript_Template,
    };
  }

  static List<UniversityTemplates> universityTemplatesList = [];

  static Future<void> fetchTemplates() async {
    final response = await http.get(Uri.parse('$baseUrl/getTemplates'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final universities = jsonData.map((json) => UniversityTemplates.fromJson(json)).toList();
      UniversityTemplates.universityTemplatesList.addAll(universities);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

