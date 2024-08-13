

class Lecturee {
  Lecturee({
      this.materialID, 
      this.courseID, 
      this.title, 
      this.attachment, 
      this.uploadDate, 
      this.profName, 
      this.attType, 
      this.courseName,});

  Lecturee.fromJson(dynamic json) {
    materialID = json['Material_ID'];
    courseID = json['Course_ID'];
    title = json['Title'];
    attachment = json['Attachment'];
    uploadDate = json['UploadDate'];
    profName = json['Prof. Name'];
    attType = json['AttType'];
    courseName = json['Course_Name'];
  }
  num? materialID;
  String? courseID;
  String? title;
  String? attachment;
  String? uploadDate;
  String? profName;
  String? attType;
  String? courseName;
Lecturee copyWith({  num? materialID,
  String? courseID,
  String? title,
  String? attachment,
  String? uploadDate,
  String? profName,
  String? attType,
  String? courseName,
}) => Lecturee(  materialID: materialID ?? this.materialID,
  courseID: courseID ?? this.courseID,
  title: title ?? this.title,
  attachment: attachment ?? this.attachment,
  uploadDate: uploadDate ?? this.uploadDate,
  profName: profName ?? this.profName,
  attType: attType ?? this.attType,
  courseName: courseName ?? this.courseName,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Material_ID'] = materialID;
    map['Course_ID'] = courseID;
    map['Title'] = title;
    map['Attachment'] = attachment;
    map['UploadDate'] = uploadDate;
    map['Prof. Name'] = profName;
    map['AttType'] = attType;
    map['Course_Name'] = courseName;
    return map;
  }

}