import 'dart:convert';

ChangePasswordResponseOld changePasswordResponseOldFromJson(String str) =>
    ChangePasswordResponseOld.fromJson(json.decode(str));

String changePasswordResponseOldToJson(ChangePasswordResponseOld data) =>
    json.encode(data.toJson());

class ChangePasswordResponseOld {
  ChangePasswordResponseOld({
    this.token,
  });

  String token;

  factory ChangePasswordResponseOld.fromJson(Map<String, dynamic> json) =>
      ChangePasswordResponseOld(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
