/// Student_ID : [202201998]
/// Student_Name : ["احمد اسماعيل  السعيد  "]
/// Project_ID : 186
/// Project_Title : "5ara to be "
/// Project_Description : "test"
/// Leader(Student)_ID : 202201998
/// Leader_Name : "احمد اسماعيل  السعيد  "
/// TeachingStaff_ID(Prof) : null
/// Prof_Name : "   "
/// TeachingStaff_ID(TA) : null
/// TA_Name : "   "
/// Secret_Key : " eb ot ara50c0d5b8e"

class StudentEnrolledToGp {
  StudentEnrolledToGp({
      this.studentID, 
      this.studentName, 
      this.projectID, 
      this.projectTitle, 
      this.projectDescription, 
      this.leaderStudentID, 
      this.leaderName, 
      this.teachingStaffIDProf, 
      this.profName, 
      this.teachingStaffIDTA, 
      this.tAName, 
      this.secretKey,});

  StudentEnrolledToGp.fromJson(dynamic json) {
    studentID = json['Student_ID'] != null ? json['Student_ID'].cast<num>() : [];
    studentName = json['Student_Name'] != null ? json['Student_Name'].cast<String>() : [];
    projectID = json['Project_ID'];
    projectTitle = json['Project_Title'];
    projectDescription = json['Project_Description'];
    leaderStudentID = json['Leader(Student)_ID'];
    leaderName = json['Leader_Name'];
    teachingStaffIDProf = json['TeachingStaff_ID(Prof)'];
    profName = json['Prof_Name'];
    teachingStaffIDTA = json['TeachingStaff_ID(TA)'];
    tAName = json['TA_Name'];
    secretKey = json['Secret_Key'];
  }
  List<num>? studentID;
  List<String>? studentName;
  num? projectID;
  String? projectTitle;
  String? projectDescription;
  num? leaderStudentID;
  String? leaderName;
  dynamic teachingStaffIDProf;
  String? profName;
  dynamic teachingStaffIDTA;
  String? tAName;
  String? secretKey;
StudentEnrolledToGp copyWith({  List<num>? studentID,
  List<String>? studentName,
  num? projectID,
  String? projectTitle,
  String? projectDescription,
  num? leaderStudentID,
  String? leaderName,
  dynamic teachingStaffIDProf,
  String? profName,
  dynamic teachingStaffIDTA,
  String? tAName,
  String? secretKey,
}) => StudentEnrolledToGp(  studentID: studentID ?? this.studentID,
  studentName: studentName ?? this.studentName,
  projectID: projectID ?? this.projectID,
  projectTitle: projectTitle ?? this.projectTitle,
  projectDescription: projectDescription ?? this.projectDescription,
  leaderStudentID: leaderStudentID ?? this.leaderStudentID,
  leaderName: leaderName ?? this.leaderName,
  teachingStaffIDProf: teachingStaffIDProf ?? this.teachingStaffIDProf,
  profName: profName ?? this.profName,
  teachingStaffIDTA: teachingStaffIDTA ?? this.teachingStaffIDTA,
  tAName: tAName ?? this.tAName,
  secretKey: secretKey ?? this.secretKey,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Student_ID'] = studentID;
    map['Student_Name'] = studentName;
    map['Project_ID'] = projectID;
    map['Project_Title'] = projectTitle;
    map['Project_Description'] = projectDescription;
    map['Leader(Student)_ID'] = leaderStudentID;
    map['Leader_Name'] = leaderName;
    map['TeachingStaff_ID(Prof)'] = teachingStaffIDProf;
    map['Prof_Name'] = profName;
    map['TeachingStaff_ID(TA)'] = teachingStaffIDTA;
    map['TA_Name'] = tAName;
    map['Secret_Key'] = secretKey;
    return map;
  }

}