import 'package:iyawo/models/dashboard_model.dart';

abstract class BaseDashboardRepository
{
  Future<Dashboard> getDashboardData();
  Future<Dashboard> refreshDashboardData();
}