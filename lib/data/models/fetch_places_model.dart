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
  String? placeRating;
  String? placeLocation;
  int? likeCount;
  bool? likedByMe;
  String? dateAdded;
  User? user;
  List<Image>? images;
  List<Review>? reviews;

  Datum({
    this.palaceId,
    this.placeName,
    this.placeTypeName,
    this.placeDescription,
    this.placeRating,
    this.placeLocation,
    this.likeCount,
    this.likedByMe,
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
        placeRating: json["place_rating"],
        placeLocation: json["place_location"],
        likeCount: json["likes_count"],
        likedByMe: json["liked_by_me"],
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
        "place_rating": placeRating,
        "place_location": placeLocation,
        "likes_count": likeCount,
        "liked_by_me": likedByMe,
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
    int reviewId;
    int reviewUserId;
    String reviewUserName;
    String reviewUserEmail;
    String reviewUserProfilePicture;
    int rating;
    String review;
    int likesCount;
    bool likedByMe;

    Review({
        required this.reviewId,
        required this.reviewUserId,
        required this.reviewUserName,
        required this.reviewUserEmail,
        required this.reviewUserProfilePicture,
        required this.rating,
        required this.review,
        required this.likesCount,
        required this.likedByMe,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        reviewId: json["review_id"],
        reviewUserId: json["review_user_id"],
        reviewUserName: json["review_user_name"],
        reviewUserEmail: json["review_user_email"],
        reviewUserProfilePicture: json["review_user_profile_picture"],
        rating: json["rating"],
        review: json["review"],
        likesCount: json["likes_count"],
        likedByMe: json["liked_by_me"],
    );

    Map<String, dynamic> toJson() => {
        "review_id": reviewId,
        "review_user_id": reviewUserId,
        "review_user_name": reviewUserName,
        "review_user_email": reviewUserEmail,
        "review_user_profile_picture": reviewUserProfilePicture,
        "rating": rating,
        "review": review,
        "likes_count": likesCount,
        "liked_by_me": likedByMe,
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
