
class CourseTeachinStaff {
  CourseTeachinStaff({
      this.teachingStaffID, 
      this.profName, 
      this.courseName, 
      this.coursesID, 
      this.numberOfStudents, 
      this.tANames,});

  CourseTeachinStaff.fromJson(dynamic json) {
    teachingStaffID = json['TeachingStaff_ID'];
    profName = json['Prof. Name'];
    courseName = json['Course_Name'];
    coursesID = json['Courses_ID'];
    numberOfStudents = json['Number Of Students'];
    tANames = json['TA Names'] != null ? json['TA Names'].cast<String>() : [];
  }
  num? teachingStaffID;
  String? profName;
  String? courseName;
  String? coursesID;
  num? numberOfStudents;
  List<String>? tANames;
CourseTeachinStaff copyWith({  num? teachingStaffID,
  String? profName,
  String? courseName,
  String? coursesID,
  num? numberOfStudents,
  List<String>? tANames,
}) => CourseTeachinStaff(  teachingStaffID: teachingStaffID ?? this.teachingStaffID,
  profName: profName ?? this.profName,
  courseName: courseName ?? this.courseName,
  coursesID: coursesID ?? this.coursesID,
  numberOfStudents: numberOfStudents ?? this.numberOfStudents,
  tANames: tANames ?? this.tANames,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TeachingStaff_ID'] = teachingStaffID;
    map['Prof. Name'] = profName;
    map['Course_Name'] = courseName;
    map['Courses_ID'] = coursesID;
    map['Number Of Students'] = numberOfStudents;
    map['TA Names'] = tANames;
    return map;
  }

}