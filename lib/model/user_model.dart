import 'package:flutter/cupertino.dart';

class UserModel with ChangeNotifier {
  final int? id;
  final String username;
  final String email;
  final String password;
  final String phone;
  final String birth;
  final String address;

  UserModel({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.phone,
    required this.birth,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        username: json['username'],
        email: json['email'],
        password: json['password'],
        phone: json['phone'],
        birth: json['birth'],
        address: json['address']);
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "phone": phone,
        "birth": birth,
        "address": address
      };
}
