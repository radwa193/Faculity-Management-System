/// Project_Title : "seniors to be "
/// Project_Description : "test"
/// Leader : "احمد اسماعيل  السعيد  "
/// Enrolled_Students : ["عبد الوهاب عماد الرشيدي حسن","احمد اسماعيل  السعيد  "]
/// prof ID : 1013
/// TeachingStaff_Name : "Hussam Al , Beheiri"

class ProjectAssigned {
  ProjectAssigned({
      this.projectTitle, 
      this.projectDescription, 
      this.leader, 
      this.enrolledStudents, 
      this.profID, 
      this.teachingStaffName,});

  ProjectAssigned.fromJson(dynamic json) {
    projectTitle = json['Project_Title'];
    projectDescription = json['Project_Description'];
    leader = json['Leader'];
    enrolledStudents = json['Enrolled_Students'] != null ? json['Enrolled_Students'].cast<String>() : [];
    profID = json['prof ID'];
    teachingStaffName = json['TeachingStaff_Name'];
  }
  String? projectTitle;
  String? projectDescription;
  String? leader;
  List<String>? enrolledStudents;
  num? profID;
  String? teachingStaffName;
ProjectAssigned copyWith({  String? projectTitle,
  String? projectDescription,
  String? leader,
  List<String>? enrolledStudents,
  num? profID,
  String? teachingStaffName,
}) => ProjectAssigned(  projectTitle: projectTitle ?? this.projectTitle,
  projectDescription: projectDescription ?? this.projectDescription,
  leader: leader ?? this.leader,
  enrolledStudents: enrolledStudents ?? this.enrolledStudents,
  profID: profID ?? this.profID,
  teachingStaffName: teachingStaffName ?? this.teachingStaffName,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Project_Title'] = projectTitle;
    map['Project_Description'] = projectDescription;
    map['Leader'] = leader;
    map['Enrolled_Students'] = enrolledStudents;
    map['prof ID'] = profID;
    map['TeachingStaff_Name'] = teachingStaffName;
    return map;
  }

}