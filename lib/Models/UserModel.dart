import 'package:http/http.dart' as http;
import 'dart:convert';

class UserModel {
  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.country,
    this.identityType,
    this.cnic,
    this.phoneNo,
    this.email,
    this.password,
    this.confirmPassword,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.gender,
    this.maritalStatus,
    this.dateOfBirth,
    this.fatherName,
    this.city,
    this.district,
    this.postalCode,
    this.address,
  });

  String? id;
  String? firstName;
  String? lastName;
  String? country;
  String? identityType;
  String? cnic;
  String? phoneNo;
  String? email;
  String? password;
  String? confirmPassword;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? gender;
  String? maritalStatus;
  String? dateOfBirth;
  String? fatherName;
  String? city;
  String? district;
  String? postalCode;
  String? address;
  String? imageUrl;

  UserModel.fromJson(dynamic json) {
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    country = json['country'];
    identityType = json['identityType'];
    cnic = json['cnic'];
    phoneNo = json['phoneNo'];
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    gender = json['gender'];
    maritalStatus = json['maritalStatus'];
    dateOfBirth = json['dateOfBirth'];
    fatherName = json['fatherName'];
    city = json['city'];
    district = json['district'];
    postalCode = json['postalCode'];
    address = json['address'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['country'] = country;
    map['identityType'] = identityType;
    map['cnic'] = cnic;
    map['phoneNo'] = phoneNo;
    map['email'] = email;
    map['password'] = password;
    map['imageUrl'] = imageUrl;
    map['confirmPassword'] = confirmPassword;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['gender'] = gender;
    map['maritalStatus'] = maritalStatus;
    map['dateOfBirth'] = dateOfBirth;
    map['fatherName'] = fatherName;
    map['city'] = city;
    map['district'] = district;
    map['postalCode'] = postalCode;
    map['address'] = address;
    return map;
  }

  static String CurrentUserCnic = 'noCnic';


  static List<Map<dynamic,dynamic>> degrees = [];

  static Map<String,dynamic> applicationData = {};

}




