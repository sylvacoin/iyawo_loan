import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:iyawo/repositories/auth_repository.dart';
import 'package:meta/meta.dart';
import 'index.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepo;

  AuthBloc({@required this.authRepo});

  @override
  AuthState get initialState => AuthUninitialized();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    
    if (event is AppStarted)
    {
      
      final bool hasToken = await authRepo.hasToken();

      if (hasToken) {
        yield AuthAuthenticated();
      } else {
        yield AuthUnauthenticated();
      }
    }
    
    if ( event is LoggedIn)
    {
      yield AuthLoading();
      
      final bool hasToken = await authRepo.hasToken();

      if (!hasToken) {
        
        var user = await authRepo.getCurrentUser();
        if (user == null)
        {
          yield AuthUnauthenticated();
        }
      }
      
      yield AuthAuthenticated();
    }
    
    if ( event is LoggedOut)
    {
      yield AuthLoading();
      await authRepo.doLogout();
      yield AuthUnauthenticated();
    }
  }
}
