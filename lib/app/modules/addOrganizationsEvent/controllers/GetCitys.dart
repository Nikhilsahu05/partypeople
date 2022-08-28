// To parse this JSON data, do
//
//     final getCitys = getCitysFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetCitys getCitysFromJson(String str) => GetCitys.fromJson(json.decode(str));

String getCitysToJson(GetCitys data) => json.encode(data.toJson());

class GetCitys {
    GetCitys({
        required this.status,
        required this.message,
        required this.data,
    });

    int status;
    String message;
    List<Datum> data;

    factory GetCitys.fromJson(Map<String, dynamic> json) => GetCitys(
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
        required this.name,
        required this.image,
        required this.latitude,
        required this.longitude,
        required this.isPopular,
    });

    String id;
    String name;
    String image;
    String latitude;
    String longitude;
    String isPopular;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        isPopular: json["is_popular"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "latitude": latitude,
        "longitude": longitude,
        "is_popular": isPopular,
    };
}
