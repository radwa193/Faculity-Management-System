/// Assignment_ID : 1
/// Title : "C# project"
/// Description : "testing assignments"
/// Courses_ID : "ISM 226"
/// Course_Name : "Database Management Systems (1)"
/// Student_ID : 202201998
/// Type : "Section"
/// Deadline : "2024-04-30T00:00:00"

class Assignment {
  Assignment({
      this.assignmentID, 
      this.title, 
      this.description, 
      this.coursesID, 
      this.courseName, 
      this.studentID, 
      this.type, 
      this.deadline,});

  Assignment.fromJson(dynamic json) {
    assignmentID = json['Assignment_ID'];
    title = json['Title'];
    description = json['Description'];
    coursesID = json['Courses_ID'];
    courseName = json['Course_Name'];
    studentID = json['Student_ID'];
    type = json['Type'];
    deadline = json['Deadline'];
  }
  int? assignmentID;
  String? title;
  String? description;
  String? coursesID;
  String? courseName;
  num? studentID;
  String? type;
  String? deadline;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Assignment_ID'] = assignmentID;
    map['Title'] = title;
    map['Description'] = description;
    map['Courses_ID'] = coursesID;
    map['Course_Name'] = courseName;
    map['Student_ID'] = studentID;
    map['Type'] = type;
    map['Deadline'] = deadline;
    return map;
  }

}