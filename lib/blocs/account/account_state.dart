part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();
  @override
  List<Object> get props => [];
}

class StateAccountInitial extends AccountState {}

class StateAccountLoaded extends AccountState {
  final Account user;
  StateAccountLoaded({ @required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() {
    return "StateAccountLoaded { user: $user}";
  }
}
class StateAccountFailed extends AccountState {}
