import 'package:flutter/material.dart';

class User {
  final String email;
  final String password;
  final String uuid;
  User({required this.email, required this.password, required this.uuid});
  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //     email: json['email'],
  //     password: json['password'],
  //     uuid: json['uuid'],
  //   );
  // }
}
