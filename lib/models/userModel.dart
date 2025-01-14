// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    int? id;
    String? firstName;
    String? lastName;
    int? role;
    String? mobile;
    dynamic email;
    dynamic profileImg;
    DateTime? lastLoginAt;
    int? mobileOtp;
    dynamic emailOtp;
    int? isEmailVerified;
    int? isMobileVerified;
    dynamic fcmToken;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    int? status;
    dynamic url;
    dynamic altText;

    UserModel({
        this.id,
        this.firstName,
        this.lastName,
        this.role,
        this.mobile,
        this.email,
        this.profileImg,
        this.lastLoginAt,
        this.mobileOtp,
        this.emailOtp,
        this.isEmailVerified,
        this.isMobileVerified,
        this.fcmToken,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.status,
        this.url,
        this.altText,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        role: json["role"],
        mobile: json["mobile"],
        email: json["email"],
        profileImg: json["profile_img"],
        lastLoginAt: json["last_login_at"] == null ? null : DateTime.parse(json["last_login_at"]),
        mobileOtp: json["mobile_otp"],
        emailOtp: json["email_otp"],
        isEmailVerified: json["is_email_verified"],
        isMobileVerified: json["is_mobile_verified"],
        fcmToken: json["fcm_token"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        status: json["status"],
        url: json["url"],
        altText: json["alt_text"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "role": role,
        "mobile": mobile,
        "email": email,
        "profile_img": profileImg,
        "last_login_at": lastLoginAt?.toIso8601String(),
        "mobile_otp": mobileOtp,
        "email_otp": emailOtp,
        "is_email_verified": isEmailVerified,
        "is_mobile_verified": isMobileVerified,
        "fcm_token": fcmToken,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "status": status,
        "url": url,
        "alt_text": altText,
    };
}
