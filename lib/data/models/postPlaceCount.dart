// To parse this JSON data, do
//
//     final postPlaceCountModel = postPlaceCountModelFromJson(jsonString);

import 'dart:convert';

PostPlaceCountModel postPlaceCountModelFromJson(String str) =>
    PostPlaceCountModel.fromJson(json.decode(str));

String postPlaceCountModelToJson(PostPlaceCountModel data) =>
    json.encode(data.toJson());

class PostPlaceCountModel {
  int? code;
  String? status;
  Data? data;

  PostPlaceCountModel({
    this.code,
    this.status,
    this.data,
  });

  factory PostPlaceCountModel.fromJson(Map<String, dynamic> json) =>
      PostPlaceCountModel(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data!.toJson(),
      };
}

class Data {
  String usersCustomersId;
  int postCount;
  int reviewedPostCount;

  Data({
    required this.usersCustomersId,
    required this.postCount,
    required this.reviewedPostCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        usersCustomersId: json["users_customers_id"],
        postCount: json["post_count"],
        reviewedPostCount: json["reviewed_post_count"],
      );

  Map<String, dynamic> toJson() => {
        "users_customers_id": usersCustomersId,
        "post_count": postCount,
        "reviewed_post_count": reviewedPostCount,
      };
}
