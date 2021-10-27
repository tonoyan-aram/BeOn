// To parse this JSON data, do
//
//     final addTaskResponse = addTaskResponseFromJson(jsonString);

import 'dart:convert';

AddTaskResponse addTaskResponseFromJson(String str) =>
    AddTaskResponse.fromJson(json.decode(str));

String addTaskResponseToJson(AddTaskResponse data) =>
    json.encode(data.toJson());

class AddTaskResponse {
  AddTaskResponse({
    this.id,
    this.name,
    this.company,
    this.taskTemplate,
    this.templateId,
    this.companyId,
    this.client,
    this.clientFirstName,
    this.clientLastName,
    this.clientImage,
    this.companyName,
    this.status,
    this.title,
    this.text,
    this.isArchive,
    this.accountant,
    this.accountantFirstName,
    this.accountantLastName,
    this.accountantImage,
    this.taskFile,
    this.taskTimer,
    this.isRepeated,
    this.endDate,
    this.creator,
    this.manager,
    this.startTaskDate,
    this.endTaskDate,
    this.url,
    this.smsTask,
    this.rate,
    this.ratings,
    this.createdDate,
    this.checked,
    this.parentTask,
    this.parentTaskDetails,
    this.visibleForClient,
    this.isVoice,
    this.newFileCount,
    this.newSubFileCount,
    this.newSmsCount,
    this.creatorName,
    this.childTasks,
  });

  int id;
  String name;
  String company;
  dynamic taskTemplate;
  dynamic templateId;
  String companyId;
  String client;
  String clientFirstName;
  String clientLastName;
  String clientImage;
  String companyName;
  String status;
  dynamic title;
  String text;
  bool isArchive;
  bool isVoice;
  String accountant;
  String accountantFirstName;
  String accountantLastName;
  dynamic accountantImage;
  List<dynamic> taskFile;
  List<dynamic> taskTimer;
  bool isRepeated;
  DateTime endDate;
  String creator;
  dynamic manager;
  dynamic startTaskDate;
  dynamic endTaskDate;
  String url;
  List<dynamic> smsTask;
  int rate;
  List<dynamic> ratings;
  DateTime createdDate;
  bool checked;
  dynamic parentTask;
  dynamic parentTaskDetails;
  bool visibleForClient;
  int newFileCount;
  int newSubFileCount;
  int newSmsCount;
  String creatorName;
  List<dynamic> childTasks;

  factory AddTaskResponse.fromJson(Map<String, dynamic> json) =>
      AddTaskResponse(
        id: json["id"],
        name: json["name"],
        company: json["company"],
        taskTemplate: json["task_template"],
        templateId: json["template_id"],
        companyId: json["company_id"],
        client: json["client"],
        clientFirstName: json["client_first_name"],
        clientLastName: json["client_last_name"],
        clientImage: json["client_image"],
        companyName: json["company_name"],
        status: json["status"],
        title: json["title"],
        text: json["text"],
        isArchive: json["is_archive"],
        isVoice: json["is_voice"],
        accountant: json["accountant"],
        accountantFirstName: json["accountant_first_name"],
        accountantLastName: json["accountant_last_name"],
        accountantImage: json["accountant_image"],
        taskFile: List<dynamic>.from(json["task_file"].map((x) => x)),
        taskTimer: List<dynamic>.from(json["task_timer"].map((x) => x)),
        isRepeated: json["is_repeated"],
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        creator: json["creator"],
        manager: json["manager"],
        startTaskDate: json["start_task_date"],
        endTaskDate: json["end_task_date"],
        url: json["url"],
        smsTask: List<dynamic>.from(json["sms_task"].map((x) => x)),
        rate: json["rate"],
        ratings: List<dynamic>.from(json["ratings"].map((x) => x)),
        createdDate: DateTime.parse(json["created_date"]),
        checked: json["checked"],
        parentTask: json["parent_task"],
        parentTaskDetails: json["parent_task_details"],
        visibleForClient: json["visible_for_client"],
        newFileCount: json["new_file_count"],
        newSubFileCount: json["new_sub_file_count"],
        newSmsCount: json["new_sms_count"],
        creatorName: json["creator_name"],
        childTasks: List<dynamic>.from(json["child_tasks"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "company": company,
        "task_template": taskTemplate,
        "template_id": templateId,
        "company_id": companyId,
        "client": client,
        "client_first_name": clientFirstName,
        "client_last_name": clientLastName,
        "client_image": clientImage,
        "company_name": companyName,
        "status": status,
        "title": title,
        "text": text,
        "is_archive": isArchive,
        "is_voice": isVoice,
        "accountant": accountant,
        "accountant_first_name": accountantFirstName,
        "accountant_last_name": accountantLastName,
        "accountant_image": accountantImage,
        "task_file": List<dynamic>.from(taskFile.map((x) => x)),
        "task_timer": List<dynamic>.from(taskTimer.map((x) => x)),
        "is_repeated": isRepeated,
        "end_date": endDate.toIso8601String(),
        "creator": creator,
        "manager": manager,
        "start_task_date": startTaskDate,
        "end_task_date": endTaskDate,
        "url": url,
        "sms_task": List<dynamic>.from(smsTask.map((x) => x)),
        "rate": rate,
        "ratings": List<dynamic>.from(ratings.map((x) => x)),
        "created_date": createdDate.toIso8601String(),
        "checked": checked,
        "parent_task": parentTask,
        "parent_task_details": parentTaskDetails,
        "visible_for_client": visibleForClient,
        "new_file_count": newFileCount,
        "new_sub_file_count": newSubFileCount,
        "new_sms_count": newSmsCount,
        "creator_name": creatorName,
        "child_tasks": List<dynamic>.from(childTasks.map((x) => x)),
      };
}
