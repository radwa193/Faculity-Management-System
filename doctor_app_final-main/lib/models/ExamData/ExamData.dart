/// TeachingStaff_ID : 1013
/// ID : 54
/// Title : "test"

class ExamData {
  ExamData({
      this.teachingStaffID, 
      this.id, 
      this.title,});

  ExamData.fromJson(dynamic json) {
    teachingStaffID = json['TeachingStaff_ID'];
    id = json['ID'];
    title = json['Title'];
  }
  num? teachingStaffID;
  num? id;
  String? title;
ExamData copyWith({  num? teachingStaffID,
  num? id,
  String? title,
}) => ExamData(  teachingStaffID: teachingStaffID ?? this.teachingStaffID,
  id: id ?? this.id,
  title: title ?? this.title,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TeachingStaff_ID'] = teachingStaffID;
    map['ID'] = id;
    map['Title'] = title;
    return map;
  }

}