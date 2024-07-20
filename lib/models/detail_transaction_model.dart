import 'dart:convert';

class DetailTransactionModel {
    String? status;
    DetailTransactionDataModel? data;

    DetailTransactionModel({
        this.status,
        this.data,
    });

    factory DetailTransactionModel.fromRawJson(String str) => DetailTransactionModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DetailTransactionModel.fromJson(Map<String, dynamic> json) => DetailTransactionModel(
        status: json["status"],
        data: json["data"] == null ? null : DetailTransactionDataModel.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class DetailTransactionDataModel {
    int? id;
    String? invoiceNumber;
    DateTime? createdAt;
    DateTime? updatedAt;
    List<TransactionItemModel>? transactionItems;

    DetailTransactionDataModel({
        this.id,
        this.invoiceNumber,
        this.createdAt,
        this.updatedAt,
        this.transactionItems,
    });

    factory DetailTransactionDataModel.fromRawJson(String str) => DetailTransactionDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DetailTransactionDataModel.fromJson(Map<String, dynamic> json) => DetailTransactionDataModel(
        id: json["id"],
        invoiceNumber: json["invoice_number"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        transactionItems: json["transaction_items"] == null ? [] : List<TransactionItemModel>.from(json["transaction_items"]!.map((x) => TransactionItemModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "invoice_number": invoiceNumber,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "transaction_items": transactionItems == null ? [] : List<dynamic>.from(transactionItems!.map((x) => x.toJson())),
    };
}

class TransactionItemModel {
    int? id;
    int? transactionId;
    int? itemId;
    int? totalPrice;
    DateTime? createdAt;
    DateTime? updatedAt;
    Item? item;

    TransactionItemModel({
        this.id,
        this.transactionId,
        this.itemId,
        this.totalPrice,
        this.createdAt,
        this.updatedAt,
        this.item,
    });

    factory TransactionItemModel.fromRawJson(String str) => TransactionItemModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TransactionItemModel.fromJson(Map<String, dynamic> json) => TransactionItemModel(
        id: json["id"],
        transactionId: json["transaction_id"],
        itemId: json["item_id"],
        totalPrice: json["total_price"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        item: json["item"] == null ? null : Item.fromJson(json["item"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "transaction_id": transactionId,
        "item_id": itemId,
        "total_price": totalPrice,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "item": item?.toJson(),
    };
}

class Item {
    int? id;
    String? name;
    int? price;
    String? description;
    DateTime? createdAt;
    DateTime? updatedAt;

    Item({
        this.id,
        this.name,
        this.price,
        this.description,
        this.createdAt,
        this.updatedAt,
    });

    factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Item.fromJson(Map<String, dynamic> json) => Item(
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
