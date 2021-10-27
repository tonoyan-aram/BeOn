// To parse this JSON data, do
//
//     final getServiceType = getServiceTypeFromJson(jsonString);

import 'dart:convert';

GetServiceType getServiceTypeFromJson(String str) => GetServiceType.fromJson(json.decode(str));

String getServiceTypeToJson(GetServiceType data) => json.encode(data.toJson());

class GetServiceType {
  GetServiceType({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory GetServiceType.fromJson(Map<String, dynamic> json) => GetServiceType(
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
    this.url,
    this.name,
    this.id,
  });

  String url;
  String name;
  int id;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    url: json["url"],
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "name": name,
    "id": id,
  };
}
