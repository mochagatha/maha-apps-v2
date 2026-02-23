import '../../../../../../../../../core/error/exceptions.dart';
import '../../../../../../../../../core/network/api_client.dart';
import '../models/kpi_indicator_model.dart';
import '../models/kpi_role_indicator_model.dart';

/// Response type holding all indicator groups
class KpiIndicatorsResponse {
  final List<KpiIndicatorModel> attendance;
  final List<KpiIndicatorModel> supervisorAssessment;
  final List<KpiIndicatorModel> targetPoint;
  final List<KpiRoleIndicatorModel> task;
  final List<KpiRoleIndicatorModel> workPlan;

  const KpiIndicatorsResponse({
    required this.attendance,
    required this.supervisorAssessment,
    required this.targetPoint,
    required this.task,
    required this.workPlan,
  });
}

abstract class PenilaianKinerjaRemoteDataSource {
  /// GET employee/kpi-indicator?type_indicator=Kehadiran,Penilaian Atasan,Rencana Kerja,Tugas
  Future<KpiIndicatorsResponse> getKpiIndicators();

  /// POST employee/kpi-indicator/update-many
  /// Body: [{"id": x, "value": y}, ...]
  Future<void> updateManyKpiIndicators(List<Map<String, int>> items);
}

class PenilaianKinerjaRemoteDataSourceImpl implements PenilaianKinerjaRemoteDataSource {
  final ApiClient apiClient;

  PenilaianKinerjaRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<KpiIndicatorsResponse> getKpiIndicators() async {
    try {
      final response = await apiClient.dioGolang.get(
        '/employee/kpi-indicator',
        queryParameters: {
          'type_indicator': 'Kehadiran,Penilaian Atasan,Rencana Kerja,Tugas',
        },
      );

      if (response.statusCode == 200) {
        final data = response.data['data'] as Map<String, dynamic>?;

        if (data == null) {
          throw ServerException('Invalid response format: data is null');
        }

        List<KpiIndicatorModel> _parseIndicators(String key) {
          final list = data[key];
          if (list == null || list is! List) return [];
          return list.map((e) => KpiIndicatorModel.fromJson(e)).toList();
        }

        List<KpiRoleIndicatorModel> _parseRoleIndicators(String key) {
          final list = data[key];
          if (list == null || list is! List) return [];
          return list.map((e) => KpiRoleIndicatorModel.fromJson(e)).toList();
        }

        return KpiIndicatorsResponse(
          attendance: _parseIndicators('attendance'),
          supervisorAssessment: _parseIndicators('supervisor_assessment'),
          targetPoint: _parseIndicators('target_point'),
          task: _parseRoleIndicators('task'),
          workPlan: _parseRoleIndicators('work_plan'),
        );
      } else {
        throw ServerException(
          response.data['message'] ?? 'Failed to get KPI indicators',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Failed to get KPI indicators: ${e.toString()}');
    }
  }

  @override
  Future<void> updateManyKpiIndicators(List<Map<String, int>> items) async {
    try {
      final response = await apiClient.dioGolang.put(
        '/employee/kpi-indicator/update-many',
        data: items,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException(
          response.data['message'] ?? 'Failed to update KPI indicators',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Failed to update KPI indicators: ${e.toString()}');
    }
  }
}
