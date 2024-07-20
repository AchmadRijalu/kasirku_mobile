import 'dart:convert';

import 'package:kasirku_mobile/models/detail_transaction_model.dart';
import 'package:kasirku_mobile/models/item_model.dart';
import 'package:http/http.dart' as http;
import 'package:kasirku_mobile/models/transaction_model.dart';
import 'package:kasirku_mobile/repositories/auth_repository.dart';

class TransactionRepository {
  Future<void> createTransaction(
      String? invoiceNumber, List<ItemDataModel> items) async {
    try {
      final itemsJson = items
          .map((item) => {
                'item_id': item.id,
                'total_price': item.price,
              })
          .toList();
      final response = await http.post(
        Uri.parse('http://kasirku.test/api/createTransaction'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': await AuthRepository().getToken(),
        },
        body: jsonEncode(<String, dynamic>{
          'invoice_number': invoiceNumber,
          'items': itemsJson,
        }),
      );
    } catch (e) {
      print(e);
      throw Exception('Failed to create transaction');
    }
  }

  Future<TransactionModel> getTransactions() async {
    try {
      final response = await http.get(
        Uri.parse('http://kasirku.test/api/getTransaction'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': await AuthRepository().getToken(),
        },
      );

      return TransactionModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<DetailTransactionModel> getTransactionDetail(int id) async {
    try {
      final response = await http.get(
        Uri.parse('http://kasirku.test/api/getTransaction/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': await AuthRepository().getToken(),
        },
      );

      return DetailTransactionModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }
}
