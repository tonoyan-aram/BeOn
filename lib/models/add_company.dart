// To parse this JSON data, do
//
//     final addCompanyResponse = addCompanyResponseFromJson(jsonString);

import 'dart:convert';

AddCompanyResponse addCompanyResponseFromJson(String str) => AddCompanyResponse.fromJson(json.decode(str));

String addCompanyResponseToJson(AddCompanyResponse data) => json.encode(data.toJson());

class AddCompanyResponse {
  AddCompanyResponse({
    this.id,
    this.name,
    this.logo,
    this.client,
    this.service,
    this.subscribe,
    this.accountant,
    this.hvhh,
    this.address,
    this.createdDate,
    this.createdNumber,
    this.directorFullName,
    this.changeData,
    this.packages,
    this.isDeleted,
    this.isDeletedByManager,
    this.category,
    this.countEmployees,
    this.typeOfActivity,
    this.taxationSystem,
    this.url,
    this.companyFiles,
    this.agreementDate,
  });

  int id;
  String name;
  dynamic logo;
  String client;
  List<String> service;
  dynamic subscribe;
  List<dynamic> accountant;
  String hvhh;
  String address;
  DateTime createdDate;
  String createdNumber;
  String directorFullName;
  String changeData;
  String packages;
  bool isDeleted;
  bool isDeletedByManager;
  int category;
  int countEmployees;
  List<String> typeOfActivity;
  String taxationSystem;
  String url;
  List<dynamic> companyFiles;
  DateTime agreementDate;

  factory AddCompanyResponse.fromJson(Map<String, dynamic> json) => AddCompanyResponse(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
    client: json["client"],
    service: List<String>.from(json["service"].map((x) => x)),
    subscribe: json["subscribe"],
    accountant: List<dynamic>.from(json["accountant"].map((x) => x)),
    hvhh: json["HVHH"],
    address: json["address"],
    createdDate: DateTime.parse(json["created_date"]),
    createdNumber: json["created_number"],
    directorFullName: json["director_full_name"],
    changeData: json["change_data"],
    packages: json["packages"],
    isDeleted: json["is_deleted"],
    isDeletedByManager: json["is_deleted_by_manager"],
    category: json["category"],
    countEmployees: json["count_employees"],
    typeOfActivity: List<String>.from(json["type_of_activity"].map((x) => x)),
    taxationSystem: json["taxation_system"],
    url: json["url"],
    companyFiles: List<dynamic>.from(json["company_files"].map((x) => x)),
    agreementDate: DateTime.parse(json["agreement_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
    "client": client,
    "service": List<dynamic>.from(service.map((x) => x)),
    "subscribe": subscribe,
    "accountant": List<dynamic>.from(accountant.map((x) => x)),
    "HVHH": hvhh,
    "address": address,
    "created_date": createdDate.toIso8601String(),
    "created_number": createdNumber,
    "director_full_name": directorFullName,
    "change_data": changeData,
    "packages": packages,
    "is_deleted": isDeleted,
    "is_deleted_by_manager": isDeletedByManager,
    "category": category,
    "count_employees": countEmployees,
    "type_of_activity": List<dynamic>.from(typeOfActivity.map((x) => x)),
    "taxation_system": taxationSystem,
    "url": url,
    "company_files": List<dynamic>.from(companyFiles.map((x) => x)),
    "agreement_date": "${agreementDate.year.toString().padLeft(4, '0')}-${agreementDate.month.toString().padLeft(2, '0')}-${agreementDate.day.toString().padLeft(2, '0')}",
  };
}
