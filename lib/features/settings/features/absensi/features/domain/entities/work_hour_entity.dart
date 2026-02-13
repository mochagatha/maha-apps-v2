class WorkHourEntity {
  final int id;
  final String code;
  final String name;
  final String startClockIn;
  final String lateClockIn;
  final String endClockIn;
  final String startBreak;
  final String lateBreak;
  final String endBreak;
  final String startClockOut;
  final String endClockOut;

  WorkHourEntity({
    required this.id,
    required this.code,
    required this.name,
    required this.startClockIn,
    required this.lateClockIn,
    required this.endClockIn,
    required this.startBreak,
    required this.lateBreak,
    required this.endBreak,
    required this.startClockOut,
    required this.endClockOut,
  });
}
