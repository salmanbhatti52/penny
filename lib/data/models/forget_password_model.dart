// To parse this JSON data, do
//
//     final forgetPasswordModel = forgetPasswordModelFromJson(jsonString);

import 'dart:convert';

ForgetPasswordModel forgetPasswordModelFromJson(String str) =>
    ForgetPasswordModel.fromJson(json.decode(str));

String forgetPasswordModelToJson(ForgetPasswordModel data) =>
    json.encode(data.toJson());

class ForgetPasswordModel {
  String? status;
  String? message;
  Data? data;

  ForgetPasswordModel({
    this.status,
    this.message,
    this.data,
  });

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) =>
      ForgetPasswordModel(
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
  String message;
  int otp;

  Data({
    required this.message,
    required this.otp,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "otp": otp,
      };
}
