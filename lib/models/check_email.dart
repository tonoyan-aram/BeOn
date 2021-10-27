import 'dart:convert';

CheckEmail checkEmailFromJson(String str) => CheckEmail.fromJson(json.decode(str));

String checkEmailToJson(CheckEmail data) => json.encode(data.toJson());

class CheckEmail {
  CheckEmail({
    this.id,
    this.email,
    this.createdAt,
    this.message,
  });

  int id;
  String email;
  DateTime createdAt;
  String message;

  factory CheckEmail.fromJson(Map<String, dynamic> json) => CheckEmail(
    id: json["id"],
    email: json["email"],
    createdAt: DateTime.parse(json["created_at"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "created_at": createdAt.toIso8601String(),
    "message": message,
  };
}
