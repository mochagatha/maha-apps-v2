import 'package:flutter/foundation.dart';
import '../../domain/entities/attendance_today.dart';
import '../../domain/usecases/get_absensi_menu_ids.dart';
import '../../domain/usecases/get_today_attendance.dart';

enum AttendanceStatus { initial, loading, loaded, error }

class AttendanceProvider extends ChangeNotifier {
  final GetTodayAttendance getTodayAttendance;
  final GetAbsensiMenuIDs getAbsensiMenuIDs;

  AttendanceProvider({
    required this.getTodayAttendance,
    required this.getAbsensiMenuIDs,
  });

  AttendanceStatus _status = AttendanceStatus.initial;
  AttendanceToday? _attendanceToday;
  List<String> _menuIDs = [];
  String? _errorMessage;

  // Getters
  AttendanceStatus get status => _status;
  AttendanceToday? get attendanceToday => _attendanceToday;
  List<String> get menuIDs => _menuIDs;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == AttendanceStatus.loading;
  bool get hasError => _status == AttendanceStatus.error;

  Future<void> loadData({
    required int employeeId,
    required int jobTitleId,
    required int parentMenuId,
    bool isWorker = false,
  }) async {
    _status = AttendanceStatus.loading;
    _errorMessage = null;
    notifyListeners();

    // 1. Get Attendance Data
    final attendanceResult = await getTodayAttendance(
      employeeId,
      isWorker: isWorker,
    );

    attendanceResult.fold(
      (failure) {
        _errorMessage = failure.message;
        _status = AttendanceStatus.error;
        notifyListeners();
      },
      (data) async {
        _attendanceToday = data;
        
        // 2. Get Menu IDs (Only if attendance loaded successfully, or parallel?)
        // V1 does parallel or sequential. Let's do sequential for safety or parallel for speed.
        // V1 did _getMenuIDs() and getAttendance() separately in onInit.
        
        final menuResult = await getAbsensiMenuIDs(jobTitleId, parentMenuId);
        
        menuResult.fold(
          (failure) {
             // If menu fails, do we fail everything?
             // V1 didn't seem to block main UI if menu failed, but let's just log it or show error.
             // We'll keep attendance data but set error message for menu.
             debugPrint('Failed to load menu IDs: ${failure.message}');
          },
          (ids) {
            _menuIDs = ids;
          },
        );

        _status = AttendanceStatus.loaded;
        notifyListeners();
      },
    );
  }

  void refresh({
    required int employeeId,
    required int jobTitleId,
    required int parentMenuId,
    bool isWorker = false,
  }) {
    loadData(
      employeeId: employeeId,
      jobTitleId: jobTitleId,
      parentMenuId: parentMenuId,
      isWorker: isWorker,
    );
  }
}
