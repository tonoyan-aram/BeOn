import 'dart:convert';

Registration registrationFromJson(String str) => Registration.fromJson(json.decode(str));

String registrationToJson(Registration data) => json.encode(data.toJson());

class Registration {
  Registration({
    this.phone,
    this.user,
  });

  String phone;
  User user;

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
    phone: json["phone"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "user": user.toJson(),
  };
}

class User {
  User({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
  });

  String firstName;
  String lastName;
  String email;
  String password;

  factory User.fromJson(Map<String, dynamic> json) => User(
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "password": password,
  };
}