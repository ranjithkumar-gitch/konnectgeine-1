import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LoginRequestModel {
  final String emailOrPhone;
  final String password;
  final String rememberMe;

  LoginRequestModel({
    required this.emailOrPhone,
    required this.password,
    required this.rememberMe,
  });

  Map<String, dynamic> toJson() => {
    "emailOrPhone": emailOrPhone.trim(),
    "password": password.trim(),
    "rememberMe": rememberMe.trim(),
  };
}
