// To parse this JSON data, do
//
//     final responseCreate = responseCreateFromJson(jsonString);

import 'dart:convert';

ResponseCreate responseCreateFromJson(String str) =>
    ResponseCreate.fromJson(json.decode(str));

String responseCreateToJson(ResponseCreate data) => json.encode(data.toJson());

class ResponseCreate {
  String? status;
  int? id;
  String? userId;
  String? magicLink;
  String? errorType;
  String? errorMessage;
  Errors? errors;

  ResponseCreate({
    this.status,
    this.id,
    this.userId,
    this.magicLink,
    this.errorType,
    this.errorMessage,
    this.errors,
  });

  factory ResponseCreate.fromJson(Map<String, dynamic> json) => ResponseCreate(
        status: json["status"],
        id: json["id"],
        userId: json["user_id"],
        magicLink: json["magic_link"],
        errorType: json["error_type"],
        errorMessage: json["error_message"],
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "id": id,
        "user_id": userId,
        "magic_link": magicLink,
        "error_type": errorType,
        "error_message": errorMessage,
        "errors": errors?.toJson(),
      };
}

class Errors {
  List<String>? email;
  List<String>? username;

  Errors({
    this.email,
    this.username,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        email: json["email"] == null
            ? []
            : List<String>.from(json["email"]!.map((x) => x)),
        username: json["username"] == null
            ? []
            : List<String>.from(json["username"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
        "username":
            username == null ? [] : List<dynamic>.from(username!.map((x) => x)),
      };
}
