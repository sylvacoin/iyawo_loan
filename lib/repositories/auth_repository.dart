import 'dart:convert';

import 'package:iyawo/models/account_model.dart';
import 'package:iyawo/repositories/base/base_auth_repository.dart';
import 'package:http/http.dart' as http;
import 'package:iyawo/utilities/http_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository implements BaseAuthRepository {
  @override
  Future<Account> doLogin(String email, String password) async {
    try {
      final response = await http
          .post(login_link, body: {'email': email.trim(), 'password': password});
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['status'] == 200) {
          AuthToken authToken = AuthToken.fromJson(result);
          String token = authToken.token.toString();
          Account account = await validateToken(token);
          return account;
        }
      }
      return null;
    } catch (err) {
      throw err;
    }
  }

  
  Future<Account> validateToken(String token) async {
    try {
      SharedPreferences storage = await SharedPreferences.getInstance();
      //check webclient
      final httpResponse =
          await http.get(verifyToken_link, headers: {'Authorization': token});
      if (httpResponse.statusCode == 200) {
        var responseData = jsonDecode(httpResponse.body);
        Account userAccount = Account.fromJson(responseData['data']);
        userAccount.token = token;
        storage.setString('user', jsonEncode(userAccount.toJson()));
        return userAccount;
      }
      return null;
    } catch (err) {
      throw err;
    }
  }

  @override
  Future<void> doLogout() async {
    try {
      SharedPreferences storage = await SharedPreferences.getInstance();
      storage.remove('user');
    } catch (err) {
      throw err;
    }
  }

  @override
  Future<Account> getCurrentUser() async {
    try {
      SharedPreferences storage = await SharedPreferences.getInstance();
      final userJsonData = storage.get('user');
      if (userJsonData != null) {
        Account user = Account.fromJson(jsonDecode(userJsonData));
        return user;
      }
    } catch (err) {
      throw err;
    }
    return null;
  }

  @override
  Future<String> getToken() async {
    try {
      var user = await getCurrentUser();
      if (user != null) {
        return user.token;
      }
    } catch (err) {
      throw err;
    }

    return null;
  }

  @override
  Future<bool> hasToken() async {
    var token = await getToken();
    if (token != null && token.isNotEmpty) {
      return true;
    }
    return false;
  }
}
