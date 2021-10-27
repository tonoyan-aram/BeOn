// To parse this JSON data, do
//
//     final taskDetailsResponse = taskDetailsResponseFromJson(jsonString);

import 'dart:convert';

TaskDetailsResponse taskDetailsResponseFromJson(String str) =>
    TaskDetailsResponse.fromJson(json.decode(str));

String taskDetailsResponseToJson(TaskDetailsResponse data) =>
    json.encode(data.toJson());

class TaskDetailsResponse {
  TaskDetailsResponse({
    this.id,
    this.managerName,
    this.managerId,
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
    this.newFileCount,
    this.newSubFileCount,
    this.newSmsCount,
    this.creatorName,
    this.childTasks,
    this.isVoice,
  });

  int id;
  String managerName;
  int managerId;
  String name;
  String company;
  dynamic taskTemplate;
  dynamic templateId;
  String companyId;
  dynamic client;
  String clientFirstName;
  String clientLastName;
  String clientImage;
  String companyName;
  String status;
  dynamic title;
  String text;
  bool isArchive;
  String accountant;
  String accountantFirstName;
  String accountantLastName;
  dynamic accountantImage;
  List<TaskFile> taskFile;
  List<TaskTimer> taskTimer;
  bool isRepeated;
  dynamic endDate;
  String creator;
  String manager;
  DateTime startTaskDate;
  dynamic endTaskDate;
  String url;
  List<dynamic> smsTask;
  int rate;
  List<Rating> ratings;
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
  bool isVoice;

  factory TaskDetailsResponse.fromJson(Map<String, dynamic> json) =>
      TaskDetailsResponse(
        id: json["id"],
        managerName: json["manager_name"],
        managerId: json["manager_id"],
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
        accountant: json["accountant"],
        accountantFirstName: json["accountant_first_name"],
        accountantLastName: json["accountant_last_name"],
        accountantImage: json["accountant_image"],
        taskFile: List<TaskFile>.from(
            json["task_file"].map((x) => TaskFile.fromJson(x))),
        taskTimer: List<TaskTimer>.from(
            json["task_timer"].map((x) => TaskTimer.fromJson(x))),
        isRepeated: json["is_repeated"],
        endDate: json["end_date"],
        creator: json["creator"],
        manager: json["manager"],
        startTaskDate: json["start_task_date"] == null
            ? null
            : DateTime.parse(json["start_task_date"]),
        endTaskDate: json["end_task_date"],
        url: json["url"],
        smsTask: List<dynamic>.from(json["sms_task"].map((x) => x)),
        rate: json["rate"],
        ratings:
            List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
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
        isVoice: json["is_voice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "manager_name": managerName,
        "manager_id": managerId,
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
        "accountant": accountant,
        "accountant_first_name": accountantFirstName,
        "accountant_last_name": accountantLastName,
        "accountant_image": accountantImage,
        "task_file": List<dynamic>.from(taskFile.map((x) => x)),
        "task_timer": List<dynamic>.from(taskTimer.map((x) => x.toJson())),
        "is_repeated": isRepeated,
        "end_date": endDate,
        "creator": creator,
        "manager": manager,
        "start_task_date": startTaskDate.toIso8601String(),
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
        "is_voice": isVoice,
      };
}

class Rating {
  Rating({
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
  String manager;
  String client;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json["id"],
        url: json["url"],
        score: json["score"],
        task: json["task"],
        manager: json["manager"] == null ? null : json["manager"],
        client: json["client"] == null ? null : json["client"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "score": score,
        "task": task,
        "manager": manager == null ? null : manager,
        "client": client == null ? null : client,
      };
}

class TaskFile {
  TaskFile({
    this.id,
    this.file,
    this.url,
    this.task,
    this.fileName,
    this.createdDate,
  });
  int id;
  String file;
  String url;
  String task;
  String fileName;
  DateTime createdDate;
  factory TaskFile.fromJson(Map<String, dynamic> json) => TaskFile(
        id: json["id"],
        file: json["file"],
        url: json["url"],
        task: json["task"],
        fileName: json["file_name"],
        createdDate: DateTime.parse(json["created_date"]),
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "file": file,
        "url": url,
        "task": task,
        "file_name": fileName,
        "created_date": createdDate.toIso8601String(),
      };
}

class TaskTimer {
  TaskTimer({
    this.id,
    this.url,
    this.task,
    this.start,
    this.end,
  });

  int id;
  String url;
  String task;
  DateTime start;
  DateTime end;

  factory TaskTimer.fromJson(Map<String, dynamic> json) => TaskTimer(
        id: json["id"],
        url: json["url"],
        task: json["task"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "task": task,
        "start": start.toIso8601String(),
        "end": end.toIso8601String(),
      };
}
