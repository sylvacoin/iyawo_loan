part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final Dashboard dashboardData;
  final String username;
  final int customerCount;

  DashboardLoaded({@required this.dashboardData, this.username = 'user name', this.customerCount = 0});

  @override
  String toString() {
    return 'DashboarLoaded { dashboardData: $dashboardData}';
  }

  @override
  List<Object> get props => [dashboardData];
}
