import 'dart:async';
import 'dart:io';
import 'package:beon/models/add_company.dart';
import 'package:beon/models/add_task_response.dart';
import 'package:beon/models/change_pass.dart';
import 'package:beon/models/change_email_response';
import 'package:beon/models/change_personal_response.dart';
import 'package:beon/models/check_email.dart';
import 'package:beon/models/check_email_code.dart';
import 'package:beon/models/getMe.dart';
import 'package:beon/models/get_activirty.dart';
import 'package:beon/models/get_company_files.dart';
import 'package:beon/models/get_manager.dart';
import 'package:beon/models/get_one_sms_response.dart';
import 'package:beon/models/get_package_type.dart';
import 'package:beon/models/get_service_type.dart';
import 'package:beon/models/get_sms_response.dart';
import 'package:beon/models/get_tasks.dart';
import 'package:beon/models/get_taxation_system.dart';
import 'package:beon/models/login.dart';
import 'package:beon/models/rate_response.dart';
import 'package:beon/models/registration.dart';
import 'package:beon/models/sms_response.dart';
import 'package:beon/models/task_details_response.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'functions.dart';

class PageManager {
  static Stream<Registration> registration(String phone, String firstName,
      String lastName, String password, String email, BuildContext context) {
    return Stream.fromFuture(FunctionalPage.registration(
            phone, firstName, lastName, password, email, context))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<LoginResponse> login(
      String password, String email, BuildContext context, bool isCheck) {
    return Stream.fromFuture(
            FunctionalPage.login(password, email, context, isCheck))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<CheckEmail> checkEmail(String email, BuildContext context) {
    return Stream.fromFuture(FunctionalPage.checkEmail(email, context))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<CheckEmailCode> changePassword(String email, String code,
      String password, String confirmPassword, BuildContext context) {
    return Stream.fromFuture(FunctionalPage.changePassword(
            email, code, password, confirmPassword, context))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<ChangePasswordResponseOld> changePasswordOld(
      String email,
      String oldPassword,
      String newPassword,
      String confirmPassword,
      BuildContext context) {
    return Stream.fromFuture(FunctionalPage.changePasswordOld(
            email, oldPassword, newPassword, confirmPassword, context))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<ChangeEmailResponse> changeEmail(
      String email, String oldEmail, String password, BuildContext context) {
    return Stream.fromFuture(
            FunctionalPage.changeEmail(email, oldEmail, password, context))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<ChangePasswordResponseOld> changeEmailCode(String email,
      String oldEmail, String password, String code, BuildContext context) {
    return Stream.fromFuture(FunctionalPage.changeEmailCode(
            email, oldEmail, password, code, context))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<ChangePersonalResponse> changePersonalInfo(
      String firstName, String lastName, String phone, BuildContext context) {
    return Stream.fromFuture(FunctionalPage.changePersonalInfo(
            firstName, lastName, phone, context))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<CheckEmailCode> checkEmailCode(
      String email, String code, BuildContext context) {
    return Stream.fromFuture(
            FunctionalPage.checkEmailCode(email, code, context))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<AddCompanyResponse> addCompany(
      String companyName,
      String hvhh,
      String address,
      String regNumber,
      String empCount,
      String directorName,
      List activity,
      List service,
      String taxationUrl,
      String packageUrl,
      String category,
      String date,
      String other,
      String fileName,
      BuildContext context) {
    return Stream.fromFuture(FunctionalPage.addCompany(
            companyName,
            hvhh,
            address,
            regNumber,
            empCount,
            directorName,
            activity,
            service,
            taxationUrl,
            packageUrl,
            category,
            date,
            other,
            fileName,
            context))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<AddCompanyResponse> editCompany(
      int id,
      String companyName,
      String hvhh,
      String address,
      String regNumber,
      String empCount,
      String directorName,
      List<String> activity,
      List<String> service,
      String taxationUrl,
      String packageUrl,
      String category,
      String date,
      String other,
      String fileName,
      String logo,
      List<String> accauntant,
      BuildContext context) {
    return Stream.fromFuture(FunctionalPage.editCompany(
            id,
            companyName,
            hvhh,
            address,
            regNumber,
            empCount,
            directorName,
            activity,
            service,
            taxationUrl,
            packageUrl,
            category,
            date,
            other,
            fileName,
            logo,
            accauntant,
            context))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<String> addImage(String file, int id) {
    return Stream.fromFuture(FunctionalPage.addImage(file, id))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<String> addFile(String file, int id) {
    return Stream.fromFuture(FunctionalPage.addFile(file, id))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<String> addImageProfile(String file, BuildContext context) {
    return Stream.fromFuture(FunctionalPage.addImageProfile(file, context))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<GetMe> getMe() {
    return Stream.fromFuture(FunctionalPage.getMe()).doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<GetActivity> getActivity() {
    return Stream.fromFuture(FunctionalPage.getActivity()).doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<TaskResponse> getTasks(String companyId, String startDate,
      String endDate, String name, String status, bool visible, int offset) {
    return Stream.fromFuture(FunctionalPage.getTasks(
            companyId, startDate, endDate, name, status, visible, offset))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<TaskDetailsResponse> getTaskDetails(int taskId) {
    return Stream.fromFuture(FunctionalPage.getTaskDetails(taskId))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream deleteTaskFail(
      int fileId, BuildContext context, int filePageId, String filePageImage) {
    return Stream.fromFuture(FunctionalPage.deleteTaskFail(
            fileId, context, filePageId, filePageImage))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<RateResponse> rateTask(double rate, int taskId) {
    return Stream.fromFuture(FunctionalPage.rateTask(rate, taskId))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<AddTaskResponse> addTasks(
      String companyId,
      String endDate,
      String accountantId,
      String name,
      String text,
      bool isVoice,
      List files,
      List<File> file,
      BuildContext context) {
    return Stream.fromFuture(FunctionalPage.addTask(companyId, endDate,
            accountantId, name, text, isVoice, files, file, context))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<SmsResponse> sendSms(
      String text, String file, int taskId, File _file) {
    return Stream.fromFuture(FunctionalPage.sendSms(text, file, taskId, _file))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<GetOneSmsResponse> getOneSms(int smskId) {
    return Stream.fromFuture(FunctionalPage.getOneSms(smskId))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<List<GetSmsResponse>> getSms(int startIndex, int taskId) {
    return Stream.fromFuture(FunctionalPage.getSms(startIndex, taskId))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream seenSms(int taskId) {
    return Stream.fromFuture(FunctionalPage.seenSms(taskId)).doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream seenFile(int taskId) {
    return Stream.fromFuture(FunctionalPage.seenFile(taskId))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<GetCompanyFiles> getCompanyFiles(
      int companyId, String date, String name, int offset) {
    return Stream.fromFuture(
            FunctionalPage.getCompanyFiles(companyId, date, name, offset))
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<GetPackageType> getPackageType() {
    return Stream.fromFuture(FunctionalPage.getPackageType())
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<GetServiceType> getServiceType() {
    return Stream.fromFuture(FunctionalPage.getServiceType())
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<GetTaxationSystem> getTaxationSystem() {
    return Stream.fromFuture(FunctionalPage.getTaxationSystem())
        .doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }

  static Stream<ManagerResponse> getManager(int id) {
    return Stream.fromFuture(FunctionalPage.getManager(id)).doOnError((e, st) {
      debugPrint(e.toString());
      debugPrint(st.toString());
    });
  }
}
