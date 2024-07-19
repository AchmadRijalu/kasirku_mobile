import 'dart:convert';
import 'package:kasirku_mobile/models/detail_item_model.dart';
import 'package:kasirku_mobile/models/item_model.dart';
import 'package:http/http.dart' as http;
import 'package:kasirku_mobile/repositories/auth_repository.dart';

class ItemRepository {
  Future<ItemModel> getItems() async {
    try {
      final response = await http.get(
        Uri.parse("http://kasirku.test/api/getItem"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': await AuthRepository().getToken(),
        },
      );
      if (response.statusCode != 200) {
        throw ("You are not authorized to access this page");
      }
      return ItemModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<DetailItemModel> getItemDetail(int id) async {
    try {
      final response = await http.get(
        Uri.parse("http://kasirku.test/api/getItem/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': await AuthRepository().getToken(),
        },
      );
      return DetailItemModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> createItem(
    String? name,
    String? price,
    String? description,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("http://kasirku.test/api/createItem"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': await AuthRepository().getToken(),
        },
        body: jsonEncode({
          "name": name,
          "price": int.parse(price ?? ""),
          "description": description
        }),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateItem(
      int? id, String? name, int? price, String? description) async {
    try {
      final response = await http.post(
        Uri.parse("http://kasirku.test/api/updateItem/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': await AuthRepository().getToken(),
        },
        body: jsonEncode(
            {"name": name, "price": price, "description": description}),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteItem(int id) async {
    try {
      final response = await http.post(
        Uri.parse("http://kasirku.test/api/deleteItem/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': await AuthRepository().getToken(),
        },
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
