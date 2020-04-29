import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iyawo/blocs/auth/index.dart';
import 'package:iyawo/repositories/auth_repository.dart';
import 'package:meta/meta.dart';


part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthBloc authBloc;
  final AuthRepository authRepository;

  LoginBloc({@required this.authBloc, @required this.authRepository});

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is OnLoginButtonPressed) {
      yield LoginLoading();

      try {
        final user = await authRepository.doLogin(
          event.username,
          event.password,
        );

        if ( user != null )
        {
          authBloc.add(LoggedIn(loggedUser: user));
          yield LoginInitial();
        }else{
          yield LoginFailed(error: "Invalid username or password");
        }
        
      } catch (error) {
        yield LoginFailed(error: error.toString());
      }
    }
  }
}
