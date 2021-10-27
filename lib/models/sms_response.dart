// To parse this JSON data, do
//
//     final smsResponse = smsResponseFromJson(jsonString);

import 'dart:convert';

SmsResponse smsResponseFromJson(String str) =>
    SmsResponse.fromJson(json.decode(str));

String smsResponseToJson(SmsResponse data) => json.encode(data.toJson());

class SmsResponse {
  SmsResponse({
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
  String client;
  String url;
  DateTime createdDate;
  bool forAll;

  factory SmsResponse.fromJson(Map<String, dynamic> json) => SmsResponse(
        id: json["id"],
        text: json["text"],
        task: json["task"],
        file: json["file"],
        manager: json["manager"],
        fileName: json["file_name"],
        accountant: json["accountant"],
        client: json["client"],
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
        "client": client,
        "url": url,
        "created_date": createdDate.toIso8601String(),
        "for_all": forAll,
      };
}
