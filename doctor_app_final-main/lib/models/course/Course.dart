/// TeachingStaff_ID : 1013
/// PROF Name : "Hussam Al , Beheiri"
/// Courses_ID : "AIM 322"
/// Course_Name : "IP & Pattern Recognation"
/// Number Of Students : 9
/// tANames : ["Jihad Hassan"]
/// Photo : "https://ixwswhjospjukhbjqjzl.supabase.co/storage/v1/object/public/Files/Photos/Courses/pattern%20recog.jpeg?t=2024-05-07T01%3A53%3A02.134Z"

class Course {
  Course({
      this.teachingStaffID, 
      this.pROFName, 
      this.coursesID, 
      this.courseName, 
      this.numberOfStudents, 
      this.tANames, 
      this.photo,});

  Course.fromJson(dynamic json) {
    teachingStaffID = json['TeachingStaff_ID'];
    pROFName = json['PROF Name'];
    coursesID = json['Courses_ID'];
    courseName = json['Course_Name'];
    numberOfStudents = json['Number Of Students'];
    tANames = json['tANames'] != null ? json['tANames'].cast<String>() : [];
    photo = json['Photo'];
  }
  num? teachingStaffID;
  String? pROFName;
  String? coursesID;
  String? courseName;
  num? numberOfStudents;
  List<String>? tANames;
  String? photo;
Course copyWith({  num? teachingStaffID,
  String? pROFName,
  String? coursesID,
  String? courseName,
  num? numberOfStudents,
  List<String>? tANames,
  String? photo,
}) => Course(  teachingStaffID: teachingStaffID ?? this.teachingStaffID,
  pROFName: pROFName ?? this.pROFName,
  coursesID: coursesID ?? this.coursesID,
  courseName: courseName ?? this.courseName,
  numberOfStudents: numberOfStudents ?? this.numberOfStudents,
  tANames: tANames ?? this.tANames,
  photo: photo ?? this.photo,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TeachingStaff_ID'] = teachingStaffID;
    map['PROF Name'] = pROFName;
    map['Courses_ID'] = coursesID;
    map['Course_Name'] = courseName;
    map['Number Of Students'] = numberOfStudents;
    map['tANames'] = tANames;
    map['Photo'] = photo;
    return map;
  }

}