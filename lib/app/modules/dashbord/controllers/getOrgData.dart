// To parse this JSON data, do
//
//     final getOrgData = getOrgDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetOrgData getOrgDataFromJson(String str) => GetOrgData.fromJson(json.decode(str));

String getOrgDataToJson(GetOrgData data) => json.encode(data.toJson());

class GetOrgData {
    GetOrgData({
        required this.status,
        required this.message,
        required this.data,
    });

    int status;
    String message;
    List<Datum> data;

    factory GetOrgData.fromJson(Map<String, dynamic> json) => GetOrgData(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
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
        required this.isDeleted,
        required this.distance,
        required this.organization,
        required this.fullName,
        required this.profilePicture,
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
    String isDeleted;
    String distance;
    dynamic organization;
    String fullName;
    dynamic profilePicture;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        isDeleted: json["is_deleted"],
        distance: json["distance"]??"",
        organization: json["organization"],
        fullName: json["full_name"],
        profilePicture: json["profile_picture"],
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
        "is_deleted": isDeleted,
        "distance": distance,
        "organization": organization,
        "full_name": fullName,
        "profile_picture": profilePicture,
    };
}
