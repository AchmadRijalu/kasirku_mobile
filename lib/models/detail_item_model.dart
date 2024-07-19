import 'dart:convert';

class DetailItemModel {
    String? status;
    DetailItemDataModel? data;

    DetailItemModel({
        this.status,
        this.data,
    });

    factory DetailItemModel.fromRawJson(String str) => DetailItemModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DetailItemModel.fromJson(Map<String, dynamic> json) => DetailItemModel(
        status: json["status"],
        data: json["data"] == null ? null : DetailItemDataModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class DetailItemDataModel {
    int? id;
    String? name;
    int? price;
    String? description;
    DateTime? createdAt;
    DateTime? updatedAt;

    DetailItemDataModel({
        this.id,
        this.name,
        this.price,
        this.description,
        this.createdAt,
        this.updatedAt,
    });

    factory DetailItemDataModel.fromRawJson(String str) => DetailItemDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DetailItemDataModel.fromJson(Map<String, dynamic> json) => DetailItemDataModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
