import '../../domain/entities/attendance_today.dart';

class AttendanceTodayModel extends AttendanceToday {
  const AttendanceTodayModel({
    super.id,
    super.employeeId,
    super.attendanceDate,
    super.entrySchedule,
    super.homeSchedule,
    super.clockIn,
    super.clockOut,
    super.isBreak,
    super.breakStart,
    super.breakFinish,
    super.breakFinishPhoto,
    super.startBreakHour,
    super.entryBreakHour,
    super.endBreakHour,
    super.overtimeStart,
    super.overtimeFinish,
    super.locationIn,
    super.locationOut,
    super.overtimeStartLocation,
    super.overtimeFinishLocation,
    super.workHourCode,
    super.clockInType,
    super.clockOutType,
    super.isLate,
    super.isLateBreak,
    super.breakFinishType,
    super.earlyOut,
    super.clockInStatus,
    super.clockOutStatus,
    super.clockInZone,
    super.clockOutZone,
    super.mealNum,
    super.branchAttendance,
    super.createStatus,
    super.attendanceStatus,
    super.photoInUrl,
    super.photoOutUrl,
    super.overtimeStartPhotoUrl,
    super.overtimeFinishPhotoUrl,
    AttendanceBranchModel? super.branch,
  });

  factory AttendanceTodayModel.fromJson(Map<String, dynamic> json) {
    return AttendanceTodayModel(
      id: json['id'],
      employeeId: json['employee_id'],
      attendanceDate: json['attendance_date'] != null
          ? DateTime.parse(json['attendance_date'])
          : null,
      entrySchedule: json['entry_schedule'],
      homeSchedule: json['home_schedule'],
      clockIn: json['clock_in'],
      clockOut: json['clock_out'],
      isBreak: json['is_break'],
      breakStart: json['break_start'],
      breakFinish: json['break_finish'],
      breakFinishPhoto: json['break_finish_photo'],
      startBreakHour: json['work_hour']?['start_break_hour'],
      entryBreakHour: json['work_hour']?['entry_break_hour'],
      endBreakHour: json['work_hour']?['end_break_hour'],
      overtimeStart: json['overtime_start'],
      overtimeFinish: json['overtime_finish'],
      locationIn: json['location_in'],
      locationOut: json['location_out'],
      overtimeStartLocation: json['overtime_start_location'],
      overtimeFinishLocation: json['overtime_finish_location'],
      workHourCode: json['work_hour_code'],
      clockInType: json['clock_in_type'],
      clockOutType: json['clock_out_type'],
      isLate: json['is_late'],
      isLateBreak: json['is_late_break_finish'],
      breakFinishType: json['break_finish_type'],
      earlyOut: json['early_out'],
      clockInStatus: json['clock_in_status'],
      clockOutStatus: json['clock_out_status'],
      clockInZone: json['clock_in_zone'],
      clockOutZone: json['clock_out_zone'],
      mealNum: json['meal_num'],
      branchAttendance: json['branch_attendance'],
      createStatus: json['create_status'],
      attendanceStatus: json['attendance_status'],
      photoInUrl: json['photo_in_url'],
      photoOutUrl: json['photo_out_url'],
      overtimeStartPhotoUrl: json['overtime_start_photo_url'],
      overtimeFinishPhotoUrl: json['overtime_finish_photo_url'],
      branch: json['branch'] != null
          ? AttendanceBranchModel.fromJson(json['branch'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'attendance_date': attendanceDate?.toIso8601String(),
      'entry_schedule': entrySchedule,
      'home_schedule': homeSchedule,
      'clock_in': clockIn,
      'clock_out': clockOut,
      'is_break': isBreak,
      'break_start': breakStart,
      'break_finish': breakFinish,
      'break_finish_photo': breakFinishPhoto,
      'work_hour': {
        'start_break_hour': startBreakHour,
        'entry_break_hour': entryBreakHour,
        'end_break_hour': endBreakHour,
      },
      'overtime_start': overtimeStart,
      'overtime_finish': overtimeFinish,
      'location_in': locationIn,
      'location_out': locationOut,
      'overtime_start_location': overtimeStartLocation,
      'overtime_finish_location': overtimeFinishLocation,
      'work_hour_code': workHourCode,
      'clock_in_type': clockInType,
      'clock_out_type': clockOutType,
      'is_late': isLate,
      'is_late_break_finish': isLateBreak,
      'break_finish_type': breakFinishType,
      'early_out': earlyOut,
      'clock_in_status': clockInStatus,
      'clock_out_status': clockOutStatus,
      'clock_in_zone': clockInZone,
      'clock_out_zone': clockOutZone,
      'meal_num': mealNum,
      'branch_attendance': branchAttendance,
      'create_status': createStatus,
      'attendance_status': attendanceStatus,
      'photo_in_url': photoInUrl,
      'photo_out_url': photoOutUrl,
      'overtime_start_photo_url': overtimeStartPhotoUrl,
      'overtime_finish_photo_url': overtimeFinishPhotoUrl,
      'branch': branch != null
          ? (branch as AttendanceBranchModel).toJson()
          : null,
    };
  }
}

class AttendanceBranchModel extends AttendanceBranch {
  const AttendanceBranchModel({
    super.branchCode,
    super.branchName,
    super.branchLocation,
  });

  factory AttendanceBranchModel.fromJson(Map<String, dynamic> json) {
    return AttendanceBranchModel(
      branchCode: json['branch_code'],
      branchName: json['branch_name'],
      branchLocation: json['branch_location'], // inferred
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'branch_code': branchCode,
      'branch_name': branchName,
      'branch_location': branchLocation,
    };
  }
}
