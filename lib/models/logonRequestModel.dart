import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LoginRequestModel {
  final String emailOrPhone;
  final String password;
  final String selectedRoleId;

  LoginRequestModel({
    required this.emailOrPhone,
    required this.password,
    required this.selectedRoleId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "emailOrPhone": emailOrPhone.toString().trim(),
      "password": password.toString().trim(),
      "selectedRoleId": selectedRoleId.toString().trim(),
    };
    return map;
  }
}
