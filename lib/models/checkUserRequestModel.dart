import 'dart:convert';

CheckUserRequest checkUserRequestFromJson(String str) =>
    CheckUserRequest.fromJson(json.decode(str));

String checkUserRequestToJson(CheckUserRequest data) =>
    json.encode(data.toJson());

class CheckUserRequest {
  final String roleId;

  CheckUserRequest({required this.roleId});

  factory CheckUserRequest.fromJson(Map<String, dynamic> json) =>
      CheckUserRequest(roleId: json["roleId"] ?? '');
  Map<String, dynamic> toJson() {
    final map = {"roleId": roleId};
    print("🔹 CheckUserRequest toJson: $map");
    return map;
  }
}
