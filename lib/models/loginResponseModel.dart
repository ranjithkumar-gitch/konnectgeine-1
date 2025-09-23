// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  bool success;
  String token;
  User user;

  LoginResponseModel({
    required this.success,
    required this.token,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        success: json["success"],
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "token": token,
    "user": user.toJson(),
  };
}

class User {
  String id;
  String name;
  String login;
  String email;
  String currentRole;
  String currentRoleId;
  String phone;
  String profileImage;
  bool isEmailVerified;

  User({
    required this.id,
    required this.name,
    required this.login,
    required this.email,
    required this.currentRole,
    required this.currentRoleId,
    required this.phone,
    required this.profileImage,
    required this.isEmailVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    login: json["login"],
    email: json["email"],
    currentRole: json["currentRole"],
    currentRoleId: json["currentRoleId"],
    phone: json["phone"],
    profileImage: json["profileImage"],
    isEmailVerified: json["isEmailVerified"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "login": login,
    "email": email,
    "currentRole": currentRole,
    "currentRoleId": currentRoleId,
    "phone": phone,
    "profileImage": profileImage,
    "isEmailVerified": isEmailVerified,
  };
}
