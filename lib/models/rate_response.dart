import 'dart:convert';

RateResponse rateResponseFromJson(String str) =>
    RateResponse.fromJson(json.decode(str));

String rateResponseToJson(RateResponse data) => json.encode(data.toJson());

class RateResponse {
  RateResponse({
    this.id,
    this.url,
    this.score,
    this.task,
    this.manager,
    this.client,
  });

  int id;
  String url;
  int score;
  String task;
  dynamic manager;
  String client;

  factory RateResponse.fromJson(Map<String, dynamic> json) => RateResponse(
        id: json["id"],
        url: json["url"],
        score: json["score"],
        task: json["task"],
        manager: json["manager"],
        client: json["client"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "score": score,
        "task": task,
        "manager": manager,
        "client": client,
      };
}
