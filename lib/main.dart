import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iyawo/blocs/account/account_bloc.dart';
import 'package:iyawo/blocs/auth/index.dart';
import 'package:iyawo/blocs/customer/customers_bloc.dart';
import 'package:iyawo/blocs/dashboard/dashboard_bloc.dart';
import 'package:iyawo/blocs/login/login_bloc.dart';
import 'package:iyawo/blocs/simple_bloc_delegate.dart';
import 'package:iyawo/blocs/tab/tab_bloc.dart';
import 'package:iyawo/repositories/auth_repository.dart';
import 'package:iyawo/repositories/customer_repository.dart';
import 'package:iyawo/repositories/dashboard_repository.dart';
import 'package:iyawo/utilities/route_generator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
   final userRepo = AuthRepository();
   final dashRepo = DashboardRepository(authRepo: userRepo);
  final custRepo = CustomerRepository(authRepo: userRepo);
  
  return runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  AuthBloc(authRepo: AuthRepository())..add(AppStarted())),
          BlocProvider(
            create: (context) => LoginBloc(
                authBloc: BlocProvider.of<AuthBloc>(context),
                authRepository: userRepo),
          ),
          BlocProvider<TabBloc>(
            create: (context) => TabBloc(),
          ),
          BlocProvider<DashboardBloc>(
              create: (context) => DashboardBloc(
                    dashboardRepository: dashRepo,
                    authRepository: userRepo,
                  )..add(ReadDashboard())),
          BlocProvider<CustomersBloc>(
            create: (context) {
              return CustomersBloc(customersRepository: custRepo, authBloc: AuthBloc(authRepo: userRepo ))
                ..add(EventReadCustomers());
            },
          ),
          BlocProvider<AccountBloc>(
            create: (context) {
              return AccountBloc(authRepository: userRepo)
                ..add(EventAccountDetail());
            },
          ),
        ],
        child: MyApp(
          userRepository: userRepo,
        )),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepository userRepository;

  MyApp({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
