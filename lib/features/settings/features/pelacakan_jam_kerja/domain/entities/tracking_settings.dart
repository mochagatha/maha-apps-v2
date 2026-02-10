import 'package:equatable/equatable.dart';

/// Entity representing tracking settings
class TrackingSettings extends Equatable {
  final bool isGlobalTrackingEnabled;
  final String employeeType; // 'karyawan' or 'pekerja_harian'

  const TrackingSettings({
    required this.isGlobalTrackingEnabled,
    required this.employeeType,
  });

  @override
  List<Object?> get props => [
    isGlobalTrackingEnabled,
    employeeType,
  ];

  TrackingSettings copyWith({
    bool? isGlobalTrackingEnabled,
    String? employeeType,
  }) {
    return TrackingSettings(
      isGlobalTrackingEnabled: isGlobalTrackingEnabled ?? this.isGlobalTrackingEnabled,
      employeeType: employeeType ?? this.employeeType,
    );
  }
}
