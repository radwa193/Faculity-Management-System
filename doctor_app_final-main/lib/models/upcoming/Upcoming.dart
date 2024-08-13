/// TeachingStaff_ID : 1013
/// TeachingStaff_Name : "Hussam Al , Beheiri"
/// Course_Name : "IP & Pattern Recognation"
/// Level : 3
/// AttType : "Lecture"
/// Day : "Monday"
/// Period_Start : "02:25:00"
/// PeriodEnd : "03:55:00"
/// Groups : ["E - F"]
/// Room : 3101

class Upcoming {
  Upcoming({
      this.teachingStaffID, 
      this.teachingStaffName, 
      this.courseName, 
      this.level, 
      this.attType, 
      this.day, 
      this.periodStart, 
      this.periodEnd, 
      this.groups, 
      this.room,});

  Upcoming.fromJson(dynamic json) {
    teachingStaffID = json['TeachingStaff_ID'];
    teachingStaffName = json['TeachingStaff_Name'];
    courseName = json['Course_Name'];
    level = json['Level'];
    attType = json['AttType'];
    day = json['Day'];
    periodStart = json['Period_Start'];
    periodEnd = json['PeriodEnd'];
    groups = json['Groups'] != null ? json['Groups'].cast<String>() : [];
    room = json['Room'];
  }
  num? teachingStaffID;
  String? teachingStaffName;
  String? courseName;
  num? level;
  String? attType;
  String? day;
  String? periodStart;
  String? periodEnd;
  List<String>? groups;
  num? room;
Upcoming copyWith({  num? teachingStaffID,
  String? teachingStaffName,
  String? courseName,
  num? level,
  String? attType,
  String? day,
  String? periodStart,
  String? periodEnd,
  List<String>? groups,
  num? room,
}) => Upcoming(  teachingStaffID: teachingStaffID ?? this.teachingStaffID,
  teachingStaffName: teachingStaffName ?? this.teachingStaffName,
  courseName: courseName ?? this.courseName,
  level: level ?? this.level,
  attType: attType ?? this.attType,
  day: day ?? this.day,
  periodStart: periodStart ?? this.periodStart,
  periodEnd: periodEnd ?? this.periodEnd,
  groups: groups ?? this.groups,
  room: room ?? this.room,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TeachingStaff_ID'] = teachingStaffID;
    map['TeachingStaff_Name'] = teachingStaffName;
    map['Course_Name'] = courseName;
    map['Level'] = level;
    map['AttType'] = attType;
    map['Day'] = day;
    map['Period_Start'] = periodStart;
    map['PeriodEnd'] = periodEnd;
    map['Groups'] = groups;
    map['Room'] = room;
    return map;
  }

}