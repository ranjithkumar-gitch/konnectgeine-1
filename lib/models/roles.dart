// lib/models/role.dart
class Role {
  final String id;
  final String name;

  Role({required this.id, required this.name});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(id: json['id'] ?? json['_id'] ?? '', name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
