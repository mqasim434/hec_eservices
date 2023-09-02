import 'dart:convert';
import 'package:hec_eservices/utils/config.dart';
import 'package:http/http.dart' as http;


class Dropdowns {
  final List<String> universities;
  final List<String> campuses;
  final List<String> qualificationLevels;
  final List<String> degrees;
  final List<String> departments;
  final List<String> sessions;
  final List<String> degreeTypes;

  Dropdowns({
    required this.universities,
    required this.campuses,
    required this.qualificationLevels,
    required this.degrees,
    required this.departments,
    required this.sessions,
    required this.degreeTypes,
  });

  factory Dropdowns.fromJson(Map<String, dynamic> json) {
    return Dropdowns(
      universities: List<String>.from(json['universities']),
      campuses: List<String>.from(json['campuses']),
      qualificationLevels: List<String>.from(json['qualificationLevels']),
      degrees: List<String>.from(json['degrees']),
      departments: List<String>.from(json['departments']),
      sessions: List<String>.from(json['sessions']),
      degreeTypes: List<String>.from(json['degreeTypes']),
    );
  }
}

class DropdownDataSingleton {
  static Dropdowns? _instance;

  // Private constructor to prevent instantiation
  DropdownDataSingleton._();

  static Dropdowns get instance {
    if (_instance == null) {
      // If the instance doesn't exist, fetch the data from the server
      fetchData();
    }
    return _instance!;
  }

  static Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/getDropdowns'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        _instance = Dropdowns.fromJson(data);
      } else {
        throw Exception('Failed to fetch data from server');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}


