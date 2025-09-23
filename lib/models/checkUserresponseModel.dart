// To parse this JSON data, do
//
//     final checkUserResponseModel = checkUserResponseModelFromJson(jsonString);

import 'dart:convert';

CheckUserResponseModel checkUserResponseModelFromJson(String str) =>
    CheckUserResponseModel.fromJson(json.decode(str));

String checkUserResponseModelToJson(CheckUserResponseModel data) =>
    json.encode(data.toJson());

class CheckUserResponseModel {
  bool success;
  String message;
  SelectedRole selectedRole;

  CheckUserResponseModel({
    required this.success,
    required this.message,
    required this.selectedRole,
  });

  factory CheckUserResponseModel.fromJson(Map<String, dynamic> json) =>
      CheckUserResponseModel(
        success: json["success"],
        message: json["message"],
        selectedRole: SelectedRole.fromJson(json["selectedRole"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "selectedRole": selectedRole.toJson(),
  };
}

class SelectedRole {
  String id;
  String name;
  String displayName;

  SelectedRole({
    required this.id,
    required this.name,
    required this.displayName,
  });

  factory SelectedRole.fromJson(Map<String, dynamic> json) => SelectedRole(
    id: json["id"],
    name: json["name"],
    displayName: json["displayName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "displayName": displayName,
  };
}
