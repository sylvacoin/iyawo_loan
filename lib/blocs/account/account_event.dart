part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();
  @override
  List<Object> get props => [];
}

class EventAccountDetail extends AccountEvent {}
class EventAccountLoggedOut extends AccountEvent{}