import 'package:equatable/equatable.dart';

class AttendanceToday extends Equatable {
  final int? id;
  final int? employeeId;
  final DateTime? attendanceDate;
  final String? entrySchedule;
  final String? homeSchedule;
  final String? clockIn;
  final String? clockOut;
  final bool? isBreak;
  final String? breakStart;
  final String? breakFinish;
  final String? breakFinishPhoto;
  final String? startBreakHour;
  final String? entryBreakHour;
  final String? endBreakHour;
  final String? overtimeStart;
  final String? overtimeFinish;
  final String? locationIn;
  final String? locationOut;
  final String? overtimeStartLocation;
  final String? overtimeFinishLocation;
  final String? workHourCode;
  final int? clockInType;
  final int? clockOutType;
  final int? isLate;
  final int? isLateBreak;
  final int? breakFinishType;
  final int? earlyOut;
  final int? clockInStatus;
  final int? clockOutStatus;
  final int? clockInZone;
  final int? clockOutZone;
  final int? mealNum;
  final String? branchAttendance;
  final int? createStatus;
  final String? attendanceStatus;
  final String? photoInUrl;
  final String? photoOutUrl;
  final String? overtimeStartPhotoUrl;
  final String? overtimeFinishPhotoUrl;
  final AttendanceBranch? branch;

  const AttendanceToday({
    this.id,
    this.employeeId,
    this.attendanceDate,
    this.entrySchedule,
    this.homeSchedule,
    this.clockIn,
    this.clockOut,
    this.isBreak,
    this.breakStart,
    this.breakFinish,
    this.breakFinishPhoto,
    this.startBreakHour,
    this.entryBreakHour,
    this.endBreakHour,
    this.overtimeStart,
    this.overtimeFinish,
    this.locationIn,
    this.locationOut,
    this.overtimeStartLocation,
    this.overtimeFinishLocation,
    this.workHourCode,
    this.clockInType,
    this.clockOutType,
    this.isLate,
    this.isLateBreak,
    this.breakFinishType,
    this.earlyOut,
    this.clockInStatus,
    this.clockOutStatus,
    this.clockInZone,
    this.clockOutZone,
    this.mealNum,
    this.branchAttendance,
    this.createStatus,
    this.attendanceStatus,
    this.photoInUrl,
    this.photoOutUrl,
    this.overtimeStartPhotoUrl,
    this.overtimeFinishPhotoUrl,
    this.branch,
  });

  @override
  List<Object?> get props => [
        id,
        employeeId,
        attendanceDate,
        entrySchedule,
        homeSchedule,
        clockIn,
        clockOut,
        isBreak,
        breakStart,
        breakFinish,
        breakFinishPhoto,
        startBreakHour,
        entryBreakHour,
        endBreakHour,
        overtimeStart,
        overtimeFinish,
        locationIn,
        locationOut,
        overtimeStartLocation,
        overtimeFinishLocation,
        workHourCode,
        clockInType,
        clockOutType,
        isLate,
        isLateBreak,
        breakFinishType,
        earlyOut,
        clockInStatus,
        clockOutStatus,
        clockInZone,
        clockOutZone,
        mealNum,
        branchAttendance,
        createStatus,
        attendanceStatus,
        photoInUrl,
        photoOutUrl,
        overtimeStartPhotoUrl,
        overtimeFinishPhotoUrl,
        branch,
      ];
}

class AttendanceBranch extends Equatable {
  final String? branchCode;
  final String? branchName;
  final String? branchLocation;

  const AttendanceBranch({
    this.branchCode,
    this.branchName,
    this.branchLocation,
  });

  @override
  List<Object?> get props => [branchCode, branchName, branchLocation];
}
