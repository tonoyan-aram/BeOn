import 'dart:convert';

CheckEmailCode checkEmailCodeFromJson(String str) => CheckEmailCode.fromJson(json.decode(str));

String checkEmailCodeToJson(CheckEmailCode data) => json.encode(data.toJson());

class CheckEmailCode {
  CheckEmailCode({
    this.userId,
    this.message,
  });

  int userId;
  String message;

  factory CheckEmailCode.fromJson(Map<String, dynamic> json) => CheckEmailCode(
    userId: json["user_id"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "message": message,
  };
}