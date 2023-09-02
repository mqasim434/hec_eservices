import 'package:hec_eservices/Models/UserModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/config.dart';

class Application {
  final String? userCnic;
  final String? attestationMode;
  final String? fromWhere;
  final String? district;
  final String? originalDocumentFee;
  final String? photocopyDocumentFee;
  final String? cnicFront;
  final String? cnicBack;

  Application({
    this.userCnic,
    this.attestationMode,
    this.fromWhere,
    this.district,
    this.originalDocumentFee,
    this.photocopyDocumentFee,
    this.cnicFront,
    this.cnicBack,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      userCnic: json['userCnic'] as String?,
      attestationMode: json['attestationMode'] as String?,
      fromWhere: json['fromWhere'] as String?,
      district: json['district'] as String?,
      originalDocumentFee: json['originalDocumentFee'] as String?,
      photocopyDocumentFee: json['photocopyDocumentFee'] as String?,
      cnicFront: json['cnicFront'] as String?,
      cnicBack: json['cnicBack'] as String?,
    );
  }

  static int applicationCount = 0;

  static List<dynamic> applications = [];

  static Future<void> fetchApplications() async{
    final apiUrl = '$baseUrl/getApplications/${UserModel.CurrentUserCnic}'; // Replace with your API URL
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
        Application.applications = data;
       Application.applicationCount = data.length;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception or handle the error as needed
      throw Exception('Failed to load applications');
    }
  }

  static List<String> degreeInstitutes = [];
}
