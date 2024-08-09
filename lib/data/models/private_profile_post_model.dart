// To parse this JSON data, do
//
//     final privateProfilePostModel = privateProfilePostModelFromJson(jsonString);

import 'dart:convert';

PrivateProfilePostModel privateProfilePostModelFromJson(String str) =>
    PrivateProfilePostModel.fromJson(json.decode(str));

String privateProfilePostModelToJson(PrivateProfilePostModel data) =>
    json.encode(data.toJson());

class PrivateProfilePostModel {
  int? code;
  String? status;
  String? message;
  List<Datum>? data;

  PrivateProfilePostModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  factory PrivateProfilePostModel.fromJson(Map<String, dynamic> json) =>
      PrivateProfilePostModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int palaceId;
  String placeName;
  String placeDescription;
  List<Image> images;
  List<dynamic> reviews;

  Datum({
    required this.palaceId,
    required this.placeName,
    required this.placeDescription,
    required this.images,
    required this.reviews,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        palaceId: json["palace_id"],
        placeName: json["place_name"],
        placeDescription: json["place_description"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "palace_id": palaceId,
        "place_name": placeName,
        "place_description": placeDescription,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
      };
}

class Image {
  int imageId;
  String imageName;

  Image({
    required this.imageId,
    required this.imageName,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        imageId: json["image_id"],
        imageName: json["image_name"],
      );

  Map<String, dynamic> toJson() => {
        "image_id": imageId,
        "image_name": imageName,
      };
}
