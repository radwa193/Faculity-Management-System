class User {
  static const String collectionName= 'users';
  String? id;
  String? fullName;
  String? userName;
  String? email;

  User({
    this.id,
    this.fullName,
    this.userName,
    this.email
  });

  Map<String , dynamic> toJson(){
    return{
      'id' : id ,
      'fullName' : fullName ,
      'userName' : userName ,
      'email' : email ,
    };
  }

  User.fromJson(Map<String , dynamic>? json){
    id  = json?['id'];
    fullName  = json?['fullName'];
    userName  = json?['userName'];
    email  = json?['email'];
  }
}
