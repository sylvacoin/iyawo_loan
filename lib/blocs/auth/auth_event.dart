import 'package:equatable/equatable.dart';
import 'package:iyawo/models/account_model.dart';
import 'package:meta/meta.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent{}
class LoggedIn extends AuthEvent{
  final Account loggedUser;
  LoggedIn({@required this.loggedUser});

  @override
  String toString()=>"LoggedIn { user: $loggedUser}";

  @override
  List<Object> get props => [loggedUser];
}

class LoggedOut extends AuthEvent{}
