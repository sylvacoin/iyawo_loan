import 'package:equatable/equatable.dart';

class Account extends Equatable
{
  
  final String name;
  final String email;
  final int role;
  final int ssid;
  String _token;

  String get token => _token;

  set token(String token) {
    _token = token;
  }

  Account({this.name, this.email, this.role, this.ssid});

  @override
  List<Object> get props => [];

  @override
  String toString() => "Account: {name: $name, email: $email, role: $role, ssid: $ssid}";
  
  factory Account.fromJson(Map<String, dynamic> json)
  {
    Account acc = Account(
      name: (json['name'] ?? '') as String,
      email: (json['email'] ?? '') as String,
      role: json['role'] as num,
      ssid: json['ssid'] as num,
    );
    acc.token = json['token'] as String;
    return acc;
  }

  toJson()
  {
    return {
      'name':name,
      'email':email, 
      'role': role,
      'ssid': ssid,
      'token': token
    };
  }
}

class AuthToken extends Equatable{
  final String token;

  AuthToken({this.token});

  factory AuthToken.fromJson(Map<String, dynamic> json)
  {
    return AuthToken(
      token: json['data']['token']
    );
  }

  @override
  List<Object> get props => [];

  @override
  String toString() => "AuthToken : {token: $token}";
}