import 'package:flutter/material.dart';

class UserModel {
  late String image;
  late String? name;
  late String? phone;

  UserModel({
    required this.image,
    @required this.name,
    @required this.phone,
  });
}

