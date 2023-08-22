class ComplaintModel {
  String? service;
  String? fullName;
  String? phoneNo;
  String? applicationId;
  String? searchBy;
  String? cnic;
  String? issue;

  ComplaintModel({
    this.service,
    this.fullName,
    this.phoneNo,
    this.applicationId,
    this.searchBy,
    this.cnic,
    this.issue
  });

  ComplaintModel.fromJson(dynamic json) {
    service = json['service'];
    fullName = json['fullName'];
    phoneNo = json['phoneNo'];
    applicationId = json['applicationId'];
    searchBy = json['searchBy'];
    cnic = json['cnic'];
    issue = json['issue'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service'] = service;
    map['fullName'] = fullName;
    map['phoneNo'] = phoneNo;
    map['applicationId'] = applicationId;
    map['searchBy'] = searchBy;
    map['cnic'] = cnic;
    map['issue'] = issue;
    return map;
  }
}

