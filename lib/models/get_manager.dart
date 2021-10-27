// To parse this JSON data, do
//
//     final managerResponse = managerResponseFromJson(jsonString);

import 'dart:convert';

ManagerResponse managerResponseFromJson(String str) =>
    ManagerResponse.fromJson(json.decode(str));

String managerResponseToJson(ManagerResponse data) =>
    json.encode(data.toJson());

class ManagerResponse {
  ManagerResponse({
    this.id,
    this.name,
    this.logo,
    this.client,
    this.subscribe,
    this.accountant,
    this.hvhh,
    this.service,
    this.address,
    this.createdDate,
    this.createdNumber,
    this.directorFullName,
    this.packages,
    this.isDeleted,
    this.isDeletedByManager,
    this.changeData,
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
  Client client;
  dynamic subscribe;
  List<Accountant> accountant;
  String hvhh;
  List<TaxationSystem> service;
  String address;
  DateTime createdDate;
  String createdNumber;
  String directorFullName;
  Packages packages;
  bool isDeleted;
  bool isDeletedByManager;
  String changeData;
  int category;
  int countEmployees;
  List<TaxationSystem> typeOfActivity;
  TaxationSystem taxationSystem;
  String url;
  List<dynamic> companyFiles;
  DateTime agreementDate;

  factory ManagerResponse.fromJson(Map<String, dynamic> json) =>
      ManagerResponse(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        client: Client.fromJson(json["client"]),
        subscribe: json["subscribe"],
        accountant: List<Accountant>.from(
            json["accountant"].map((x) => Accountant.fromJson(x))),
        hvhh: json["HVHH"],
        service: List<TaxationSystem>.from(
            json["service"].map((x) => TaxationSystem.fromJson(x))),
        address: json["address"],
        createdDate: DateTime.parse(json["created_date"]),
        createdNumber: json["created_number"],
        directorFullName: json["director_full_name"],
        packages: Packages.fromJson(json["packages"]),
        isDeleted: json["is_deleted"],
        isDeletedByManager: json["is_deleted_by_manager"],
        changeData: json["change_data"],
        category: json["category"],
        countEmployees: json["count_employees"],
        typeOfActivity: List<TaxationSystem>.from(
            json["type_of_activity"].map((x) => TaxationSystem.fromJson(x))),
        taxationSystem: TaxationSystem.fromJson(json["taxation_system"]),
        url: json["url"],
        companyFiles: List<dynamic>.from(json["company_files"].map((x) => x)),
        agreementDate: DateTime.parse(json["agreement_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "client": client.toJson(),
        "subscribe": subscribe,
        "accountant": List<dynamic>.from(accountant.map((x) => x.toJson())),
        "HVHH": hvhh,
        "service": List<dynamic>.from(service.map((x) => x.toJson())),
        "address": address,
        "created_date": createdDate.toIso8601String(),
        "created_number": createdNumber,
        "director_full_name": directorFullName,
        "packages": packages.toJson(),
        "is_deleted": isDeleted,
        "is_deleted_by_manager": isDeletedByManager,
        "change_data": changeData,
        "category": category,
        "count_employees": countEmployees,
        "type_of_activity":
            List<dynamic>.from(typeOfActivity.map((x) => x.toJson())),
        "taxation_system": taxationSystem.toJson(),
        "url": url,
        "company_files": List<dynamic>.from(companyFiles.map((x) => x)),
        "agreement_date":
            "${agreementDate.year.toString().padLeft(4, '0')}-${agreementDate.month.toString().padLeft(2, '0')}-${agreementDate.day.toString().padLeft(2, '0')}",
      };
}

class Accountant {
  Accountant({
    this.url,
    this.id,
    this.user,
    this.userId,
    this.image,
    this.phone,
    this.profession,
    this.accountantType,
    this.accountantTypeDetails,
  });

  String url;
  int id;
  User user;
  int userId;
  dynamic image;
  String phone;
  String profession;
  String accountantType;
  AccountantTypeDetails accountantTypeDetails;

  factory Accountant.fromJson(Map<String, dynamic> json) => Accountant(
        url: json["url"],
        id: json["id"],
        user: User.fromJson(json["user"]),
        userId: json["user_id"],
        image: json["image"],
        phone: json["phone"],
        profession: json["profession"],
        accountantType: json["accountant_type"],
        accountantTypeDetails:
            AccountantTypeDetails.fromJson(json["accountant_type_details"]),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "id": id,
        "user": user.toJson(),
        "user_id": userId,
        "image": image,
        "phone": phone,
        "profession": profession,
        "accountant_type": accountantType,
        "accountant_type_details": accountantTypeDetails.toJson(),
      };
}

class AccountantTypeDetails {
  AccountantTypeDetails({
    this.id,
    this.title,
    this.image,
  });

  int id;
  String title;
  String image;

  factory AccountantTypeDetails.fromJson(Map<String, dynamic> json) =>
      AccountantTypeDetails(
        id: json["id"],
        title: json["title"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
      };
}

class User {
  User({
    this.firstName,
    this.lastName,
    this.email,
    this.url,
    this.password,
    this.isActive,
  });

  String firstName;
  String lastName;
  String email;
  String url;
  String password;
  bool isActive;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        url: json["url"],
        password: json["password"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "url": url,
        "password": password,
        "is_active": isActive,
      };
}

class Client {
  Client({
    this.url,
    this.id,
    this.user,
    this.userId,
    this.address,
    this.phone,
    this.image,
    this.cover,
  });

  String url;
  int id;
  User user;
  int userId;
  dynamic address;
  String phone;
  dynamic image;
  dynamic cover;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        url: json["url"],
        id: json["id"],
        user: User.fromJson(json["user"]),
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
        "user_id": userId,
        "address": address,
        "phone": phone,
        "image": image,
        "cover": cover,
      };
}

class Packages {
  Packages({
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

  factory Packages.fromJson(Map<String, dynamic> json) => Packages(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        service:
            List<Service>.from(json["service"].map((x) => Service.fromJson(x))),
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

class TaxationSystem {
  TaxationSystem({
    this.url,
    this.name,
    this.id,
  });

  String url;
  String name;
  int id;

  factory TaxationSystem.fromJson(Map<String, dynamic> json) => TaxationSystem(
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
