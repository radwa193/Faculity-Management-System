/// Attend_ID : 129
/// code : "vtlpwaqfay"
/// Student ID : [202201998,212104901]
/// Student Name : ["احمد اسماعيل  السعيد  ","عبد الله  محمد  عبد السمية "]
/// array_agg : ["2024-05-10T09:45:02+00:00","2024-05-10T10:10:59+00:00"]

class AttendSessionDetails {
  AttendSessionDetails({
      this.attendID, 
      this.code, 
      this.studentID, 
      this.studentName, 
      this.arrayAgg,});

  AttendSessionDetails.fromJson(dynamic json) {
    attendID = json['Attend_ID'];
    code = json['code'];
    studentID = json['Student ID'] != null ? json['Student ID'].cast<num>() : [];
    studentName = json['Student Name'] != null ? json['Student Name'].cast<String>() : [];
    arrayAgg = json['array_agg'] != null ? json['array_agg'].cast<String>() : [];
  }
  num? attendID;
  String? code;
  List<num>? studentID;
  List<String>? studentName;
  List<String>? arrayAgg;
AttendSessionDetails copyWith({  num? attendID,
  String? code,
  List<num>? studentID,
  List<String>? studentName,
  List<String>? arrayAgg,
}) => AttendSessionDetails(  attendID: attendID ?? this.attendID,
  code: code ?? this.code,
  studentID: studentID ?? this.studentID,
  studentName: studentName ?? this.studentName,
  arrayAgg: arrayAgg ?? this.arrayAgg,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Attend_ID'] = attendID;
    map['code'] = code;
    map['Student ID'] = studentID;
    map['Student Name'] = studentName;
    map['array_agg'] = arrayAgg;
    return map;
  }

}