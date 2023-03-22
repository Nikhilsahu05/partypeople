// To parse this JSON data, do
//
//     final getindividualData = getindividualDataFromJson(jsonString);

import 'dart:convert';

// ignore_for_file: file_names, unused_import, depend_on_referenced_packages

import 'package:meta/meta.dart';

GetindividualData getindividualDataFromJson(String str) =>
    GetindividualData.fromJson(json.decode(str));

String getindividualDataToJson(GetindividualData data) =>
    json.encode(data.toJson());

class GetindividualData {
  GetindividualData({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<Datum2> data;

  factory GetindividualData.fromJson(Map<String, dynamic> json) =>
      GetindividualData(
        status: json["status"],
        message: json["message"],
        data: List<Datum2>.from(json["data"].map((x) => Datum2.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum2 {
  Datum2({
    required this.id,
    required this.userId,
    required this.organizationId,
    required this.title,
    required this.description,
    required this.coverPhoto,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.latitude,
    required this.longitude,
    required this.type,
    required this.gender,
    required this.startAge,
    required this.endAge,
    required this.personLimit,
    required this.status,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String userId;
  String organizationId;
  String title;
  String description;
  String coverPhoto;
  String startDate;
  String endDate;
  String startTime;
  String endTime;
  String latitude;
  String longitude;
  String type;
  String gender;
  String startAge;
  String endAge;
  String personLimit;
  String status;
  String active;
  DateTime createdAt;
  String updatedAt;

  factory Datum2.fromJson(Map<String, dynamic> json) => Datum2(
        id: json["id"],
        userId: json["user_id"],
        organizationId: json["organization_id"],
        title: json["title"],
        description: json["description"],
        coverPhoto: json["cover_photo"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        type: json["type"],
        gender: json["gender"],
        startAge: json["start_age"],
        endAge: json["end_age"],
        personLimit: json["person_limit"],
        status: json["status"],
        active: json["active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "organization_id": organizationId,
        "title": title,
        "description": description,
        "cover_photo": coverPhoto,
        "start_date": startDate,
        "end_date": endDate,
        "start_time": startTime,
        "end_time": endTime,
        "latitude": latitude,
        "longitude": longitude,
        "type": type,
        "gender": gender,
        "start_age": startAge,
        "end_age": endAge,
        "person_limit": personLimit,
        "status": status,
        "active": active,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
      };
}
