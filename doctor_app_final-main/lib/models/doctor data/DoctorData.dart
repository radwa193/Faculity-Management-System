/// TeachingStaff_ID : 1001
/// Teaching Staff Name : "هالة مصطفى"
/// Email : "0"
/// Type : "D"
/// Photo : "https://ixwswhjospjukhbjqjzl.supabase.co/storage/v1/object/public/Files/Photos/FEMALEProf.jpeg?t=2024-05-07T01%3A45%3A19.065Z"

class DoctorData {
  DoctorData({
      this.teachingStaffID, 
      this.teachingStaffName, 
      this.email, 
      this.type, 
      this.photo,});

  DoctorData.fromJson(dynamic json) {
    teachingStaffID = json['TeachingStaff_ID'];
    teachingStaffName = json['Teaching Staff Name'];
    email = json['Email'];
    type = json['Type'];
    photo = json['Photo'];
  }
  num? teachingStaffID;
  String? teachingStaffName;
  String? email;
  String? type;
  String? photo;
DoctorData copyWith({  num? teachingStaffID,
  String? teachingStaffName,
  String? email,
  String? type,
  String? photo,
}) => DoctorData(  teachingStaffID: teachingStaffID ?? this.teachingStaffID,
  teachingStaffName: teachingStaffName ?? this.teachingStaffName,
  email: email ?? this.email,
  type: type ?? this.type,
  photo: photo ?? this.photo,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TeachingStaff_ID'] = teachingStaffID;
    map['Teaching Staff Name'] = teachingStaffName;
    map['Email'] = email;
    map['Type'] = type;
    map['Photo'] = photo;
    return map;
  }

}