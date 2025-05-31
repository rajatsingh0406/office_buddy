// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    User? user;
    Tokens? tokens;

    LoginResponseModel({
        this.user,
        this.tokens,
    });

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        tokens: json["tokens"] == null ? null : Tokens.fromJson(json["tokens"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "tokens": tokens?.toJson(),
    };
}

class Tokens {
    String? refresh;
    String? access;

    Tokens({
        this.refresh,
        this.access,
    });

    factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        refresh: json["refresh"],
        access: json["access"],
    );

    Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
    };
}

class User {
    int? id;
    String? name;
    String? firstName;
    String? lastName;
    String? username;
    String? email;
    String? profilePic;

    User({
        this.id,
        this.name,
        this.firstName,
        this.lastName,
        this.username,
        this.email,
        this.profilePic,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        email: json["email"],
        profilePic: json["profile_pic"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "email": email,
        "profile_pic": profilePic,
    };
}
