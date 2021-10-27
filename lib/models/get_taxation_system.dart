// To parse this JSON data, do
//
//     final getTaxationSystem = getTaxationSystemFromJson(jsonString);

import 'dart:convert';

GetTaxationSystem getTaxationSystemFromJson(String str) => GetTaxationSystem.fromJson(json.decode(str));

String getTaxationSystemToJson(GetTaxationSystem data) => json.encode(data.toJson());

class GetTaxationSystem {
  GetTaxationSystem({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory GetTaxationSystem.fromJson(Map<String, dynamic> json) => GetTaxationSystem(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.id,
    this.name,
    this.url,
  });

  int id;
  String name;
  String url;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "url": url,
  };
}
