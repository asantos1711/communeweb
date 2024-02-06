// To parse this JSON data, do
//
//     final responseGet = responseGetFromJson(jsonString);

import 'dart:convert';

ResponseGet responseGetFromJson(String str) =>
    ResponseGet.fromJson(json.decode(str));

String responseGetToJson(ResponseGet data) => json.encode(data.toJson());

class ResponseGet {
  Data? data;
  String? status;
  String? userId;
  String? errorType;
  String? errorMessage;

  ResponseGet({
    this.data,
    this.status,
    this.userId,
    this.errorType,
    this.errorMessage,
  });

  factory ResponseGet.fromJson(Map<String, dynamic> json) => ResponseGet(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        status: json["status"],
        userId: json["user_id"],
        errorType: json["error_type"],
        errorMessage: json["error_message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status,
        "user_id": userId,
        "error_type": errorType,
        "error_message": errorMessage,
      };
}

class Data {
  int? id;
  String? userId;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  List<Verification>? verifications;
  String? phone;
  dynamic avatar;
  dynamic address;
  dynamic countryId;
  int? roleId;
  String? status;
  dynamic birthday;
  String? lastLogin;
  bool? isVerified;
  bool? isVerifiedComplete;
  int? twoFactorCountryCode;
  String? twoFactorPhone;
  dynamic twoFactorOptions;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.verifications,
    this.phone,
    this.avatar,
    this.address,
    this.countryId,
    this.roleId,
    this.status,
    this.birthday,
    this.lastLogin,
    this.isVerified,
    this.isVerifiedComplete,
    this.twoFactorCountryCode,
    this.twoFactorPhone,
    this.twoFactorOptions,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        email: json["email"],
        verifications: json["verifications"] == null
            ? []
            : List<Verification>.from(
                json["verifications"]!.map((x) => Verification.fromJson(x))),
        phone: json["phone"],
        avatar: json["avatar"],
        address: json["address"],
        countryId: json["country_id"],
        roleId: json["role_id"],
        status: json["status"],
        birthday: json["birthday"],
        lastLogin: json["last_login"],
        isVerified: json["is_verified"],
        isVerifiedComplete: json["is_verified_complete"],
        twoFactorCountryCode: json["two_factor_country_code"],
        twoFactorPhone: json["two_factor_phone"],
        twoFactorOptions: json["two_factor_options"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "email": email,
        "verifications": verifications == null
            ? []
            : List<dynamic>.from(verifications!.map((x) => x.toJson())),
        "phone": phone,
        "avatar": avatar,
        "address": address,
        "country_id": countryId,
        "role_id": roleId,
        "status": status,
        "birthday": birthday,
        "last_login": lastLogin,
        "is_verified": isVerified,
        "is_verified_complete": isVerifiedComplete,
        "two_factor_country_code": twoFactorCountryCode,
        "two_factor_phone": twoFactorPhone,
        "two_factor_options": twoFactorOptions,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Verification {
  int? id;
  String? name;
  int? workflowId;
  Status? status;

  Verification({
    this.id,
    this.name,
    this.workflowId,
    this.status,
  });

  factory Verification.fromJson(Map<String, dynamic> json) => Verification(
        id: json["id"],
        name: json["name"],
        workflowId: json["workflow_id"],
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "workflow_id": workflowId,
        "status": status?.toJson(),
      };
}

class Status {
  int? value;
  String? friendly;

  Status({
    this.value,
    this.friendly,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        value: json["value"],
        friendly: json["friendly"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "friendly": friendly,
      };
}
