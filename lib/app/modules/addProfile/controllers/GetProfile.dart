// To parse this JSON data, do
//
//     final getProfie = getProfieFromJson(jsonString);

import 'dart:convert';

// ignore_for_file: file_names, unused_import, depend_on_referenced_packages

import 'package:meta/meta.dart';

GetProfie getProfieFromJson(String str) => GetProfie.fromJson(json.decode(str));

String getProfieToJson(GetProfie data) => json.encode(data.toJson());

class GetProfie {
  GetProfie({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  Data data;

  factory GetProfie.fromJson(Map<String, dynamic> json) => GetProfie(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.userId,
    required this.email,
    required this.fullName,
    required this.countryCode,
    required this.dob,
    required this.gender,
    required this.city,
    required this.phone,
    required this.isVerifiedPhone,
    required this.uniqueId,
    required this.socialId,
    required this.profilePicture,
    required this.firstTime,
    required this.token,
  });

  int userId;
  String email;
  String fullName;
  String countryCode;
  String dob;
  String gender;
  String city;
  String phone;
  int isVerifiedPhone;
  String uniqueId;
  String socialId;
  String profilePicture;
  String firstTime;
  String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        email: json["email"],
        fullName: json["full_name"],
        countryCode: json["country_code"],
        dob: json["dob"],
        gender: json["gender"],
        city: json["city"],
        phone: json["phone"],
        isVerifiedPhone: json["is_verified_phone"],
        uniqueId: json["unique_id"],
        socialId: json["social_id"],
        profilePicture: json["profile_picture"],
        firstTime: json["first_time"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "email": email,
        "full_name": fullName,
        "country_code": countryCode,
        "dob": dob,
        "gender": gender,
        "city": city,
        "phone": phone,
        "is_verified_phone": isVerifiedPhone,
        "unique_id": uniqueId,
        "social_id": socialId,
        "profile_picture": profilePicture,
        "first_time": firstTime,
        "token": token,
      };
}
