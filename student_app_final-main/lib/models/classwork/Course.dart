/// Student_ID : 202201998
/// Full Name : "احمد اسماعيل  السعيد  "
/// Course Name : "Project (1)"
/// Courses_ID : "FRM 416"
/// Photo : "https://ixwswhjospjukhbjqjzl.supabase.co/storage/v1/object/public/Files/Photos/Courses/2023%20Graduation%20Cap,%20SVG%20for%20Cricut,%20High%20School%20Grad%20Svg,%20Commercial%20Use%20Cut%20File,%20Last%20Day%20of%20School%20Png,%20Instant%20Download,%20Silhouette.jpeg"

class Course {
  Course({
      this.studentID, 
      this.fullName, 
      this.courseName, 
      this.coursesID, 
      this.photo,});

  Course.fromJson(dynamic json) {
    studentID = json['Student_ID'];
    fullName = json['Full Name'];
    courseName = json['Course Name'];
    coursesID = json['Courses_ID'];
    photo = json['Photo'];
  }
  num? studentID;
  String? fullName;
  String? courseName;
  String? coursesID;
  String? photo;
Course copyWith({  num? studentID,
  String? fullName,
  String? courseName,
  String? coursesID,
  String? photo,
}) => Course(  studentID: studentID ?? this.studentID,
  fullName: fullName ?? this.fullName,
  courseName: courseName ?? this.courseName,
  coursesID: coursesID ?? this.coursesID,
  photo: photo ?? this.photo,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Student_ID'] = studentID;
    map['Full Name'] = fullName;
    map['Course Name'] = courseName;
    map['Courses_ID'] = coursesID;
    map['Photo'] = photo;
    return map;
  }

}