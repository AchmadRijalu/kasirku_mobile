import 'dart:convert';

class ItemModel {
    String? status;
    List<ItemDataModel>? data;

    ItemModel({
        this.status,
        this.data,
    });

    factory ItemModel.fromRawJson(String str) => ItemModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<ItemDataModel>.from(json["data"]!.map((x) => ItemDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class ItemDataModel {
    int? id;
    String? name;
    int? price;
    String? description;
    DateTime? createdAt;
    DateTime? updatedAt;

    ItemDataModel({
        this.id,
        this.name,
        this.price,
        this.description,
        this.createdAt,
        this.updatedAt,
    });

    factory ItemDataModel.fromRawJson(String str) => ItemDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ItemDataModel.fromJson(Map<String, dynamic> json) => ItemDataModel(
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
