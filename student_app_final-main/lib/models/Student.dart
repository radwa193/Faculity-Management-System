/// Person_ID : 125
/// NID : 45300000000000
/// First_Name : "احمد"
/// Middle_Name : "اسماعيل "
/// Last_Name : "السعيد "
/// Sur_Name : "0"
/// First_NameEN : "Ahmed"
/// Middle_NameEN : "Ismael "
/// Last_NameEN : "Alsaed "
/// Sur_NameEN : "0"
/// Nationality : "Egyptian"
/// Person_DOB : "2006-05-22"
/// Person_Gender : "Male"
/// Person_Address : "0"
/// Fire_ID : null
/// Student_ID : 202201998
/// Program : 2
/// Addmition_Date : "2000-02-06"
/// CGPA : 3.80000
/// Level : 2
/// Department_ID : 1000
/// Section_ID : 1
/// Parent_ID : 2
/// Photo : null

class Student {
  Student({
      this.personID, 
      this.nid, 
      this.firstName, 
      this.middleName, 
      this.lastName, 
      this.surName, 
      this.firstNameEN, 
      this.middleNameEN, 
      this.lastNameEN, 
      this.surNameEN, 
      this.nationality, 
      this.personDOB, 
      this.personGender, 
      this.personAddress, 
      this.fireID, 
      this.studentID, 
      this.program, 
      this.addmitionDate, 
      this.cgpa, 
      this.level, 
      this.departmentID, 
      this.sectionID, 
      this.parentID, 
      this.photo,});

  Student.fromJson(dynamic json) {
    personID = json['Person_ID'];
    nid = json['NID'];
    firstName = json['First_Name'];
    middleName = json['Middle_Name'];
    lastName = json['Last_Name'];
    surName = json['Sur_Name'];
    firstNameEN = json['First_NameEN'];
    middleNameEN = json['Middle_NameEN'];
    lastNameEN = json['Last_NameEN'];
    surNameEN = json['Sur_NameEN'];
    nationality = json['Nationality'];
    personDOB = json['Person_DOB'];
    personGender = json['Person_Gender'];
    personAddress = json['Person_Address'];
    fireID = json['Fire_ID'];
    studentID = json['Student_ID'];
    program = json['Program'];
    addmitionDate = json['Addmition_Date'];
    cgpa = json['CGPA'];
    level = json['Level'];
    departmentID = json['Department_ID'];
    sectionID = json['Section_ID'];
    parentID = json['Parent_ID'];
    photo = json['Photo'];
  }
  num? personID;
  num? nid;
  String? firstName;
  String? middleName;
  String? lastName;
  String? surName;
  String? firstNameEN;
  String? middleNameEN;
  String? lastNameEN;
  String? surNameEN;
  String? nationality;
  String? personDOB;
  String? personGender;
  String? personAddress;
  dynamic fireID;
  num? studentID;
  num? program;
  String? addmitionDate;
  num? cgpa;
  num? level;
  num? departmentID;
  num? sectionID;
  num? parentID;
  dynamic photo;
Student copyWith({  num? personID,
  num? nid,
  String? firstName,
  String? middleName,
  String? lastName,
  String? surName,
  String? firstNameEN,
  String? middleNameEN,
  String? lastNameEN,
  String? surNameEN,
  String? nationality,
  String? personDOB,
  String? personGender,
  String? personAddress,
  dynamic fireID,
  num? studentID,
  num? program,
  String? addmitionDate,
  num? cgpa,
  num? level,
  num? departmentID,
  num? sectionID,
  num? parentID,
  dynamic photo,
}) => Student(  personID: personID ?? this.personID,
  nid: nid ?? this.nid,
  firstName: firstName ?? this.firstName,
  middleName: middleName ?? this.middleName,
  lastName: lastName ?? this.lastName,
  surName: surName ?? this.surName,
  firstNameEN: firstNameEN ?? this.firstNameEN,
  middleNameEN: middleNameEN ?? this.middleNameEN,
  lastNameEN: lastNameEN ?? this.lastNameEN,
  surNameEN: surNameEN ?? this.surNameEN,
  nationality: nationality ?? this.nationality,
  personDOB: personDOB ?? this.personDOB,
  personGender: personGender ?? this.personGender,
  personAddress: personAddress ?? this.personAddress,
  fireID: fireID ?? this.fireID,
  studentID: studentID ?? this.studentID,
  program: program ?? this.program,
  addmitionDate: addmitionDate ?? this.addmitionDate,
  cgpa: cgpa ?? this.cgpa,
  level: level ?? this.level,
  departmentID: departmentID ?? this.departmentID,
  sectionID: sectionID ?? this.sectionID,
  parentID: parentID ?? this.parentID,
  photo: photo ?? this.photo,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Person_ID'] = personID;
    map['NID'] = nid;
    map['First_Name'] = firstName;
    map['Middle_Name'] = middleName;
    map['Last_Name'] = lastName;
    map['Sur_Name'] = surName;
    map['First_NameEN'] = firstNameEN;
    map['Middle_NameEN'] = middleNameEN;
    map['Last_NameEN'] = lastNameEN;
    map['Sur_NameEN'] = surNameEN;
    map['Nationality'] = nationality;
    map['Person_DOB'] = personDOB;
    map['Person_Gender'] = personGender;
    map['Person_Address'] = personAddress;
    map['Fire_ID'] = fireID;
    map['Student_ID'] = studentID;
    map['Program'] = program;
    map['Addmition_Date'] = addmitionDate;
    map['CGPA'] = cgpa;
    map['Level'] = level;
    map['Department_ID'] = departmentID;
    map['Section_ID'] = sectionID;
    map['Parent_ID'] = parentID;
    map['Photo'] = photo;
    return map;
  }

}