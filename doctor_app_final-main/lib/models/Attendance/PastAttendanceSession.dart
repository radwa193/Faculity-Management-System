/// Attend_ID : 143
/// Attendance_TimeStamp : "2024-05-10T12:29:17+00:00"
/// Attended_Group : "1"
/// TeachingStaff_ID : 1013
/// Attended_course_ID : "AIM 322"
/// code : "gdfsgsdgsd"

class PastAttendanceSession {
  PastAttendanceSession({
      this.attendID, 
      this.attendanceTimeStamp, 
      this.attendedGroup, 
      this.teachingStaffID, 
      this.attendedCourseID, 
      this.code,});

  PastAttendanceSession.fromJson(dynamic json) {
    attendID = json['Attend_ID'];
    attendanceTimeStamp = json['Attendance_TimeStamp'];
    attendedGroup = json['Attended_Group'];
    teachingStaffID = json['TeachingStaff_ID'];
    attendedCourseID = json['Attended_course_ID'];
    code = json['code'];
  }
  num? attendID;
  String? attendanceTimeStamp;
  String? attendedGroup;
  num? teachingStaffID;
  String? attendedCourseID;
  String? code;
PastAttendanceSession copyWith({  num? attendID,
  String? attendanceTimeStamp,
  String? attendedGroup,
  num? teachingStaffID,
  String? attendedCourseID,
  String? code,
}) => PastAttendanceSession(  attendID: attendID ?? this.attendID,
  attendanceTimeStamp: attendanceTimeStamp ?? this.attendanceTimeStamp,
  attendedGroup: attendedGroup ?? this.attendedGroup,
  teachingStaffID: teachingStaffID ?? this.teachingStaffID,
  attendedCourseID: attendedCourseID ?? this.attendedCourseID,
  code: code ?? this.code,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Attend_ID'] = attendID;
    map['Attendance_TimeStamp'] = attendanceTimeStamp;
    map['Attended_Group'] = attendedGroup;
    map['TeachingStaff_ID'] = teachingStaffID;
    map['Attended_course_ID'] = attendedCourseID;
    map['code'] = code;
    return map;
  }

}