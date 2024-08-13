

class Quiz {
  Quiz({
      this.id, 
      this.studentID, 
      this.title, 
      this.description, 
      this.courseName, 
      this.attType, 
      this.date, 
      this.ofDegrees,});

  Quiz.fromJson(dynamic json) {
    id = json['ID'];
    studentID = json['Student_ID'];
    title = json['Title'];
    description = json['Description'];
    courseName = json['Course_Name'];
    attType = json['AttType'];
    date = json['Date'];
    ofDegrees = json['Of Degrees: '];
  }
  num? id;
  num? studentID;
  String? title;
  dynamic description;
  String? courseName;
  String? attType;
  String? date;
  num? ofDegrees;
Quiz copyWith({  num? id,
  num? studentID,
  String? title,
  dynamic description,
  String? courseName,
  String? attType,
  String? date,
  num? ofDegrees,
}) => Quiz(  id: id ?? this.id,
  studentID: studentID ?? this.studentID,
  title: title ?? this.title,
  description: description ?? this.description,
  courseName: courseName ?? this.courseName,
  attType: attType ?? this.attType,
  date: date ?? this.date,
  ofDegrees: ofDegrees ?? this.ofDegrees,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['Student_ID'] = studentID;
    map['Title'] = title;
    map['Description'] = description;
    map['Course_Name'] = courseName;
    map['AttType'] = attType;
    map['Date'] = date;
    map['Of Degrees: '] = ofDegrees;
    return map;
  }

}