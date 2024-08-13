/// Courses_ID : "URM 122"
/// ID : 4
/// Full_Mark : 30
/// array_agg : [23011932,23012778,23013014,23013056,23013228,23013266,23013345,23013531,23013745,23014675,23015450,23016805,23017080,23017988,23018423,23018824]
/// Student_Name : ["محمد أمجد رجب شحاتة","محمد طارق عويس علي","عبد الوهاب عماد الرشيدي حسن","ساره محمود عبد الرحمن منصور","مهاب ناصر عبد القادر مهاب","فيلو عماد مكرم إسحاق","أيمن محمد سعد الداود","عمر إيهاب حمام الشيوي","نادين محمود عبد الهادي فرج","سما ابراهيم رضوان احمد","عبد الرحمن وليد عبد المحسن حسن","منة الله وليد محمد الموافي","محمود مأمون هول أبو المجد","خالد محمد عبدالوهاب السيد","مهاب محمد عبد العاطي الكتان","عبدالله ماهر حسين محمد"]

class AssignResult {
  AssignResult({
      this.coursesID, 
      this.id, 
      this.fullMark, 
      this.arrayAgg, 
      this.studentName,});

  AssignResult.fromJson(dynamic json) {
    coursesID = json['Courses_ID'];
    id = json['ID'];
    fullMark = json['Full_Mark'];
    arrayAgg = json['array_agg'] != null ? json['array_agg'].cast<num>() : [];
    studentName = json['Student_Name'] != null ? json['Student_Name'].cast<String>() : [];
  }
  String? coursesID;
  num? id;
  num? fullMark;
  List<num>? arrayAgg;
  List<String>? studentName;
AssignResult copyWith({  String? coursesID,
  num? id,
  num? fullMark,
  List<num>? arrayAgg,
  List<String>? studentName,
}) => AssignResult(  coursesID: coursesID ?? this.coursesID,
  id: id ?? this.id,
  fullMark: fullMark ?? this.fullMark,
  arrayAgg: arrayAgg ?? this.arrayAgg,
  studentName: studentName ?? this.studentName,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Courses_ID'] = coursesID;
    map['ID'] = id;
    map['Full_Mark'] = fullMark;
    map['array_agg'] = arrayAgg;
    map['Student_Name'] = studentName;
    return map;
  }

}