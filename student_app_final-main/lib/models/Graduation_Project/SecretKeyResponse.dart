

class SecretKeyResponse {
  SecretKeyResponse({
      this.projectID, 
      this.projectTitle, 
      this.projectDescription, 
      this.leaderStudentID, 
      this.teachingStaffIDProf, 
      this.teachingStaffIDTA, 
      this.profConfirmation, 
      this.projectConfirmation, 
      this.secretKey,});

  SecretKeyResponse.fromJson(dynamic json) {
    projectID = json['Project_ID'];
    projectTitle = json['Project_Title'];
    projectDescription = json['Project_Description'];
    leaderStudentID = json['Leader(Student)_ID'];
    teachingStaffIDProf = json['TeachingStaff_ID(Prof)'];
    teachingStaffIDTA = json['TeachingStaff_ID(TA)'];
    profConfirmation = json['Prof_Confirmation'];
    projectConfirmation = json['Project_Confirmation'];
    secretKey = json['Secret_Key'];
  }
  num? projectID;
  String? projectTitle;
  String? projectDescription;
  num? leaderStudentID;
  dynamic teachingStaffIDProf;
  dynamic teachingStaffIDTA;
  dynamic profConfirmation;
  dynamic projectConfirmation;
  String? secretKey;
SecretKeyResponse copyWith({  num? projectID,
  String? projectTitle,
  String? projectDescription,
  num? leaderStudentID,
  dynamic teachingStaffIDProf,
  dynamic teachingStaffIDTA,
  dynamic profConfirmation,
  dynamic projectConfirmation,
  String? secretKey,
}) => SecretKeyResponse(  projectID: projectID ?? this.projectID,
  projectTitle: projectTitle ?? this.projectTitle,
  projectDescription: projectDescription ?? this.projectDescription,
  leaderStudentID: leaderStudentID ?? this.leaderStudentID,
  teachingStaffIDProf: teachingStaffIDProf ?? this.teachingStaffIDProf,
  teachingStaffIDTA: teachingStaffIDTA ?? this.teachingStaffIDTA,
  profConfirmation: profConfirmation ?? this.profConfirmation,
  projectConfirmation: projectConfirmation ?? this.projectConfirmation,
  secretKey: secretKey ?? this.secretKey,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Project_ID'] = projectID;
    map['Project_Title'] = projectTitle;
    map['Project_Description'] = projectDescription;
    map['Leader(Student)_ID'] = leaderStudentID;
    map['TeachingStaff_ID(Prof)'] = teachingStaffIDProf;
    map['TeachingStaff_ID(TA)'] = teachingStaffIDTA;
    map['Prof_Confirmation'] = profConfirmation;
    map['Project_Confirmation'] = projectConfirmation;
    map['Secret_Key'] = secretKey;
    return map;
  }

}