// To parse this JSON data, do
//
//     final openProfilePostModel = openProfilePostModelFromJson(jsonString);

import 'dart:convert';

OpenProfilePostModel openProfilePostModelFromJson(String str) => OpenProfilePostModel.fromJson(json.decode(str));

String openProfilePostModelToJson(OpenProfilePostModel data) => json.encode(data.toJson());

class OpenProfilePostModel {
    int? code;
    String? status;
    String? message;
    List<Datum>? data;

    OpenProfilePostModel({
         this.code,
         this.status,
         this.message,
         this.data,
    });

    factory OpenProfilePostModel.fromJson(Map<String, dynamic> json) => OpenProfilePostModel(
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
    String placeRating;
    String placeLocation;
    DateTime dateAdded;
    int placeTypeId;
    String placeTypeName;
    int likesCount;
    bool likedByMe;
    User user;
    List<Image> images;
    List<Review> reviews;

    Datum({
        required this.palaceId,
        required this.placeName,
        required this.placeDescription,
        required this.placeRating,
        required this.placeLocation,
        required this.dateAdded,
        required this.placeTypeId,
        required this.placeTypeName,
        required this.likesCount,
        required this.likedByMe,
        required this.user,
        required this.images,
        required this.reviews,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        palaceId: json["palace_id"],
        placeName: json["place_name"],
        placeDescription: json["place_description"],
        placeRating: json["place_rating"],
        placeLocation: json["place_location"],
        dateAdded: DateTime.parse(json["date_added"]),
        placeTypeId: json["place_type_id"],
        placeTypeName: json["place_type_name"],
        likesCount: json["likes_count"],
        likedByMe: json["liked_by_me"],
        user: User.fromJson(json["user"]),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "palace_id": palaceId,
        "place_name": placeName,
        "place_description": placeDescription,
        "place_rating": placeRating,
        "place_location": placeLocation,
        "date_added": dateAdded.toIso8601String(),
        "place_type_id": placeTypeId,
        "place_type_name": placeTypeName,
        "likes_count": likesCount,
        "liked_by_me": likedByMe,
        "user": user.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
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
    int userId;
    String username;
    String email;
    String profilePicture;

    User({
        required this.userId,
        required this.username,
        required this.email,
        required this.profilePicture,
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
