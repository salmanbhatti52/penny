// To parse this JSON data, do
//
//     final reportPlacesModel = reportPlacesModelFromJson(jsonString);

import 'dart:convert';

ReportPlacesModel reportPlacesModelFromJson(String str) => ReportPlacesModel.fromJson(json.decode(str));

String reportPlacesModelToJson(ReportPlacesModel data) => json.encode(data.toJson());

class ReportPlacesModel {
    String? status;
    String? message;
    Data? data;

    ReportPlacesModel({
         this.status,
         this.message,
         this.data,
    });

    factory ReportPlacesModel.fromJson(Map<String, dynamic> json) => ReportPlacesModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
    };
}

class Data {
    int placesReportId;
    int usersCustomersId;
    int pennyPlacesId;
    DateTime dateAdded;
    String status;

    Data({
        required this.placesReportId,
        required this.usersCustomersId,
        required this.pennyPlacesId,
        required this.dateAdded,
        required this.status,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        placesReportId: json["places_report_id"],
        usersCustomersId: json["users_customers_id"],
        pennyPlacesId: json["penny_places_id"],
        dateAdded: DateTime.parse(json["date_added"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "places_report_id": placesReportId,
        "users_customers_id": usersCustomersId,
        "penny_places_id": pennyPlacesId,
        "date_added": dateAdded.toIso8601String(),
        "status": status,
    };
}
