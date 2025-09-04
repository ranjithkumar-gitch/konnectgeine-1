import 'dart:convert';

import 'package:KonnectGenie/models/roles.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final List<Role> roles;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final rolesJson = (json['roles'] as List?) ?? [];
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      roles: rolesJson.map((r) => Role.fromJson(r)).toList(),
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'roles': roles.map((r) => r.toJson()).toList(),
  };
}

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
