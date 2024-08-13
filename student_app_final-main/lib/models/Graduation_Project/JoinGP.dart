/// Project_ID : 186
/// Students Count : 1
/// Secret_Key : " eb ot ara50c0d5b8e"

class JoinGp {
  JoinGp({
      this.projectID, 
      this.studentsCount, 
      this.secretKey,});

  JoinGp.fromJson(dynamic json) {
    projectID = json['Project_ID'];
    studentsCount = json['Students Count'];
    secretKey = json['Secret_Key'];
  }
  num? projectID;
  num? studentsCount;
  String? secretKey;
JoinGp copyWith({  num? projectID,
  num? studentsCount,
  String? secretKey,
}) => JoinGp(  projectID: projectID ?? this.projectID,
  studentsCount: studentsCount ?? this.studentsCount,
  secretKey: secretKey ?? this.secretKey,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Project_ID'] = projectID;
    map['Students Count'] = studentsCount;
    map['Secret_Key'] = secretKey;
    return map;
  }

}