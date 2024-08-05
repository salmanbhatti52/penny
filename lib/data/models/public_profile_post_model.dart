// To parse this JSON data, do
//
//     final publicProfilePostModel = publicProfilePostModelFromJson(jsonString);

import 'dart:convert';

PublicProfilePostModel publicProfilePostModelFromJson(String str) =>
    PublicProfilePostModel.fromJson(json.decode(str));

String publicProfilePostModelToJson(PublicProfilePostModel data) =>
    json.encode(data.toJson());

class PublicProfilePostModel {
  int? code;
  String? status;
  String? message;
  List<Datum>? data;

  PublicProfilePostModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  factory PublicProfilePostModel.fromJson(Map<String, dynamic> json) =>
      PublicProfilePostModel(
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
  int? palaceId;
  String? placeName;
  String? placeDescription;
  String? visibilityFlag;
  List<Image>? images;
  List<Review>? reviews;

  Datum({
    this.palaceId,
    this.placeName,
    this.placeDescription,
    this.visibilityFlag,
    this.images,
    this.reviews,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        palaceId: json["palace_id"],
        placeName: json["place_name"],
        placeDescription: json["place_description"],
        visibilityFlag: json["visibility_flag"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "palace_id": palaceId,
        "place_name": placeName,
        "place_description": placeDescription,
        "visibility_flag": visibilityFlag,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "reviews": List<dynamic>.from(reviews!.map((x) => x.toJson())),
      };
}

class Image {
  int? imageId;
  String? imageName;

  Image({
    this.imageId,
    this.imageName,
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

class Review {
  int? reviewId;
  int? rating;
  String? review;
  int? likesCount;

  Review({
    this.reviewId,
    this.rating,
    this.review,
    this.likesCount,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        reviewId: json["review_id"],
        rating: json["rating"],
        review: json["review"],
        likesCount: json["likes_count"],
      );

  Map<String, dynamic> toJson() => {
        "review_id": reviewId,
        "rating": rating,
        "review": review,
        "likes_count": likesCount,
      };
}
