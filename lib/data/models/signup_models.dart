// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
    int? code;
    String? status;
    String? message;
    Data? data;

    SignUpModel({
         this.code,
         this.status,
          this.message,
         this.data,
    });

    factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        
        "status": status,
        "message": message,
        "data": data!.toJson(),
    };
}

class Data {
    int usersCustomersId;
    dynamic referralUsersCustomersId;
    String oneSignalId;
    String userName;
    String email;
    String password;
    String accountType;
    dynamic profilePicture;
    dynamic profileBio;
    dynamic socialAccType;
    dynamic googleAccessToken;
    dynamic facebookId;
    dynamic authenticationToken;
    DateTime dateAdded;
    String status;
    dynamic verifyCode;
    String notifications;

    Data({
        required this.usersCustomersId,
        required this.referralUsersCustomersId,
        required this.oneSignalId,
        required this.userName,
        required this.email,
        required this.password,
        required this.accountType,
        required this.profilePicture,
        required this.profileBio,
        required this.socialAccType,
        required this.googleAccessToken,
        required this.facebookId,
        required this.authenticationToken,
        required this.dateAdded,
        required this.status,
        required this.verifyCode,
        required this.notifications,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        usersCustomersId: json["users_customers_id"],
        referralUsersCustomersId: json["referral_users_customers_id"],
        oneSignalId: json["one_signal_id"],
        userName: json["user_name"],
        email: json["email"],
        password: json["password"],
        accountType: json["account_type"],
        profilePicture: json["profile_picture"],
        profileBio: json["profile_bio"],
        socialAccType: json["social_acc_type"],
        googleAccessToken: json["google_access_token"],
        facebookId: json["facebook_id"],
        authenticationToken: json["authentication_token"],
        dateAdded: DateTime.parse(json["date_added"]),
        status: json["status"],
        verifyCode: json["verify_code"],
        notifications: json["notifications"],
    );

    Map<String, dynamic> toJson() => {
        "users_customers_id": usersCustomersId,
        "referral_users_customers_id": referralUsersCustomersId,
        "one_signal_id": oneSignalId,
        "user_name": userName,
        "email": email,
        "password": password,
        "account_type": accountType,
        "profile_picture": profilePicture,
        "profile_bio": profileBio,
        "social_acc_type": socialAccType,
        "google_access_token": googleAccessToken,
        "facebook_id": facebookId,
        "authentication_token": authenticationToken,
        "date_added": dateAdded.toIso8601String(),
        "status": status,
        "verify_code": verifyCode,
        "notifications": notifications,
    };
}
