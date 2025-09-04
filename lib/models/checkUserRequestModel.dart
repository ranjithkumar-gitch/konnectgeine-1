import 'dart:convert';

CheckUserRequest checkUserRequestFromJson(String str) =>
    CheckUserRequest.fromJson(json.decode(str));

String checkUserRequestToJson(CheckUserRequest data) =>
    json.encode(data.toJson());

class CheckUserRequest {
  final String emailOrPhone;

  CheckUserRequest({required this.emailOrPhone});

  factory CheckUserRequest.fromJson(Map<String, dynamic> json) =>
      CheckUserRequest(emailOrPhone: json["emailOrPhone"] ?? '');

  Map<String, dynamic> toJson() => {"emailOrPhone": emailOrPhone};
}
