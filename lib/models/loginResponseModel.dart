import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  final bool success;
  final String? token;
  final User? user;

  LoginResponse({required this.success, required this.token, this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json["success"] ?? false,
    token: json["token"] ?? "",
    user: json["user"] != null ? User.fromJson(json["user"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "token": token,
    "user": user?.toJson(),
  };
}

class User {
  final String id;
  final String name;
  final String login;
  final String email;
  final List<Role> roles;
  final String phone;
  final Address? address;
  final String profileImage;
  final bool isEmailVerified;

  User({
    required this.id,
    required this.name,
    required this.login,
    required this.email,
    required this.roles,
    required this.phone,
    this.address,
    required this.profileImage,
    required this.isEmailVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    login: json["login"] ?? "",
    email: json["email"] ?? "",
    roles:
        json["roles"] != null
            ? List<Role>.from(json["roles"].map((x) => Role.fromJson(x)))
            : [],
    phone: json["phone"] ?? "",
    address: json["address"] != null ? Address.fromJson(json["address"]) : null,
    profileImage: json["profileImage"] ?? "",
    isEmailVerified: json["isEmailVerified"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "login": login,
    "email": email,
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
    "phone": phone,
    "address": address?.toJson(),
    "profileImage": profileImage,
    "isEmailVerified": isEmailVerified,
  };
}

class Address {
  final String street;
  final String city;
  final String zipCode;

  Address({required this.street, required this.city, required this.zipCode});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street: json["street"] ?? "",
    city: json["city"] ?? "",
    zipCode: json["zipCode"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "street": street,
    "city": city,
    "zipCode": zipCode,
  };
}

class Role {
  final String id;
  final String name;

  Role({required this.id, required this.name});

  factory Role.fromJson(Map<String, dynamic> json) =>
      Role(id: json["_id"] ?? json["id"] ?? "", name: json["name"] ?? "");

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
