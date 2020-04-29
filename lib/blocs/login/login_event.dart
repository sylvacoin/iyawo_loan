part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent(); 
  
  @override
  List<Object> get props => [];
}

class OnLoginButtonPressed extends LoginEvent{
  final String username;
  final String password;

  OnLoginButtonPressed({@required this.username, @required this.password});

  @override
  String toString() => ' OnLoginButtonPressed { username: $username, password: $password}';

  @override
  List<Object> get props => [username, password];
}