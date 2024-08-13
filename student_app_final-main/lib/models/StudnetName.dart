/// Student_ID : 202201998
/// Student_Name : "احمد اسماعيل  السعيد  "

class StudnetName {
  StudnetName({
      this.studentID, 
      this.studentName,});

  StudnetName.fromJson(dynamic json) {
    studentID = json['Student_ID'];
    studentName = json['Student_Name'];
  }
  num? studentID;
  String? studentName;
StudnetName copyWith({  num? studentID,
  String? studentName,
}) => StudnetName(  studentID: studentID ?? this.studentID,
  studentName: studentName ?? this.studentName,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Student_ID'] = studentID;
    map['Student_Name'] = studentName;
    return map;
  }

}