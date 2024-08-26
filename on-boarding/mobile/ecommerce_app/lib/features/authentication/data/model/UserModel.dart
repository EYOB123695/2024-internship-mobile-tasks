import 'dart:convert';

import '../../domain/entities/UserEntity.dart';

class UserModel extends UserEntity {
  UserModel({
    // required String id,
    required String username,
    required String password,
    required String email,
  }) : super(username: username, password: password, email: email);
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        // id: json['id'],
        username: json['name'],
        password: json['password'] ?? '',
        email: json['email']);
  }
  Map<String, dynamic> toJson() {
    return {"username": username, "password": password, "email": email};
  }

  UserEntity toEntity() =>
      UserEntity(username: username, password: password, email: email);
}
