import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kasirku_mobile/models/login_form_model.dart';
import 'package:kasirku_mobile/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<UserDataModel> loginRepository(String? email, String? password) async {
    try {
      final response =
          await http.post(Uri.parse("http://kasirku.test/api/user/login"),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
              body: jsonEncode({"email": email, "password": password}));

      if (response.statusCode == 200) {
        var resHolder = jsonDecode(response.body)['message'];
        if (resHolder == "Login successfully") {
          final userData =
              UserDataModel.fromJson(jsonDecode(response.body)['data']);
          await storeCredentialToLocal(userData, password);
          return userData;
        } else {
          throw "Username/Password Salah";
        }
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> storeCredentialToLocal(
      UserDataModel userDataModel, String? password) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'token', value: userDataModel.accessToken);
      await storage.write(key: 'email', value: userDataModel.user.email);
      await storage.write(key: 'password', value: password);
      await storage.write(key: 'role', value: userDataModel.user.role);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logoutRepository() async {
    try {
      final response = await http.post(
        Uri.parse("http://kasirku.test/api/user/logout"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': await getToken(),
        },
      );

      if (response.statusCode == 200) {
        await clearLocalStorage();
      } else {
        throw jsonDecode(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginFormModel?> getCredentialFromLocal() async {
    try {
      const storage = FlutterSecureStorage();

      Map<String, dynamic> values = await storage.readAll();
      if (values['email'] == null ||
          values['password'] == null ||
          values['role'] == null) {
        throw 'Belum Ter-Auth';
      } else {
        final LoginFormModel? data = LoginFormModel(
          email: values['email'],
          password: values['password'],
        );
        return data;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getToken() async {
    String? token = '';
    const storage = FlutterSecureStorage();

    String? value = await storage.read(key: 'token');

    if (value != null) {
      token = "Bearer " + value;
    }
    return token;
  }

  Future<void> clearLocalStorage() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}
