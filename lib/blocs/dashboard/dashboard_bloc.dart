import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iyawo/models/dashboard_model.dart';
import 'package:iyawo/repositories/auth_repository.dart';
import 'package:iyawo/repositories/dashboard_repository.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository dashboardRepository;
  final AuthRepository authRepository;

  DashboardBloc({@required this.dashboardRepository, @required this.authRepository});
  
  @override
  DashboardState get initialState => DashboardInitial();

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {

     if (event is ReadDashboard)
     {
       yield DashboardLoading();
      final dashboardData = await dashboardRepository.getDashboardData();
      yield DashboardLoaded(dashboardData: dashboardData, username: '');
     }
  }
}
