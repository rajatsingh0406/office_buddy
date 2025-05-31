// To parse this JSON data, do
//
//     final feedModel = feedModelFromJson(jsonString);

import 'dart:convert';

List<FeedModel> feedModelFromJson(String str) => List<FeedModel>.from(json.decode(str).map((x) => FeedModel.fromJson(x)));

String feedModelToJson(List<FeedModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeedModel {
    int? id;
    User? user;
    String? createdAt;
    String? updatedAt;
    String? title;
    Description? description;
    String? media;
    String? stars;
    List<int>? mentionUser;
    List<dynamic>? appreciate;
    bool? liked;
    int? likedCount;

    FeedModel({
        this.id,
        this.user,
        this.createdAt,
        this.updatedAt,
        this.title,
        this.description,
        this.media,
        this.stars,
        this.mentionUser,
        this.appreciate,
        this.liked,
        this.likedCount,
    });

    factory FeedModel.fromJson(Map<String, dynamic> json) => FeedModel(
        id: json["id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        title: json["title"],
        description: json["description"] == null ? null : Description.fromJson(json["description"]),
        media: json["media"],
        stars: json["stars"],
        mentionUser: json["mention_user"] == null ? [] : List<int>.from(json["mention_user"]!.map((x) => x)),
        appreciate: json["appreciate"] == null ? [] : List<dynamic>.from(json["appreciate"]!.map((x) => x)),
        liked: json["liked"],
        likedCount: json["liked_count"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "created_at": createdAt,
        "updated_at": updatedAt,
        "title": title,
        "description": description?.toJson(),
        "media": media,
        "stars": stars,
        "mention_user": mentionUser == null ? [] : List<dynamic>.from(mentionUser!.map((x) => x)),
        "appreciate": appreciate == null ? [] : List<dynamic>.from(appreciate!.map((x) => x)),
        "liked": liked,
        "liked_count": likedCount,
    };
}

class Description {
    String? delta;
    String? html;

    Description({
        this.delta,
        this.html,
    });

    factory Description.fromJson(Map<String, dynamic> json) => Description(
        delta: json["delta"],
        html: json["html"],
    );

    Map<String, dynamic> toJson() => {
        "delta": delta,
        "html": html,
    };
}

class User {
    int? id;
    dynamic dp;
    String? name;
    String? email;

    User({
        this.id,
        this.dp,
        this.name,
        this.email,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        dp: json["dp"],
        name: json["name"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "dp": dp,
        "name": name,
        "email": email,
    };
}
