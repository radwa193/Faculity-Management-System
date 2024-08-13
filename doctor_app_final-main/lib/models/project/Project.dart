/// Project_ID : 187
/// Project_Title : "GRAD"
/// Project_Description : "2ND"
/// Leader : "سما  رائد  زينهوم "
/// Enrolled_Students : null
/// TeachingStaff_ID(Prof) : null

class Project {
  Project({
      this.projectID, 
      this.projectTitle, 
      this.projectDescription, 
      this.leader, 
      this.enrolledStudents, 
      this.teachingStaffIDProf,});

  Project.fromJson(dynamic json) {
    projectID = json['Project_ID'];
    projectTitle = json['Project_Title'];
    projectDescription = json['Project_Description'];
    leader = json['Leader'];
    enrolledStudents = json['Enrolled_Students'];
    teachingStaffIDProf = json['TeachingStaff_ID(Prof)'];
  }
  num? projectID;
  String? projectTitle;
  String? projectDescription;
  String? leader;
  dynamic enrolledStudents;
  dynamic teachingStaffIDProf;
Project copyWith({  num? projectID,
  String? projectTitle,
  String? projectDescription,
  String? leader,
  dynamic enrolledStudents,
  dynamic teachingStaffIDProf,
}) => Project(  projectID: projectID ?? this.projectID,
  projectTitle: projectTitle ?? this.projectTitle,
  projectDescription: projectDescription ?? this.projectDescription,
  leader: leader ?? this.leader,
  enrolledStudents: enrolledStudents ?? this.enrolledStudents,
  teachingStaffIDProf: teachingStaffIDProf ?? this.teachingStaffIDProf,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Project_ID'] = projectID;
    map['Project_Title'] = projectTitle;
    map['Project_Description'] = projectDescription;
    map['Leader'] = leader;
    map['Enrolled_Students'] = enrolledStudents;
    map['TeachingStaff_ID(Prof)'] = teachingStaffIDProf;
    return map;
  }

}