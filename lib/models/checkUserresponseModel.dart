import 'dart:convert';

import 'package:KonnectGenie/models/roles.dart';

class CheckUserResponseModel {
  final bool success;
  final String loginType;
  final bool hasMultipleRoles;
  final List<Role> roles;
  final String maskedInfo;

  CheckUserResponseModel({
    required this.success,
    required this.loginType,
    required this.hasMultipleRoles,
    required this.roles,
    required this.maskedInfo,
  });

  factory CheckUserResponseModel.fromJson(Map<String, dynamic> json) {
    return CheckUserResponseModel(
      success: json["success"] ?? false,
      loginType: json["loginType"] ?? "",
      hasMultipleRoles: json["hasMultipleRoles"] ?? false,
      roles:
          (json["roles"] as List<dynamic>?)
              ?.map((x) => Role.fromJson(x))
              .toList() ??
          [],
      maskedInfo: json["maskedInfo"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "loginType": loginType,
    "hasMultipleRoles": hasMultipleRoles,
    "roles": roles.map((x) => x.toJson()).toList(),
    "maskedInfo": maskedInfo,
  };
}

CheckUserResponseModel checkUserResponseFromJson(String str) =>
    CheckUserResponseModel.fromJson(json.decode(str));

String checkUserResponseToJson(CheckUserResponseModel data) =>
    json.encode(data.toJson());
