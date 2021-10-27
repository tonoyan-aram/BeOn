import 'dart:convert';
import 'dart:io';
import 'dart:async';

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
import 'package:beon/screens/home.dart';
import 'package:beon/screens/login.dart';
import 'package:beon/screens/page_details.dart';
import 'package:beon/screens/password_recover.dart';
import 'package:beon/screens/verification_code.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

import 'user_secure_storage.dart';

class FunctionalPage {
  static String urlApi = "http://admin.beon.am";

  static Future<Registration> registration(
      String phone,
      String firstName,
      String lastName,
      String password,
      String email,
      BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };
    Map body = {
      "phone": phone,
      "user": {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "password": password
      },
    };

    http.Response response = await http
        .post(Uri.parse("${urlApi}/api/client/"),
            headers: headers, body: jsonEncode(body))
        .then((value) {
      return value;
    });

    final data = response.body;

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = response.body;
      registrationFromJson(responseString);
      _showAlertDialogRegOk(context);
    }
    if (response.statusCode == 400) {
      _showAlertDialogRegEmail(context, "Սխալ էլ. հասցե",
          "Տվյալ էլ. հասցեով օգտատեր արդեն գրանցված է");
    } else
      return null;
  }

  static Future<LoginResponse> login(
      String password, String email, BuildContext context, bool isCheck) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };
    Map body = {"password": password, "username": email};

    http.Response response = await http
        .post(Uri.parse("${urlApi}/api/login/client"),
            headers: headers, body: jsonEncode(body))
        .then((value) {
      return value;
    });

    if (response.statusCode == 201 || response.statusCode == 200) {
      final String responseString = response.body;
      await UserSecureStorage.deletetall();

      await UserSecureStorage.setToken(
          LoginResponse.fromJson(json.decode(responseString)).token);

      getMe();
      if (isCheck) {
        await UserSecureStorage.setRecover("ok");
      }

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
    if (response.statusCode == 401) {
      _showAlertDialogRegEmail(
          context, "Ուշադրություն", "Մուտքանունը կամ գաղտնաբառը սխալ են");
    } else
      return null;
  }

  static Future<CheckEmail> checkEmail(
      String email, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };
    Map body = {"email": email};

    http.Response response = await http
        .post(Uri.parse("${urlApi}/api/send-forget-password-code/"),
            headers: headers, body: jsonEncode(body))
        .then((value) {
      return value;
    });

    if (response.statusCode == 201 || response.statusCode == 200) {
      final String responseString = response.body;

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Verification(
                  from: "password",
                  email:
                      CheckEmail.fromJson(json.decode(responseString)).email)));
    }
    if (response.statusCode == 401) {
      _showAlertDialogRegEmail(
          context, "Ուշադրություն", "Տվյալ էլ․ հասցեն գրանցված չէ");
    } else
      return null;
  }

  static Future<AddCompanyResponse> addCompany(
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
      BuildContext context) async {
    String accessToken = await UserSecureStorage().getToken();
    String userUrl = await UserSecureStorage().getUrl();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken'
    };
    Map body = {
      "client": userUrl,
      "name": companyName,
      "HVHH": hvhh,
      "address": address,
      "created_number": regNumber,
      "count_employees": empCount,
      "director_full_name": directorName,
      "type_of_activity": activity,
      "service": service,
      "taxation_system": taxationUrl,
      "packages": packageUrl,
      "category": category,
      "agreement_date": date,
      "change_data": other
    };

    http.Response response = await http
        .post(Uri.parse("$urlApi/api/client-company/"),
            headers: headers, body: jsonEncode(body))
        .then((value) {
      return value;
    });

    if (response.statusCode == 201 || response.statusCode == 200) {
      final String responseString = response.body;
      _showAlertDialogAddCompany(context, "Շնորհակալություն",
          "Կազմակերպությունը հաջողությամբ ավելացվել է");
      if (fileName != null) {
        addImage(fileName,
            AddCompanyResponse.fromJson(json.decode(responseString)).id);
      }

      AddCompanyResponse h = addCompanyResponseFromJson(responseString);
      return h;
    }
    if (response.statusCode != 200 && response.statusCode != 201) {
      // chgrancvelu modal
      _showAlertDialogRegEmail(context, "Ուշադրություն",
          "Ինչ որ բան այն չէ,խնդրում ենք փորձել կրկին");
    } else
      return null;
  }

  static Future<String> addImage(String file, int id) async {
    String accessToken = await UserSecureStorage().getToken();
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };

    var request = http.MultipartRequest(
        'PUT', Uri.parse("${urlApi}/api/client-company/${id}/"));

    request.headers.addAll(headers);

    request.files.add(http.MultipartFile(
        'logo', File(file).readAsBytes().asStream(), File(file).lengthSync(),
        filename: file.split("/").last));
    var response = await request.send();

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    if (response.statusCode == 201 || response.statusCode == 200) {
      if (responseString != null) {
        String newRespons = responseString.replaceAll('"', "");
      }
      return responseString;
    } else
      return null;
  }

  static Future<AddCompanyResponse> editCompany(
      int id,
      String companyName,
      String hvhh,
      String address,
      String regNumber,
      String empCount,
      String directorName,
      List<String> activity, //
      List<String> service, //
      String taxationUrl,
      String packageUrl,
      String category,
      String date,
      String other,
      String fileName,
      String logo,
      List<String> accauntant,
      BuildContext context) async {
    final dioClient = dio.Dio();

    String accessToken = await UserSecureStorage().getToken();
    String userUrl = await UserSecureStorage().getUrl();

    dioClient.options.baseUrl = urlApi;
    dioClient.options.headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken'
    };

    var formData = dio.FormData.fromMap({
      if (fileName != null)
        'logo': await dio.MultipartFile(File(fileName).readAsBytes().asStream(),
            File(fileName).lengthSync(),
            filename: fileName.split("/").last),
      'name': companyName,
      'client': userUrl,
      'HVHH': hvhh,
      'address': address,
      'created_number': regNumber,
      'count_employees': empCount,
      'director_full_name': directorName,
      'taxation_system': taxationUrl,
      'packages': packageUrl,
      'category': category,
      'agreement_date': date,
      'change_data': other,
      'type_of_activity': activity,
      'service': service,
      'accountant': accauntant,
    });

    var dioRequest =
        await dioClient.put("/api/client-company/$id/", data: formData);

    if (dioRequest.statusCode == 201 || dioRequest.statusCode == 200) {
      final Map<String, dynamic> responseData = dioRequest.data;
      _showAlertDialogAddCompany(
          context, "Շնորհակալություն", "Տվյալներն հաջողությամբ փոփոխվել են");

      AddCompanyResponse h = AddCompanyResponse.fromJson(responseData);
      return h;
    }

    if (dioRequest.statusCode != 200 || dioRequest.statusCode != 201) {
      _showAlertDialogRegEmail(context, "Ուշադրություն",
          "Ինչ որ բան այն չէ,խնդրում ենք փորձել կրկին");
    } else
      return null;
  }

  static Future<CheckEmailCode> checkEmailCode(
      String email, String code, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };
    Map body = {"email": email, "code": code};

    http.Response response = await http
        .post(Uri.parse("${urlApi}/api/check-forget-password-code/"),
            headers: headers, body: jsonEncode(body))
        .then((value) {
      return value;
    });

    if (response.statusCode == 201 || response.statusCode == 200) {
      final String responseString = response.body;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChangePassword(email: email, code: code)));
    }
    if (response.statusCode == 401) {
      _showAlertDialogRegEmail(
          context, "Ուշադրություն", "Ուղարկված կոդը սխալ է");
    } else
      return null;
  }

  static Future<ChangeEmailResponse> changeEmail(String email, String oldEmail,
      String password, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };
    Map body = {"email": email, "old_email": oldEmail, "password": password};

    http.Response response = await http
        .post(Uri.parse("${urlApi}/api/send-email-verification-code/"),
            headers: headers, body: jsonEncode(body))
        .then((value) {
      return value;
    });

    if (response.statusCode == 201 || response.statusCode == 200) {
      final String responseString = response.body;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Verification(
                    oldEmail: oldEmail,
                    password: password,
                    from: "email",
                    newEmail: email,
                  )));
      // newEmail:
      //     ChangeEmailResponse.fromJson(json.decode(responseString))
      //         .email)));
    }
    if (response.statusCode == 400) {
      _showAlertDialogRegEmail(context, "Ուշադրություն", "Գաղտնաբառը սխալ է");
    } else
      return null;
  }

  static Future<CheckEmailCode> changePassword(String email, String code,
      String password, String confirmPassword, BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };
    Map body = {
      "code": code,
      "email": email,
      "password": password,
      "repeat_password": confirmPassword
    };

    http.Response response = await http
        .put(Uri.parse("${urlApi}/api/change-password/"),
            headers: headers, body: jsonEncode(body))
        .then((value) {
      return value;
    });

    if (response.statusCode == 201 || response.statusCode == 200) {
      //final String responseString = response.body;
      _showAlertDialogCode(
          context, "Շնորհակալություն", "Գաղտնաբառն հաջողությամբ փոփոխվել է");
    }
    if (response.statusCode == 401) {
      _showAlertDialogRegEmail(
          context, "Ուշադրություն", "Ուղարկված կոդը սխալ է");
    } else
      return null;
  }

  static Future<ChangePasswordResponseOld> changePasswordOld(
      String email,
      String oldPassword,
      String newPassword,
      String confirmPassword,
      BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };
    Map body = {
      "email": email,
      "old_password": oldPassword,
      "new_password": newPassword,
      "repeat_password": confirmPassword
    };

    http.Response response = await http
        .put(Uri.parse("${urlApi}/api/change-existing-password/"),
            headers: headers, body: jsonEncode(body))
        .then((value) {
      return value;
    });

    if (response.statusCode == 201 || response.statusCode == 200) {
      final String responseString = response.body;
      String accessToken = await UserSecureStorage().getToken();

      await UserSecureStorage.setToken(
          ChangePasswordResponseOld.fromJson(json.decode(responseString))
              .token);
      String accessToken1 = await UserSecureStorage().getToken();
      _showAlertDialogPassword(
          context, "Շնորհակալություն", "Գաղտնաբառն հաջողությամբ փոփոխվել է");
    }

    if (response.statusCode == 400) {
      _showAlertDialogRegEmail(
          context, "Ուշադրություն", "Հին գաղտնաբառը սխալ է");
    } else
      return null;
  }

  static Future<ChangePasswordResponseOld> changeEmailCode(
      String email,
      String oldEmail,
      String password,
      String code,
      BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };
    Map body = {
      "code": code,
      "email": email,
      "old_email": oldEmail,
      "password": password
    };

    http.Response response = await http
        .post(Uri.parse("${urlApi}/api/check-email-verification-code/"),
            headers: headers, body: jsonEncode(body))
        .then((value) {
      return value;
    });

    if (response.statusCode == 201 || response.statusCode == 200) {
      final String responseString = response.body;
      String accessToken = await UserSecureStorage().getToken();

      await UserSecureStorage.setToken(
          ChangePasswordResponseOld.fromJson(json.decode(responseString))
              .token);

      _showAlertDialogPassword(
          context, "Շնորհակալություն", "Էլ․ հասցեն հաջողությամբ փոփոխվել է");
    }

    if (response.statusCode == 401) {
      _showAlertDialogRegEmail(context, "Ուշադրություն", "Կոդ սխալ է");
    } else
      return null;
  }

  static Future<ChangePersonalResponse> changePersonalInfo(
      // int id,
      String firstName,
      String lastName,
      String phone,
      BuildContext context) async {
    String accessToken = await UserSecureStorage().getToken();
    String userUrl = await UserSecureStorage().getUrl();
    String userId = await UserSecureStorage().getId();
    List<String> parts = userUrl.split("/");
    String uid = parts.elementAt(parts.length - 2);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken'
    };
    Map body = {
      "user": {"first_name": firstName, "last_name": lastName},
      "phone": phone
    };

    http.Response response = await http
        .put(Uri.parse("$urlApi/api/client/$userId/"),
            headers: headers, body: jsonEncode(body))
        .then((value) {
      return value;
    });

    if (response.statusCode == 201 || response.statusCode == 200) {
      final String responseString = response.body;
      await UserSecureStorage.setName(
          ChangePersonalResponse.fromJson(json.decode(responseString))
                  .user
                  .firstName +
              " " +
              ChangePersonalResponse.fromJson(json.decode(responseString))
                  .user
                  .lastName);
      _showAlertDialogPassword(
          context, "Շնորհակալություն", "Ձեր տվյալներն հաջողությամբ փոփոխվել է");
    }

    if (response.statusCode != 200 && response.statusCode != 201) {
      _showAlertDialogRegEmail(context, "Ուշադրություն", "Ինչ որ բան այն չէ");
    } else
      return null;
  }

  static Future<GetActivity> getActivity() async {
    String accessToken = await UserSecureStorage().getToken();
    http.Response response = await http.get(
      Uri.parse("${urlApi}/api/type-of-activity/?offset=0&limit=50"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken'
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = utf8.decode(response.bodyBytes).toString();

      // String responseString = response.body;
      GetActivity h = getActivityFromJson(responseString);
      return h;
    } else
      return null;
  }

  static Future<GetMe> getMe() async {
    String accessToken = await UserSecureStorage().getToken();
    http.Response response = await http.get(
      Uri.parse("${urlApi}/api/client/me"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken'
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = utf8.decode(response.bodyBytes).toString();

      await UserSecureStorage.setUrl(
          GetMe.fromJson(json.decode(responseString)).url);
      await UserSecureStorage.setCreatorUrl(
          GetMe.fromJson(json.decode(responseString)).user.url);
      await UserSecureStorage.setFirstName(
          GetMe.fromJson(json.decode(responseString)).user.firstName);
      await UserSecureStorage.setLastName(
          GetMe.fromJson(json.decode(responseString)).user.lastName);
      await UserSecureStorage.setName(
          GetMe.fromJson(json.decode(responseString)).user.firstName +
              " " +
              GetMe.fromJson(json.decode(responseString)).user.lastName);
      await UserSecureStorage.setImage(
          GetMe.fromJson(json.decode(responseString)).image);
      await UserSecureStorage.setId(
          GetMe.fromJson(json.decode(responseString)).id.toString());

      GetMe h = getMeFromJson(responseString);
      return h;
    } else
      return null;
  }

  static Future<GetPackageType> getPackageType() async {
    String accessToken = await UserSecureStorage().getToken();
    http.Response response = await http.get(
      Uri.parse("${urlApi}/api/packages/?offset=0&limit=50"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken'
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = utf8.decode(response.bodyBytes).toString();

      // String responseString = response.body;
      GetPackageType h = getPackageTypeFromJson(responseString);
      return h;
    } else
      return null;
  }

  static Future<GetServiceType> getServiceType() async {
    String accessToken = await UserSecureStorage().getToken();
    http.Response response = await http.get(
      Uri.parse("${urlApi}/api/company-service/?offset=0&limit=50"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken'
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = utf8.decode(response.bodyBytes).toString();

      // String responseString = response.body;
      GetServiceType h = getServiceTypeFromJson(responseString);
      return h;
    } else
      return null;
  }

  static Future<GetTaxationSystem> getTaxationSystem() async {
    String accessToken = await UserSecureStorage().getToken();
    http.Response response = await http.get(
      Uri.parse("${urlApi}/api/taxation-system/?offset=0&limit=50"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken'
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = utf8.decode(response.bodyBytes).toString();

      // String responseString = response.body;
      GetTaxationSystem h = getTaxationSystemFromJson(responseString);
      return h;
    } else
      return null;
  }

  static Future<ManagerResponse> getManager(int id) async {
    String accessToken = await UserSecureStorage().getToken();
    http.Response response = await http.get(
      Uri.parse("${urlApi}/api/manager-company/$id/"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken'
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = utf8.decode(response.bodyBytes).toString();

      // String responseString = response.body;
      ManagerResponse h = managerResponseFromJson(responseString);
      return h;
    } else
      return null;
  }

  static Future<TaskResponse> getTasks(
      String companyId,
      String startDate,
      String endDate,
      String name,
      String status,
      bool visible,
      int offset) async {
    String accessToken = await UserSecureStorage().getToken();
    String post = "";

    if (status == "new" || status == "approved") {
      post =
          "$urlApi/api/client-task/?company=$companyId&order_by=desc%20created_date&created_date=$startDate&created_date_end=$endDate&name=$name&status=$status&visible_for_client=$visible&offset=$offset";
    }
    if (status == "process") {
      post =
          "$urlApi/api/client-task/?company=$companyId&order_by=desc%20start_task_date&start_date=$startDate&start_date_end=$endDate&name=$name&status=$status&visible_for_client=$visible&offset=$offset";
    }
    if (status == "end") {
      post =
          "$urlApi/api/client-task/?company=$companyId&order_by=desc%20end_task_date&end_date=$startDate&end_date_end=$endDate&name=$name&status=$status&visible_for_client=$visible&offset=$offset";
    }

    http.Response response = await http.get(
      Uri.parse(post),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken'
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = utf8.decode(response.bodyBytes).toString();

      TaskResponse h = taskResponseFromJson(responseString);
      return h;
    } else
      return null;
  }

  static Future<GetCompanyFiles> getCompanyFiles(
      int companyId, String date, String name, int offset) async {
    String accessToken = await UserSecureStorage().getToken();
    http.Response response = await http.get(
      Uri.parse(
          "$urlApi/api/company-file/?company=$companyId&created_at=$date&name=$name&offset=$offset"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken'
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = utf8.decode(response.bodyBytes).toString();

      // String responseString = response.body;
      GetCompanyFiles h = getCompanyFilesFromJson(responseString);
      return h;
    } else
      return null;
  }

  static Future<String> addImageProfile(
      String file, BuildContext context) async {
    String accessToken = await UserSecureStorage().getToken();
    String id = await UserSecureStorage().getId();
    String firstName = await UserSecureStorage().getUserFirstName();
    String lastName = await UserSecureStorage().getUserLastName();
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };

    var request =
        http.MultipartRequest('PUT', Uri.parse("$urlApi/api/client/$id/"));

    request.headers.addAll(headers);

    request.fields['user.first_name'] = firstName;
    request.fields['user.last_name'] = lastName;

    request.files.add(http.MultipartFile(
        'image', File(file).readAsBytes().asStream(), File(file).lengthSync(),
        filename: file.split("/").last));
    var response = await request.send();

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    if (response.statusCode == 201 || response.statusCode == 200) {
      _showAlertDialogAddCompany(
          context, "Շնորհակալություն", "Ձեր նկարն հաջողությամբ փոփոխվել է");
      // if (responseString != null) {
      //   String newRespons = responseString.replaceAll('"', "");
      // }
      return responseString;
    } else
      return null;
  }

  static Future<TaskDetailsResponse> getTaskDetails(
    int taskId,
  ) async {
    String accessToken = await UserSecureStorage().getToken();
    http.Response response = await http.get(
      Uri.parse("$urlApi/api/client-task/$taskId/"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken'
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = utf8.decode(response.bodyBytes).toString();

      TaskDetailsResponse h = taskDetailsResponseFromJson(responseString);
      return h;
    } else
      return null;
  }

  static Future deleteTaskFail(int fileId, BuildContext context, int filePageId,
      String filePageImage) async {
    String accessToken = await UserSecureStorage().getToken();
    http.Response response = await http.delete(
      Uri.parse("$urlApi/api/client-task-file/$fileId/"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken'
      },
    );
    if (response.statusCode == 201 ||
        response.statusCode == 200 ||
        response.statusCode == 204) {
      String responseString = utf8.decode(response.bodyBytes).toString();
      _showAlertDialogDeleteFile(context, "Ուշադրություն",
          "Ֆայլն հաջողությամբ ջնջված է", filePageId, filePageImage);
    }
    if (response.statusCode == 404) {
      _showAlertDialogRegEmail(context, "Ուշադրություն", "Ինչ որ բան այն չէ");
    } else
      return null;
  }

  static Future<RateResponse> rateTask(double rate, int taskId) async {
    String accessToken = await UserSecureStorage().getToken();
    String userUrl = await UserSecureStorage().getUrl();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken'
    };
    Map body = {
      "client": userUrl,
      "score": rate,
      "task": "$urlApi/api/client-task/$taskId/",
    };

    http.Response response = await http
        .post(Uri.parse("${urlApi}/api/client-rate/"),
            headers: headers, body: jsonEncode(body))
        .then((value) {
      return value;
    });

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = utf8.decode(response.bodyBytes).toString();

      RateResponse h = rateResponseFromJson(responseString);

      return h;
    } else
      return null;
  }

  static Future<AddTaskResponse> addTask(
      String companyId,
      String endDate,
      String accountantId,
      String name,
      String text,
      bool isVoice,
      List files,
      List<File> file,
      BuildContext context) async {
    String accessToken = await UserSecureStorage().getToken();
    String userUrl = await UserSecureStorage().getUrl();
    String creatorUrl = await UserSecureStorage().getCreaotrUrl();

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken'
    };

    var request =
        http.MultipartRequest('POST', Uri.parse("$urlApi/api/client-task/"));

    request.headers.addAll(headers);
    request.fields['client'] = userUrl;
    request.fields['status'] = "new";
    request.fields['company'] = "$urlApi/api/manager-company/$companyId/";
    request.fields['visible_for_client'] = true.toString();
    request.fields['end_date'] = endDate;
    request.fields['accountant'] = accountantId;
    request.fields['name'] = name;
    request.fields['text'] = text;
    request.fields['creator'] = creatorUrl;
    request.fields['template_id'] = "0";
    request.fields['is_voice'] = isVoice.toString();

    //List<http.MultipartFile> newList = [];

    for (int i = 0; i < files.length; i++) {
      var fileName = files[i].split("/").last;
      file[i].readAsBytes().then((value) {}).catchError((onError) {});
      var stream = file[i].readAsBytes().asStream();

      var length = await file[i].length();

      var multipartFile = new http.MultipartFile("file${i + 1}", stream, length,
          filename: fileName);
      request.files.add(multipartFile);
    }

    var response = await request.send();

    var responseData = await response.stream.toBytes();

    var responseString = String.fromCharCodes(responseData);

    //final data = response.body;

    if (response.statusCode == 201 || response.statusCode == 200) {
      AddTaskResponse h = addTaskResponseFromJson(responseString);
      _showAlertDialogAddCompany(
          context, "Շնորհակալություն", "Առաջադրանքը հաջողությամբ ստեղծվել է");
      return h;
    }
    if (response.statusCode != 201 || response.statusCode != 200) {
      _showAlertDialogRegEmail(context, "Ուշադրություն", "Ինչ որ բան այն չէ");
    } else
      return null;
  }

  static Future<String> addFile(String file, int id) async {
    String accessToken = await UserSecureStorage().getToken();
    String userUrl = await UserSecureStorage().getUrl();
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse("$urlApi/api/client-task-file/"));

    request.headers.addAll(headers);
    request.fields['task'] = "$urlApi/api/client-task/$id/";

    request.files.add(http.MultipartFile(
        'file', File(file).readAsBytes().asStream(), File(file).lengthSync(),
        filename: file.split("/").last));

    var response = await request.send();

    var responseData = await response.stream.toBytes();

    var responseString = String.fromCharCodes(responseData);

    if (response.statusCode == 201 || response.statusCode == 200) {
      if (responseString != null) {
        String newRespons = responseString.replaceAll('"', "");
      }
      return responseString;
    } else
      return null;
  }

  static Future<SmsResponse> sendSms(
      String text, String file, int taskId, File _file) async {
    String accessToken = await UserSecureStorage().getToken();
    String userUrl = await UserSecureStorage().getUrl();

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken',
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse("$urlApi/api/client-task-sms/"));

    request.headers.addAll(headers);
    request.fields['task'] = "$urlApi/api/client-task/${taskId.toString()}/";
    request.fields['client'] = "$userUrl";
    request.fields['text'] = "$text";
    request.fields['for_all'] = "true";
    if (file != null) {
      var stream = _file.readAsBytes().asStream();
      var fileName = file.split("/").last;

      var length = await _file.length();
      request.files
          .add(http.MultipartFile('file', stream, length, filename: fileName));
    }

    var response = await request.send();

    var responseData = await response.stream.toBytes();

    var responseString = String.fromCharCodes(responseData);

    if (response.statusCode == 201 || response.statusCode == 200) {
      SmsResponse h = smsResponseFromJson(responseString);

      return h;
    } else
      return null;
  }

  static Future<List<GetSmsResponse>> getSms(int startIndex, int taskId) async {
    String accessToken = await UserSecureStorage().getToken();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken'
    };
    Map body = {
      "for_all": true,
      "start_index": startIndex,
    };

    http.Response response = await http
        .post(Uri.parse("$urlApi/api/get-task-smses/$taskId/"),
            headers: headers, body: jsonEncode(body))
        .then((value) {
      return value;
    });

    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = utf8.decode(response.bodyBytes).toString();

      List<GetSmsResponse> h = getSmsResponseFromJson(responseString);

      return h;
    } else
      return null;
  }

  static Future seenSms(int taskId) async {
    String accessToken = await UserSecureStorage().getToken();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken'
    };
    Map body = {};

    http.Response response = await http
        .post(Uri.parse("$urlApi/api/set-task-smses-seen/$taskId/"),
            headers: headers, body: jsonEncode(body))
        .then((value) {
      return value;
    });

    if (response.statusCode == 201 || response.statusCode == 200) {
    } else
      return null;
  }

  static Future seenFile(int taskId) async {
    String accessToken = await UserSecureStorage().getToken();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $accessToken'
    };
    Map body = {};

    http.Response response = await http
        .post(Uri.parse("$urlApi/api/set-task-files-seen/$taskId/"),
            headers: headers, body: jsonEncode(body))
        .then((value) {
      return value;
    });

    if (response.statusCode == 201 || response.statusCode == 200) {
    } else
      return null;
  }

  static Future<GetOneSmsResponse> getOneSms(int smskId) async {
    String accessToken = await UserSecureStorage().getToken();
    http.Response response = await http.get(
      Uri.parse("${urlApi}/api/get-task-sms/$smskId/"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $accessToken'
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      String responseString = utf8.decode(response.bodyBytes).toString();

      GetOneSmsResponse h = getOneSmsResponseFromJson(responseString);
      return h;
    } else
      return null;
  }
}

void _showAlertDialogRegEmail(
    BuildContext context, String title, String description) {
  final alert = AlertDialog(
    title: Text(title),
    content: Text(description),
    actions: [
      TextButton(
          child: Text("Լավ"), onPressed: () => Navigator.pop(context, 'OK'))
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void _showAlertDialogRegOk(BuildContext context) {
  final alert = AlertDialog(
    title: Text("Շնորհակալություն"),
    content: Text("Ձեր գրանցումն հաջողությամբ կատարվել է"),
    actions: [
      TextButton(
        child: Text("Լավ"),
        onPressed: () => Navigator.pop(context, 'OK'),
      )
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  ).then(
    (value) => Navigator.pop(context, 'OK'),
  );
}

void _showAlertDialogDeleteFile(BuildContext context, String title,
    String description, int id, String image) {
  final alert = AlertDialog(
    title: Text(title),
    content: Text(description),
    actions: [
      TextButton(
        child: Text("Լավ"),
        onPressed: () => Navigator.pop(context, 'OK'),
      )
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  ).then(
    (value) => Navigator.pop(context, [id.toString(), image]),
  );
}

void _showAlertDialogCode(
  BuildContext context,
  String title,
  String description,
) {
  final alert = AlertDialog(
    title: Text(title),
    content: Text(description),
    actions: [
      TextButton(
          child: Text("Լավ"),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login())))
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void _showAlertDialogPassword(
  BuildContext context,
  String title,
  String description,
) {
  final alert = AlertDialog(
    title: Text(title),
    content: Text(description),
    actions: [
      TextButton(
          child: Text("Լավ"),
          onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PageDetails()))
              })
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void _showAlertDialogAddCompany(
  BuildContext context,
  String title,
  String description,
) {
  final alert = AlertDialog(
    title: Text(title),
    content: Text(description),
    actions: [
      TextButton(
        child: Text("Լավ"),
        onPressed: () => Navigator.pop(context, title),
      )
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  ).then((value) => Navigator.pop(context, title));
}
