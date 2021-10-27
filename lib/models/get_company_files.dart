import 'dart:convert';

GetCompanyFiles getCompanyFilesFromJson(String str) =>
    GetCompanyFiles.fromJson(json.decode(str));

String getCompanyFilesToJson(GetCompanyFiles data) =>
    json.encode(data.toJson());

class GetCompanyFiles {
  GetCompanyFiles({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory GetCompanyFiles.fromJson(Map<String, dynamic> json) =>
      GetCompanyFiles(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
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
    this.file,
    this.createdAt,
    this.updatedAt,
    this.company,
    this.companyFiles,
  });

  String url;
  String name;
  String file;
  DateTime createdAt;
  DateTime updatedAt;
  String company;
  CompanyFiles companyFiles;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        url: json["url"],
        name: json["name"],
        file: json["file"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        company: json["company"],
        companyFiles: CompanyFiles.fromJson(json["company_files"]),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "name": name,
        "file": file,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "company": company,
        "company_files": companyFiles.toJson(),
      };
}

class CompanyFiles {
  CompanyFiles({
    this.id,
    this.name,
    this.logo,
    this.client,
    this.subscribe,
    this.accountant,
    this.hvhh,
    this.address,
    this.createdDate,
    this.createdNumber,
    this.directorFullName,
    this.packages,
    this.isDeleted,
    this.isDeletedByManager,
    this.category,
    this.countEmployees,
    this.typeOfActivity,
    this.taxationSystem,
    this.url,
    this.agreementDate,
  });

  int id;
  String name;
  dynamic logo;
  String client;
  dynamic subscribe;
  List<String> accountant;
  String hvhh;
  String address;
  DateTime createdDate;
  String createdNumber;
  String directorFullName;
  String packages;
  bool isDeleted;
  bool isDeletedByManager;
  int category;
  int countEmployees;
  List<String> typeOfActivity;
  String taxationSystem;
  String url;
  DateTime agreementDate;

  factory CompanyFiles.fromJson(Map<String, dynamic> json) => CompanyFiles(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        client: json["client"],
        subscribe: json["subscribe"],
        accountant: List<String>.from(json["accountant"].map((x) => x)),
        hvhh: json["HVHH"],
        address: json["address"],
        createdDate: DateTime.parse(json["created_date"]),
        createdNumber: json["created_number"],
        directorFullName: json["director_full_name"],
        packages: json["packages"],
        isDeleted: json["is_deleted"],
        isDeletedByManager: json["is_deleted_by_manager"],
        category: json["category"],
        countEmployees: json["count_employees"],
        typeOfActivity:
            List<String>.from(json["type_of_activity"].map((x) => x)),
        taxationSystem: json["taxation_system"],
        url: json["url"],
        agreementDate: DateTime.parse(json["agreement_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "client": client,
        "subscribe": subscribe,
        "accountant": List<dynamic>.from(accountant.map((x) => x)),
        "HVHH": hvhh,
        "address": address,
        "created_date": createdDate.toIso8601String(),
        "created_number": createdNumber,
        "director_full_name": directorFullName,
        "packages": packages,
        "is_deleted": isDeleted,
        "is_deleted_by_manager": isDeletedByManager,
        "category": category,
        "count_employees": countEmployees,
        "type_of_activity": List<dynamic>.from(typeOfActivity.map((x) => x)),
        "taxation_system": taxationSystem,
        "url": url,
        "agreement_date":
            "${agreementDate.year.toString().padLeft(4, '0')}-${agreementDate.month.toString().padLeft(2, '0')}-${agreementDate.day.toString().padLeft(2, '0')}",
      };
}
