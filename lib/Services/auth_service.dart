import 'dart:convert';
import 'package:KonnectGenie/models/checkUserRequestModel.dart';
import 'package:KonnectGenie/models/checkUserresponseModel.dart';

import 'package:KonnectGenie/models/logonRequestModel.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "http://43.204.150.249:4000/api/auth";

  Future<CheckUserResponseModel> checkUser(CheckUserRequest request) async {
    final response = await http.post(
      Uri.parse("$baseUrl/check_user"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(request.toJson()),
    );

    return CheckUserResponseModel.fromJson(jsonDecode(response.body));
  }

  Future<Map<String, dynamic>> login(LoginRequestModel request) async {
    print("🚀 Login Request: ${request.toJson()}");
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(request.toJson()),
    );
    print("📥 Login Response: ${response.body}");
    return jsonDecode(response.body);
  }
}
