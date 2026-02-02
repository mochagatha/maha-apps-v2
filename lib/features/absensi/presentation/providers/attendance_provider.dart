import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/attendance_today.dart';
import '../../domain/usecases/get_absensi_menu_ids.dart';
import '../../domain/usecases/get_today_attendance.dart';
import '../../domain/usecases/submit_attendance.dart';

enum AttendanceStatus { initial, loading, loaded, error }

class AttendanceProvider extends ChangeNotifier {
  final GetTodayAttendance getTodayAttendance;
  final GetAbsensiMenuIDs getAbsensiMenuIDs;
  final SubmitAttendance submitAttendanceUseCase;

  AttendanceProvider({
    required this.getTodayAttendance,
    required this.getAbsensiMenuIDs,
    required this.submitAttendanceUseCase,
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
  
  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;

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

  Future<void> submitAttendance({
    required int employeeId,
    required String photoPath,
    required String location,
    required String branchCode,
    bool isWorker = false,
  }) async {
    _isSubmitting = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final now = DateTime.now();
      final date = DateFormat('yyyy-MM-dd').format(now);
      final time = DateFormat('HH:mm:ss').format(now);
      
      // Determine status based on current attendance state
      int status = determineAttendanceStatus();

      final result = await submitAttendanceUseCase(
        employeeId: employeeId,
        attendanceDate: date,
        attendanceTime: time,
        attendanceLocation: location,
        attendancePhotoPath: photoPath,
        attendanceBranch: branchCode,
        status: status,
        isWorker: isWorker,
      );

      result.fold(
        (failure) {
          _errorMessage = failure.message;
          _isSubmitting = false;
          notifyListeners();
        },
        (message) {
          _isSubmitting = false;
          notifyListeners();
          // Success - caller should refresh data
        },
      );
    } catch (e) {
      _errorMessage = e.toString();
      _isSubmitting = false;
      notifyListeners();
    }
  }

  int determineAttendanceStatus() {
    if (_attendanceToday == null) return 1; // Default to clock-in
    
    // Status logic from V1:
    // 1: Clock In
    // 2: Clock Out
    // 3: Break Finish
    
    if (_attendanceToday!.isBreak == true) {
      // Break mode
      return _attendanceToday!.clockIn == null ? 1 : 2;
    } else {
      // Normal mode
      if (_attendanceToday!.clockIn == null) {
        return 1; // Clock in
      } else if (_attendanceToday!.breakFinish == null) {
        return 3; // Break
      } else {
        return 2; // Clock out
      }
    }
  }
}
