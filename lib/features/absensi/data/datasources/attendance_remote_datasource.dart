import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/utils/constants.dart';
import '../models/attendance_today_model.dart';

abstract class AttendanceRemoteDataSource {
  Future<AttendanceTodayModel> getTodayAttendance(int employeeId, {bool isWorker = false});
  Future<List<String>> getAbsensiMenuIDs(int jobTitleId, int parentMenuId);
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final ApiClient client;

  AttendanceRemoteDataSourceImpl({required this.client});

  @override
  Future<AttendanceTodayModel> getTodayAttendance(int employeeId, {bool isWorker = false}) async {
    try {
      final dio = isWorker ? client.dio : client.dioGolang;
      final endpoint = isWorker ? AppConstants.endpointGetTodayWorker : AppConstants.endpointGetTodayEmployee;
      final data = isWorker ? {'worker_id': employeeId} : {'employee_id': employeeId};

      final response = await dio.post(endpoint, data: data);

      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          return AttendanceTodayModel.fromJson(response.data['data']);
        }
        // Return empty model if data is null (V1 logic implies handling nulls)
        return const AttendanceTodayModel();
      } else {
        throw ServerException(response.data['message'] ?? 'Failed to get attendance');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Failed to get attendance: ${e.toString()}');
    }
  }

  @override
  Future<List<String>> getAbsensiMenuIDs(int jobTitleId, int parentMenuId) async {
    try {
      final response = await client.dioGolang.get(
        AppConstants.endpointJobTitleMenu,
        queryParameters: {
          'parent_menu_application_id': parentMenuId,
          'job_title_id': jobTitleId,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> list = response.data['data'] ?? [];
        return list.map((e) => e['menu_application']['name'] as String).toList();
      } else {
        throw ServerException(response.data['message'] ?? 'Failed to get menu IDs');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Failed to get menu IDs: ${e.toString()}');
    }
  }
}
