// To parse this JSON data, do
//
//     final GetAmenities = GetAmenitiesFromJson(jsonString);

import 'dart:convert';

// ignore_for_file: file_names, unused_import, non_constant_identifier_names, depend_on_referenced_packages

import 'package:meta/meta.dart';

GetAmenities GetAmenitiesFromJson(String str) =>
    GetAmenities.fromJson(json.decode(str));

String GetAmenitiesToJson(GetAmenities data) => json.encode(data.toJson());

class GetAmenities {
  GetAmenities({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  bool message;
  List<Datum> data;

  factory GetAmenities.fromJson(Map<String, dynamic> json) => GetAmenities(
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
    // required this.party_cat_id,
    required this.name,
  });

  String id;
  String name;

  // String party_cat_id;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        // party_cat_id: json["party_cat_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        // "party_cat_id": party_cat_id,
      };
}
