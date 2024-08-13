/// Courses_ID : "ISM 226"
/// Student_ID : [202201998,202202011,202202236,202202424,202202691,202202941,202202988,202203039,202203195,202203301,202203571,202205654,202268671]

class StudentsEnrolledToCourse {
  StudentsEnrolledToCourse({
      this.coursesID, 
      this.studentID,});

  StudentsEnrolledToCourse.fromJson(dynamic json) {
    coursesID = json['Courses_ID'];
    studentID = json['Student_ID'] != null ? json['Student_ID'].cast<num>() : [];
  }
  String? coursesID;
  List<num>? studentID;
StudentsEnrolledToCourse copyWith({  String? coursesID,
  List<num>? studentID,
}) => StudentsEnrolledToCourse(  coursesID: coursesID ?? this.coursesID,
  studentID: studentID ?? this.studentID,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Courses_ID'] = coursesID;
    map['Student_ID'] = studentID;
    return map;
  }

}