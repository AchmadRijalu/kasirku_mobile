import 'dart:convert';

class UserModel {
    String status;
    String message;
    UserDataModel userDataModel;

    UserModel({
        required this.status,
        required this.message,
        required this.userDataModel,
    });

    factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        message: json["message"],
        userDataModel: UserDataModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": userDataModel.toJson(),
    };
}

class UserDataModel {
    User user;
    String accessToken;

    UserDataModel({
        required this.user,
        required this.accessToken,
    });

    factory UserDataModel.fromRawJson(String str) => UserDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        user: User.fromJson(json["user"]),
        accessToken: json["access_token"],
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "access_token": accessToken,
    };
}

class User {
    int id;
    String name;
    String email;
    String? password;
    String? emailVerifiedAt;
    String? createdAt;
    String? updatedAt;
    String role;

    User({
        required this.id,
        required this.name,
        required this.email,
        this.password,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        required this.role,
    });

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "role": role,
    };
}
