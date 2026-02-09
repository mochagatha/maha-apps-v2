import '../../domain/entities/tracking_settings.dart';

class TrackingSettingsModel extends TrackingSettings {
  const TrackingSettingsModel({
    required super.isGlobalTrackingEnabled,
    required super.employeeType,
  });

  factory TrackingSettingsModel.fromJson(Map<String, dynamic> json) {
    return TrackingSettingsModel(
      isGlobalTrackingEnabled:
          json['is_global_tracking_enabled'] ?? json['isGlobalTrackingEnabled'] ?? false,
      employeeType: json['employee_type'] ?? json['employeeType'] ?? 'karyawan',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_global_tracking_enabled': isGlobalTrackingEnabled,
      'employee_type': employeeType,
    };
  }

  TrackingSettingsModel copyWith({
    bool? isGlobalTrackingEnabled,
    String? employeeType,
  }) {
    return TrackingSettingsModel(
      isGlobalTrackingEnabled: isGlobalTrackingEnabled ?? this.isGlobalTrackingEnabled,
      employeeType: employeeType ?? this.employeeType,
    );
  }
}
