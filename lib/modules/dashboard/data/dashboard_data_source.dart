import '../models/dashboard_model.dart';

abstract class DashboardDataSource {
  Future<DashboardResponse> getDashboard();
}
