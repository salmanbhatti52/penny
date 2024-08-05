// To parse this JSON data, do
//
//     final fetchPlacesModel = fetchPlacesModelFromJson(jsonString);

import 'dart:convert';

FetchPlacesModel fetchPlacesModelFromJson(String str) =>
    FetchPlacesModel.fromJson(json.decode(str));

String fetchPlacesModelToJson(FetchPlacesModel data) =>
    json.encode(data.toJson());

class FetchPlacesModel {
  int? code;
  String? status;
  String? message;
  List<Datum>? data;

  FetchPlacesModel({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  factory FetchPlacesModel.fromJson(Map<String, dynamic> json) =>
      FetchPlacesModel(
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
  String? placeTypeName;
  String? placeDescription;
  String? placeLocation;
  String? dateAdded;
  User? user;
  List<Image>? images;
  List<Review>? reviews;

  Datum({
    this.palaceId,
    this.placeName,
    this.placeTypeName,
    this.placeDescription,
    this.placeLocation,
    this.dateAdded,
    this.user,
    this.images,
    this.reviews,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        palaceId: json["palace_id"],
        placeName: json["place_name"],
        placeTypeName: json["place_type_name"],
        placeDescription: json["place_description"],
        placeLocation: json["place_location"],
        dateAdded: json["date_added"],
        user: User.fromJson(json["user"]),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "palace_id": palaceId,
        "place_name": placeName,
        "place_type_name": placeTypeName,
        "place_description": placeDescription,
        "place_location": placeLocation,
        "date_added": dateAdded,
        "user": user!.toJson(),
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
  int? reviewUserId;
  int? rating;
  String? review;
  int? likesCount;

  Review({
    this.reviewId,
    this.reviewUserId,
    this.rating,
    this.review,
    this.likesCount,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        reviewId: json["review_id"],
        reviewUserId: json["review_user_id"],
        rating: json["rating"],
        review: json["review"],
        likesCount: json["likes_count"],
      );

  Map<String, dynamic> toJson() => {
        "review_id": reviewId,
        "review_user_id": reviewUserId,
        "rating": rating,
        "review": review,
        "likes_count": likesCount,
      };
}

class User {
  int? userId;
  String? username;
  String? email;
  String? profilePicture;

  User({
    this.userId,
    this.username,
    this.email,
    this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        username: json["username"],
        email: json["email"],
        profilePicture: json["profile_picture"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "email": email,
        "profile_picture": profilePicture,
      };
}
