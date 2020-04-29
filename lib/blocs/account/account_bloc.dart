import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iyawo/models/account_model.dart';
import 'package:iyawo/repositories/auth_repository.dart';
import 'package:meta/meta.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {

  final AuthRepository authRepository;
  

  AccountBloc({ @required this.authRepository});

  @override
  AccountState get initialState => StateAccountInitial();

  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    if (event is EventAccountDetail)
    {
      var user = await authRepository.getCurrentUser();
      yield StateAccountLoaded(user: user);
    }
  }
}
