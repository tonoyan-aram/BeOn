// To parse this JSON data, do
//
//     final getPackageType = getPackageTypeFromJson(jsonString);

import 'dart:convert';

GetPackageType getPackageTypeFromJson(String str) => GetPackageType.fromJson(json.decode(str));

String getPackageTypeToJson(GetPackageType data) => json.encode(data.toJson());

class GetPackageType {
  GetPackageType({
    this.results,
    this.meta,
  });

  List<Result> results;
  List<Meta> meta;

  factory GetPackageType.fromJson(Map<String, dynamic> json) => GetPackageType(
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    meta: List<Meta>.from(json["meta"].map((x) => Meta.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "meta": List<dynamic>.from(meta.map((x) => x.toJson())),
  };
}

class Meta {
  Meta({
    this.url,
    this.title,
    this.description,
    this.type,
    this.fbLink,
  });

  String url;
  String title;
  String description;
  String type;
  String fbLink;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    url: json["url"],
    title: json["title"],
    description: json["description"],
    type: json["type"],
    fbLink: json["fb_link"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "title": title,
    "description": description,
    "type": type,
    "fb_link": fbLink,
  };
}

class Result {
  Result({
    this.id,
    this.name,
    this.price,
    this.service,
    this.url,
  });

  int id;
  String name;
  int price;
  List<Service> service;
  String url;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    service: List<Service>.from(json["service"].map((x) => Service.fromJson(x))),
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "service": List<dynamic>.from(service.map((x) => x.toJson())),
    "url": url,
  };
}

class Service {
  Service({
    this.id,
    this.title,
  });

  int id;
  String title;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
