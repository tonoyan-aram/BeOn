// To parse this JSON data, do
//
//     final getMe = getMeFromJson(jsonString);

import 'dart:convert';

GetMe getMeFromJson(String str) => GetMe.fromJson(json.decode(str));

String getMeToJson(GetMe data) => json.encode(data.toJson());

class GetMe {
  GetMe({
    this.url,
    this.id,
    this.user,
    this.clientCompany,
    this.clientTask,
    this.userId,
    this.address,
    this.phone,
    this.image,
    this.cover,
  });

  String url;
  int id;
  User user;
  List<ClientCompany> clientCompany;
  List<dynamic> clientTask;
  int userId;
  dynamic address;
  String phone;
  dynamic image;
  dynamic cover;

  factory GetMe.fromJson(Map<String, dynamic> json) => GetMe(
        url: json["url"],
        id: json["id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        clientCompany: List<ClientCompany>.from(
            json["client_company"].map((x) => ClientCompany.fromJson(x))),
        clientTask: List<dynamic>.from(json["client_task"].map((x) => x)),
        userId: json["user_id"],
        address: json["address"],
        phone: json["phone"],
        image: json["image"],
        cover: json["cover"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "id": id,
        "user": user.toJson(),
        "client_company":
            List<dynamic>.from(clientCompany.map((x) => x.toJson())),
        "client_task": List<dynamic>.from(clientTask.map((x) => x)),
        "user_id": userId,
        "address": address,
        "phone": phone,
        "image": image,
        "cover": cover,
      };
}

class ClientCompany {
  ClientCompany({
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

  factory ClientCompany.fromJson(Map<String, dynamic> json) => ClientCompany(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        client: json["client"],
        service: List<String>.from(json["service"].map((x) => x)),
        subscribe: json["subscribe"],
        accountant: List<dynamic>.from(json["accountant"].map((x) => x)),
        hvhh: json["HVHH"],
        address: json["address"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        createdNumber: json["created_number"],
        directorFullName: json["director_full_name"],
        changeData: json["change_data"] == null ? null : json["change_data"],
        packages: json["packages"],
        isDeleted: json["is_deleted"],
        isDeletedByManager: json["is_deleted_by_manager"],
        category: json["category"],
        countEmployees: json["count_employees"],
        typeOfActivity:
            List<String>.from(json["type_of_activity"].map((x) => x)),
        taxationSystem: json["taxation_system"],
        url: json["url"],
        companyFiles: List<dynamic>.from(json["company_files"].map((x) => x)),
        agreementDate: json["agreement_date"] == null
            ? null
            : DateTime.parse(json["agreement_date"]),
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
        "change_data": changeData == null ? null : changeData,
        "packages": packages,
        "is_deleted": isDeleted,
        "is_deleted_by_manager": isDeletedByManager,
        "category": category,
        "count_employees": countEmployees,
        "type_of_activity": List<dynamic>.from(typeOfActivity.map((x) => x)),
        "taxation_system": taxationSystem,
        "url": url,
        "company_files": List<dynamic>.from(companyFiles.map((x) => x)),
        "agreement_date":
            "${agreementDate.year.toString().padLeft(4, '0')}-${agreementDate.month.toString().padLeft(2, '0')}-${agreementDate.day.toString().padLeft(2, '0')}",
      };
}

class User {
  User({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isActive,
    this.url,
  });

  String firstName;
  String lastName;
  String email;
  String password;
  bool isActive;
  String url;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        password: json["password"],
        isActive: json["is_active"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "is_active": isActive,
        "url": url,
      };
}
