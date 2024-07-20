import 'dart:convert';

class TransactionModel {
    String? status;
    List<TransactionDataModel>? data;

    TransactionModel({
        this.status,
        this.data,
    });

    factory TransactionModel.fromRawJson(String str) => TransactionModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<TransactionDataModel>.from(json["data"]!.map((x) => TransactionDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class TransactionDataModel {
    int? id;
    String? invoiceNumber;
    DateTime? createdAt;
    DateTime? updatedAt;

    TransactionDataModel({
        this.id,
        this.invoiceNumber,
        this.createdAt,
        this.updatedAt,
    });

    factory TransactionDataModel.fromRawJson(String str) => TransactionDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TransactionDataModel.fromJson(Map<String, dynamic> json) => TransactionDataModel(
        id: json["id"],
        invoiceNumber: json["invoice_number"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "invoice_number": invoiceNumber,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
