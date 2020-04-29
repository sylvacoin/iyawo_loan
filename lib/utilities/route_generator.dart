import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iyawo/blocs/auth/index.dart';
import 'package:iyawo/blocs/card/card_bloc.dart';
import 'package:iyawo/models/customer_model.dart';
import 'package:iyawo/repositories/auth_repository.dart';
import 'package:iyawo/screens/card_screen.dart';
import 'package:iyawo/screens/create_card_screen.dart';
import 'package:iyawo/screens/home_screen.dart';
import 'package:iyawo/screens/login_page.dart';
import 'package:iyawo/screens/not_found.dart';
import 'package:iyawo/screens/splash_screen.dart';

class RouteGenerator {
  static final AuthRepository userRepository = AuthRepository();

  static Route<dynamic> generateRoute(RouteSettings setting) {
    var args = setting.arguments;
    switch (setting.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthUninitialized) {
                      return SplashScreen();
                    }
                    if (state is AuthAuthenticated) {
                      return HomeScreen();
                    }
                    if (state is AuthUnauthenticated) {
                      return LoginPage(authRepo: userRepository);
                    }
                    if (state is AuthLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container();
                  },
                ));
        break;
      case '/profile':
        if (args is Customer) {
          return MaterialPageRoute(
              builder: (context) => CardScreen(
                    customer: args,
                  ));
        }
        return _errorRoute();
        break;
      case '/create-card':
        if (args is Customer) {
          return MaterialPageRoute(
              builder: (context) => CreateCardScreen(
                    customer: args,
                    // onSave:(card){
                    //   BlocProvider.of<CardBloc>(context).add(EventCardAdded(card: card));
                    // }
                  ));
        }
        return _errorRoute();
        break;
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) => NotFoundPage());
  }
}
