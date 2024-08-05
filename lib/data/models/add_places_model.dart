// To parse this JSON data, do
//
//     final addPlacesModel = addPlacesModelFromJson(jsonString);

import 'dart:convert';

AddPlacesModel addPlacesModelFromJson(String str) => AddPlacesModel.fromJson(json.decode(str));

String addPlacesModelToJson(AddPlacesModel data) => json.encode(data.toJson());

class AddPlacesModel {
    String? status;
    String? message;

    AddPlacesModel({
         this.status,
         this.message,
    });

    factory AddPlacesModel.fromJson(Map<String, dynamic> json) => AddPlacesModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
