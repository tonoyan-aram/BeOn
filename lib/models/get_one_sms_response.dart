// To parse this JSON data, do
//
//     final getOneSmsResponse = getOneSmsResponseFromJson(jsonString);

import 'dart:convert';

GetOneSmsResponse getOneSmsResponseFromJson(String str) =>
    GetOneSmsResponse.fromJson(json.decode(str));

String getOneSmsResponseToJson(GetOneSmsResponse data) =>
    json.encode(data.toJson());

class GetOneSmsResponse {
  GetOneSmsResponse({
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
  dynamic file;
  dynamic manager;
  String fileName;
  dynamic accountant;
  Client client;
  String url;
  DateTime createdDate;
  bool forAll;

  factory GetOneSmsResponse.fromJson(Map<String, dynamic> json) =>
      GetOneSmsResponse(
        id: json["id"],
        text: json["text"],
        task: json["task"],
        file: json["file"],
        manager: json["manager"],
        fileName: json["file_name"],
        accountant: json["accountant"],
        client: Client.fromJson(json["client"]),
        url: json["url"],
        createdDate: DateTime.parse(json["created_date"]),
        forAll: json["for_all"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "task": task,
        "file": file,
        "manager": manager,
        "file_name": fileName,
        "accountant": accountant,
        "client": client.toJson(),
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
        image: json["image"],
        phone: json["phone"],
        user: User.fromJson(json["user"]),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
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

  String lastName;
  String firstName;

  factory User.fromJson(Map<String, dynamic> json) => User(
        lastName: json["last_name"],
        firstName: json["first_name"],
      );

  Map<String, dynamic> toJson() => {
        "last_name": lastName,
        "first_name": firstName,
      };
}
