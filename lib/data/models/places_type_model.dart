// To parse this JSON data, do
//
//     final placesTypeModel = placesTypeModelFromJson(jsonString);

import 'dart:convert';

PlacesTypeModel placesTypeModelFromJson(String str) => PlacesTypeModel.fromJson(json.decode(str));

String placesTypeModelToJson(PlacesTypeModel data) => json.encode(data.toJson());

class PlacesTypeModel {
    int? code;
    String? status;
    List<Datum>? data;

    PlacesTypeModel({
         this.code,
         this.status,
         this.data,
    });

    factory PlacesTypeModel.fromJson(Map<String, dynamic> json) => PlacesTypeModel(
        code: json["code"],
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int placesTypeId;
    String place;
    String status;

    Datum({
        required this.placesTypeId,
        required this.place,
        required this.status,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        placesTypeId: json["places_type_id"],
        place: json["place"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "places_type_id": placesTypeId,
        "place": place,
        "status": status,
    };
}
