

class Result {
  Result({
      this.attType, 
      this.title, 
      this.coursesID, 
      this.courseName, 
      this.studentID, 
      this.studentName, 
      this.degree,});

  Result.fromJson(dynamic json) {
    attType = json['attType'];
    title = json['Title'];
    coursesID = json['Courses_ID'];
    courseName = json['Course_Name'];
    studentID = json['Student_ID'];
    studentName = json['Student Name'];
    degree = json['Degree'];
  }
  String? attType;
  String? title;
  String? coursesID;
  String? courseName;
  num? studentID;
  String? studentName;
  String? degree;
  Result copyWith({  String? attType,
  String? title,
  String? coursesID,
  String? courseName,
  num? studentID,
  String? studentName,
  String? degree,
}) => Result(  attType: attType ?? this.attType,
  title: title ?? this.title,
  coursesID: coursesID ?? this.coursesID,
  courseName: courseName ?? this.courseName,
  studentID: studentID ?? this.studentID,
  studentName: studentName ?? this.studentName,
  degree: degree ?? this.degree,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attType'] = attType;
    map['Title'] = title;
    map['Courses_ID'] = coursesID;
    map['Course_Name'] = courseName;
    map['Student_ID'] = studentID;
    map['Student Name'] = studentName;
    map['Degree'] = degree;
    return map;
  }

}