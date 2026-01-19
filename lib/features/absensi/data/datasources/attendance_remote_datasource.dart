import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/utils/constants.dart';
import '../models/attendance_today_model.dart';

abstract class AttendanceRemoteDataSource {
  Future<AttendanceTodayModel> getTodayAttendance(int employeeId, {bool isWorker = false});
  Future<List<String>> getAbsensiMenuIDs(int jobTitleId, int parentMenuId);
  
  Future<String> submitAttendance({
    required int employeeId,
    required String attendanceDate,
    required String attendanceTime,
    required String attendanceLocation,
    required String attendancePhotoPath,
    required String attendanceBranch,
    required int status,
    bool isWorker = false,
  });
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

  @override
  Future<String> submitAttendance({
    required int employeeId,
    required String attendanceDate,
    required String attendanceTime,
    required String attendanceLocation,
    required String attendancePhotoPath,
    required String attendanceBranch,
    required int status,
    bool isWorker = false,
  }) async {
    try {
      final dio = isWorker ? client.dio : client.dioGolang;
      final endpoint = isWorker 
          ? AppConstants.endpointSubmitAttendanceWorker 
          : AppConstants.endpointSubmitAttendance;
      
      final employeeKey = isWorker ? 'worker_id' : 'employee_id';

      // Create FormData for multipart upload
      final formData = FormData.fromMap({
        employeeKey: employeeId.toString(),
        'attendance_date': attendanceDate,
        'attendance_time': attendanceTime,
        'attendance_location': attendanceLocation,
        'attendance_photo': await MultipartFile.fromFile(
          attendancePhotoPath,
          filename: attendancePhotoPath.split('/').last,
        ),
        'attendance_branch': attendanceBranch,
        'status': status,
      });

      final response = await dio.post(endpoint, data: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['message'] ?? 'Attendance submitted successfully';
      } else {
        throw ServerException(response.data['message'] ?? 'Failed to submit attendance');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Failed to submit attendance: ${e.toString()}');
    }
  }
}
