import 'package:equatable/equatable.dart';

/// Entity representing an employee in the tracking system
class TrackingEmployee extends Equatable {
  final int id;
  final String employeeId;
  final String fullname;
  final String jobTitleName;
  final String? departmentName;
  final String? photoUrl;
  final bool isTrackingEnabled;

  const TrackingEmployee({
    required this.id,
    required this.employeeId,
    required this.fullname,
    required this.jobTitleName,
    this.departmentName,
    this.photoUrl,
    required this.isTrackingEnabled,
  });

  @override
  List<Object?> get props => [
    id,
    employeeId,
    fullname,
    jobTitleName,
    departmentName,
    photoUrl,
    isTrackingEnabled,
  ];

  TrackingEmployee copyWith({
    int? id,
    String? employeeId,
    String? fullname,
    String? jobTitleName,
    String? departmentName,
    String? photoUrl,
    bool? isTrackingEnabled,
  }) {
    return TrackingEmployee(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      fullname: fullname ?? this.fullname,
      jobTitleName: jobTitleName ?? this.jobTitleName,
      departmentName: departmentName ?? this.departmentName,
      photoUrl: photoUrl ?? this.photoUrl,
      isTrackingEnabled: isTrackingEnabled ?? this.isTrackingEnabled,
    );
  }
}
