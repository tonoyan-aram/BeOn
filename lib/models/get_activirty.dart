// To parse this JSON data, do
//
//     final getActivity = getActivityFromJson(jsonString);

import 'dart:convert';

GetActivity getActivityFromJson(String str) => GetActivity.fromJson(json.decode(str));

String getActivityToJson(GetActivity data) => json.encode(data.toJson());

class GetActivity {
  GetActivity({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory GetActivity.fromJson(Map<String, dynamic> json) => GetActivity(
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
