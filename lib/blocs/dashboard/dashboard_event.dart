part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
  @override
  List<Object> get props => [];
}

///gets the initial dashboard data
class ReadDashboard extends DashboardEvent{}

