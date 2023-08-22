class EducationModel {
  String? userCnic;
  String? qualificationLevel;
  String? education;
  String? startDate;
  String? endDate;
  String? currentlyEnrolled;
  String? nameOnDegree;
  String? country;
  String? degreeAwardInstitute;
  String? programTitle;
  String? universityName;
  String? campus;
  String? department;
  String? degreeType;
  String? sessionType;
  String? areaOfResearch;
  String? rollNo;

  EducationModel({
      this.userCnic, 
      this.qualificationLevel, 
      this.education, 
      this.startDate, 
      this.endDate, 
      this.currentlyEnrolled, 
      this.nameOnDegree, 
      this.country, 
      this.degreeAwardInstitute, 
      this.programTitle, 
      this.universityName,
      this.campus, 
      this.department, 
      this.degreeType,
      this.sessionType, 
      this.areaOfResearch,
      this.rollNo,
  });

  EducationModel.fromJson(dynamic json) {
    userCnic = json['userCnic'];
    qualificationLevel = json['qualificationLevel'];
    education = json['education'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    currentlyEnrolled = json['currentlyEnrolled'];
    nameOnDegree = json['nameOnDegree'];
    country = json['country'];
    degreeAwardInstitute = json['degreeAwardInstitute'];
    programTitle = json['programTitle'];
    universityName = json['universityName'];
    campus = json['campus'];
    department = json['department'];
    degreeType = json['degreeType'];
    sessionType = json['sessionType'];
    areaOfResearch = json['areaOfResearch'];
    rollNo = json['rollNo'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userCnic'] = userCnic;
    map['qualificationLevel'] = qualificationLevel;
    map['education'] = education;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['currentlyEnrolled'] = currentlyEnrolled;
    map['nameOnDegree'] = nameOnDegree;
    map['country'] = country;
    map['degreeAwardInstitute'] = degreeAwardInstitute;
    map['programTitle'] = programTitle;
    map['universityName'] = universityName;
    map['campus'] = campus;
    map['department'] = department;
    map['degreeType'] = degreeType;
    map['sessionType'] = sessionType;
    map['areaOfResearch'] = areaOfResearch;
    map['rollNo'] = rollNo;
    return map;
  }
}

EducationModel educationModel = EducationModel();

