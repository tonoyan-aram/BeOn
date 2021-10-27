// To parse this JSON data, do
//
//     final changePersonalResponse = changePersonalResponseFromJson(jsonString);

import 'dart:convert';

ChangePersonalResponse changePersonalResponseFromJson(String str) =>
    ChangePersonalResponse.fromJson(json.decode(str));

String changePersonalResponseToJson(ChangePersonalResponse data) =>
    json.encode(data.toJson());

class ChangePersonalResponse {
  ChangePersonalResponse({
    this.phone,
    this.user,
  });

  String phone;
  User user;

  factory ChangePersonalResponse.fromJson(Map<String, dynamic> json) =>
      ChangePersonalResponse(
        phone: json["phone"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "user": user.toJson(),
      };
}

class User {
  User({
    this.firstName,
    this.lastName,
  });

  String firstName;
  String lastName;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["first_name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
      };
}
