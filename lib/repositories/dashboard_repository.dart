import 'dart:convert';

import 'package:iyawo/models/dashboard_model.dart';
import 'package:iyawo/repositories/base/base_auth_repository.dart';
import 'package:iyawo/repositories/base/base_dashboard_repository.dart';
import 'package:iyawo/repositories/services/dashboard_db_service.dart';
import 'package:http/http.dart' as http;
import 'package:iyawo/utilities/http_routes.dart';
import 'package:meta/meta.dart';

class DashboardRepository implements BaseDashboardRepository {
  final BaseAuthRepository authRepo;
  final DashboardDBService _dbService;
  DashboardRepository(
      {@required this.authRepo,
      DashboardDBService dbService,
      http.Client httpClient})
      : _dbService = dbService ?? DashboardDBService();

  @override
  Future<Dashboard> getDashboardData() async {
    try {
      final List<Map<String, dynamic>> _dashboardData = await _dbService.getAll();
      if (_dashboardData.length > 0) {
        print(_dashboardData.toString());
        List<Dashboard> dashboard = new List<Dashboard>();
        for ( int i = 0; i<_dashboardData.length; i++ )
        {
          var dd = _dashboardData[i]['data'];
          var djson = Dashboard.fromJson(jsonDecode(dd));
          dashboard.add(djson);
          print(dashboard[i]);
        }
        // List<Dashboard> dashboard =
        //     _dashboardData.map((d) => Dashboard.fromJson(jsonDecode(d)));
        return dashboard[0];
      }
      
      String token = await authRepo.getToken();
      final response =
          await http.get(dashboardData_link, headers: {'Authorization':token});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var dashboard = Dashboard.fromJson(data['data']);
        await _dbService.insert(dashboard);
        return dashboard;
      }
    } catch (err) {
      throw err;
    }
    return null;
  }

  Future<Dashboard> refreshDashboardData() async {
    try {
      String token = await authRepo.getToken();
      final response =
          await http.get(dashboardData_link, headers: {'Authorization':token});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var dashboard = Dashboard.fromJson(data['data']);
        await _dbService.update(dashboard);
        return dashboard;
      }
    } catch (err) {
      throw err;
    }
    return null;
  }
}
