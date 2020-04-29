import 'package:iyawo/models/account_model.dart';

abstract class BaseAuthRepository
{
  Future<Account> doLogin(String email, String password);
  Future<void> doLogout();
  Future<Account> getCurrentUser();
  Future<String> getToken();
  Future<bool> hasToken();
}