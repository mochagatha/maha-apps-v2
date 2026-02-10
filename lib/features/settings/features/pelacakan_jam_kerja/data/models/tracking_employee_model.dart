import '../../domain/entities/tracking_employee.dart';

class TrackingEmployeeModel extends TrackingEmployee {
  const TrackingEmployeeModel({
    required super.id,
    required super.employeeId,
    required super.fullname,
    required super.jobTitleName,
    super.departmentName,
    super.photoUrl,
    required super.isTrackingEnabled,
  });

  factory TrackingEmployeeModel.fromJson(Map<String, dynamic> json) {
    return TrackingEmployeeModel(
      id: json['id'] ?? 0,
      employeeId: json['employee_id']?.toString() ?? json['employeeId']?.toString() ?? '',
      fullname: json['fullname'] ?? json['full_name'] ?? '',
      jobTitleName:
          json['job_title_name'] ?? json['jobTitleName'] ?? json['job_title']?['name'] ?? '',
      departmentName:
          json['department_name'] ?? json['departmentName'] ?? json['department']?['name'],
      photoUrl: json['photo_url'] ?? json['photoUrl'],
      isTrackingEnabled: json['is_tracking_enabled'] ?? json['isTrackingEnabled'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'fullname': fullname,
      'job_title_name': jobTitleName,
      'department_name': departmentName,
      'photo_url': photoUrl,
      'is_tracking_enabled': isTrackingEnabled,
    };
  }

  TrackingEmployeeModel copyWith({
    int? id,
    String? employeeId,
    String? fullname,
    String? jobTitleName,
    String? departmentName,
    String? photoUrl,
    bool? isTrackingEnabled,
  }) {
    return TrackingEmployeeModel(
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
