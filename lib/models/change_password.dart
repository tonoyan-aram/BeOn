import 'dart:convert';

ChangePasswordResponse changePasswordFromJson(String str) => ChangePasswordResponse.fromJson(json.decode(str));

String changePasswordToJson(ChangePasswordResponse data) => json.encode(data.toJson());

class ChangePasswordResponse {
  ChangePasswordResponse({
    this.message,
  });

  String message;

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) => ChangePasswordResponse(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
