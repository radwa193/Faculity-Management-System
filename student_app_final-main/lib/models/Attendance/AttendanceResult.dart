/// Attend_ID : 132
/// Attendance_TimeStamp : "2024-05-09T17:30:33.502886+00:00"
/// Attended_Group : "1"
/// TeachingStaff_ID : 1013
/// Attended_course_ID : "CSM 224"
/// code : "mvrtzhqkne"

class AttendanceResult {
  AttendanceResult({
      this.attendID, 
      this.attendanceTimeStamp, 
      this.attendedGroup, 
      this.teachingStaffID, 
      this.attendedCourseID, 
      this.code,});

  AttendanceResult.fromJson(dynamic json) {
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
AttendanceResult copyWith({  num? attendID,
  String? attendanceTimeStamp,
  String? attendedGroup,
  num? teachingStaffID,
  String? attendedCourseID,
  String? code,
}) => AttendanceResult(  attendID: attendID ?? this.attendID,
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