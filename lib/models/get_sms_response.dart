// To parse this JSON data, do
//
//     final getSmsResponse = getSmsResponseFromJson(jsonString);

import 'dart:convert';

// GetSmsResponse getSmsResponseFromJson(String str) =>
//     GetSmsResponse.fromJson(json.decode(str));

// String smsResponseToJson(GetSmsResponse data) => json.encode(data.toJson());

List<GetSmsResponse> getSmsResponseFromJson(String str) =>
    List<GetSmsResponse>.from(
        json.decode(str).map((x) => GetSmsResponse.fromJson(x)));

String getSmsResponseToJson(List<GetSmsResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetSmsResponse {
  GetSmsResponse({
    this.id,
    this.text,
    this.task,
    this.file,
    this.manager,
    this.fileName,
    this.accountant,
    this.client,
    this.url,
    this.createdDate,
    this.forAll,
  });

  int id;
  String text;
  String task;
  String file;
  Client manager;
  String fileName;
  dynamic accountant;
  Client client;
  String url;
  DateTime createdDate;
  bool forAll;

  factory GetSmsResponse.fromJson(Map<String, dynamic> json) => GetSmsResponse(
        id: json["id"],
        text: json["text"],
        task: json["task"],
        file: json["file"] == null ? null : json["file"],
        manager:
            json["manager"] == null ? null : Client.fromJson(json["manager"]),
        fileName: json["file_name"],
        accountant: json["accountant"],
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
        url: json["url"],
        createdDate: DateTime.parse(json["created_date"]),
        forAll: json["for_all"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "task": task,
        "file": file == null ? null : file,
        "manager": manager == null ? null : manager.toJson(),
        "file_name": fileName == null ? null : fileName,
        "accountant": accountant,
        "client": client == null ? null : client.toJson(),
        "url": url,
        "created_date": createdDate.toIso8601String(),
        "for_all": forAll,
      };
}

class Client {
  Client({
    this.id,
    this.image,
    this.phone,
    this.user,
    this.url,
  });

  int id;
  String image;
  String phone;
  User user;
  String url;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        image: json["image"] == null ? null : json["image"],
        phone: json["phone"],
        user: User.fromJson(json["user"]),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image == null ? null : image,
        "phone": phone,
        "user": user.toJson(),
        "url": url,
      };
}

class User {
  User({
    this.lastName,
    this.firstName,
  });

  LastName lastName;
  FirstName firstName;

  factory User.fromJson(Map<String, dynamic> json) => User(
        lastName: lastNameValues.map[json["last_name"]],
        firstName: firstNameValues.map[json["first_name"]],
      );

  Map<String, dynamic> toJson() => {
        "last_name": lastNameValues.reverse[lastName],
        "first_name": firstNameValues.reverse[firstName],
      };
}

enum FirstName { EMPTY, MANAGER }

final firstNameValues =
    EnumValues({"": FirstName.EMPTY, "Manager": FirstName.MANAGER});

enum LastName { EMPTY, MANAGERYAN }

final lastNameValues =
    EnumValues({"Հարոյան": LastName.EMPTY, "Manageryan": LastName.MANAGERYAN});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
