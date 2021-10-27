// To parse this JSON data, do
//
//     final taskResponse = taskResponseFromJson(jsonString);

import 'dart:convert';

TaskResponse taskResponseFromJson(String str) =>
    TaskResponse.fromJson(json.decode(str));

String taskResponseToJson(TaskResponse data) => json.encode(data.toJson());

class TaskResponse {
  TaskResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory TaskResponse.fromJson(Map<String, dynamic> json) => TaskResponse(
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
  });

  int id;
  String managerName;
  int managerId;
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
  String accountant;
  String accountantFirstName;
  String accountantLastName;
  dynamic accountantImage;
  List<TaskFile> taskFile;
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
  List<ChildTask> childTasks;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        managerName: json["manager_name"] == null ? null : json["manager_name"],
        managerId: json["manager_id"] == null ? null : json["manager_id"],
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
        parentTask: json["parent_task"] == null ? null : json["parent_task"],
        parentTaskDetails: json["parent_task_details"] == null
            ? null
            : Result.fromJson(json["parent_task_details"]),
        visibleForClient: json["visible_for_client"] == null
            ? null
            : json["visible_for_client"],
        newFileCount:
            json["new_file_count"] == null ? null : json["new_file_count"],
        newSubFileCount: json["new_sub_file_count"] == null
            ? null
            : json["new_sub_file_count"],
        newSmsCount:
            json["new_sms_count"] == null ? null : json["new_sms_count"],
        creatorName: json["creator_name"] == null ? null : json["creator_name"],
        childTasks: json["child_tasks"] == null
            ? null
            : List<ChildTask>.from(
                json["child_tasks"].map((x) => ChildTask.fromJson(x))),
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
        "accountant": accountant,
        "accountant_first_name": accountantFirstName,
        "accountant_last_name": accountantLastName,
        "accountant_image": accountantImage,
        "task_file": List<dynamic>.from(taskFile.map((x) => x.toJson())),
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
        "child_tasks": List<dynamic>.from(childTasks.map((x) => x.toJson())),
      };
}

class ChildTask {
  ChildTask({
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
    this.createdDate,
    this.checked,
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
  dynamic accountant;
  List<TaskFile> taskFile;
  List<dynamic> taskTimer;
  bool isRepeated;
  dynamic endDate;
  String creator;
  String manager;
  dynamic startTaskDate;
  dynamic endTaskDate;
  String url;
  List<dynamic> smsTask;
  DateTime createdDate;
  bool checked;

  factory ChildTask.fromJson(Map<String, dynamic> json) => ChildTask(
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
        taskFile: List<TaskFile>.from(
            json["task_file"].map((x) => TaskFile.fromJson(x))),
        taskTimer: List<dynamic>.from(json["task_timer"].map((x) => x)),
        isRepeated: json["is_repeated"],
        endDate: json["end_date"],
        creator: json["creator"],
        manager: json["manager"],
        startTaskDate: json["start_task_date"],
        endTaskDate: json["end_task_date"],
        url: json["url"],
        smsTask: List<dynamic>.from(json["sms_task"].map((x) => x)),
        createdDate: DateTime.parse(json["created_date"]),
        checked: json["checked"],
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
        "task_file": List<dynamic>.from(taskFile.map((x) => x.toJson())),
        "task_timer": List<dynamic>.from(taskTimer.map((x) => x)),
        "is_repeated": isRepeated,
        "end_date": endDate,
        "creator": creator,
        "manager": manager,
        "start_task_date": startTaskDate,
        "end_task_date": endTaskDate,
        "url": url,
        "sms_task": List<dynamic>.from(smsTask.map((x) => x)),
        "created_date": createdDate.toIso8601String(),
        "checked": checked,
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
