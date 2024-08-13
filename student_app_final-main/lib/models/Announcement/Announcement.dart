
class Announcement {
  Announcement({
      this.announcementID, 
      this.announcementTitle, 
      this.announcementContent, 
      this.announcementTimeStamp, 
      this.authorID, 
      this.targetID,});

  Announcement.fromJson(dynamic json) {
    announcementID = json['Announcement_ID'];
    announcementTitle = json['Announcement_Title'];
    announcementContent = json['Announcement_Content'];
    announcementTimeStamp = json['Announcement_TimeStamp'];
    authorID = json['Author_ID'];
    targetID = json['target_ID'] != null ? json['target_ID'].cast<String>() : [];
  }
  num? announcementID;
  String? announcementTitle;
  String? announcementContent;
  String? announcementTimeStamp;
  num? authorID;
  List<String>? targetID;
Announcement copyWith({  num? announcementID,
  String? announcementTitle,
  String? announcementContent,
  String? announcementTimeStamp,
  num? authorID,
  List<String>? targetID,
}) => Announcement(  announcementID: announcementID ?? this.announcementID,
  announcementTitle: announcementTitle ?? this.announcementTitle,
  announcementContent: announcementContent ?? this.announcementContent,
  announcementTimeStamp: announcementTimeStamp ?? this.announcementTimeStamp,
  authorID: authorID ?? this.authorID,
  targetID: targetID ?? this.targetID,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Announcement_ID'] = announcementID;
    map['Announcement_Title'] = announcementTitle;
    map['Announcement_Content'] = announcementContent;
    map['Announcement_TimeStamp'] = announcementTimeStamp;
    map['Author_ID'] = authorID;
    map['target_ID'] = targetID;
    return map;
  }

}