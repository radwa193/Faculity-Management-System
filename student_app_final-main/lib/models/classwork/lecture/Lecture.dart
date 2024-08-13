
class Lecture {
  Lecture({
      this.studentID, 
      this.courseName, 
      this.level, 
      this.attType, 
      this.day, 
      this.periodStart, 
      this.periodEnd, 
      this.group, 
      this.room, 
      this.teachingStaffNames,});

  Lecture.fromJson(dynamic json) {
    studentID = json['Student_ID'];
    courseName = json['Course_Name'];
    level = json['Level'];
    attType = json['AttType'];
    day = json['Day'];
    periodStart = json['Period_Start'];
    periodEnd = json['PeriodEnd'];
    group = json['Group'];
    room = json['Room'];
    teachingStaffNames = json['Teaching Staff Names'] != null ? json['Teaching Staff Names'].cast<String>() : [];
  }
  num? studentID;
  String? courseName;
  num? level;
  String? attType;
  String? day;
  String? periodStart;
  String? periodEnd;
  String? group;
  num? room;
  List<String>? teachingStaffNames;
Lecture copyWith({  num? studentID,
  String? courseName,
  num? level,
  String? attType,
  String? day,
  String? periodStart,
  String? periodEnd,
  String? group,
  num? room,
  List<String>? teachingStaffNames,
}) => Lecture(  studentID: studentID ?? this.studentID,
  courseName: courseName ?? this.courseName,
  level: level ?? this.level,
  attType: attType ?? this.attType,
  day: day ?? this.day,
  periodStart: periodStart ?? this.periodStart,
  periodEnd: periodEnd ?? this.periodEnd,
  group: group ?? this.group,
  room: room ?? this.room,
  teachingStaffNames: teachingStaffNames ?? this.teachingStaffNames,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Student_ID'] = studentID;
    map['Course_Name'] = courseName;
    map['Level'] = level;
    map['AttType'] = attType;
    map['Day'] = day;
    map['Period_Start'] = periodStart;
    map['PeriodEnd'] = periodEnd;
    map['Group'] = group;
    map['Room'] = room;
    map['Teaching Staff Names'] = teachingStaffNames;
    return map;
  }

}