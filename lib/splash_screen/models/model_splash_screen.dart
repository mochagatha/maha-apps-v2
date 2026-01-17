class ModelGetSplashScreen {
  String status;
  int code;
  String message;
  List<DatumGetOvertimeByEmployee> data;

  ModelGetSplashScreen({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory ModelGetSplashScreen.fromJson(Map<String, dynamic> json) =>
      ModelGetSplashScreen(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: List<DatumGetOvertimeByEmployee>.from(
          json["data"].map((x) => DatumGetOvertimeByEmployee.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DatumGetOvertimeByEmployee {
  int id;
  int employeeId;
  // int bossId;
  // int isProject;
  // DateTime overtimeDate;
  // String? startTime;
  // String? endTime;
  // String? bossStartTime;
  // String? bossEndTime;
  // String regarding;
  // int hoursTotal;
  // String description;
  // int status;
  // DateTime? approvedDate;
  // OvertimeBranch overtimeBranch;
  // dynamic trackingJobTitleId;
  // int isHoliday;
  // int isCancel;
  // int totalMeal;
  // String statusDescription;
  // bool isDone;
  // bool isOpen;
  // Boss employee;
  // Boss boss;
  // List<Photo> photo;
  // List<Tracking> tracking;
  // Branch branch;

  DatumGetOvertimeByEmployee({
    required this.id,
    required this.employeeId,
    // required this.bossId,
    // required this.isProject,
    // required this.overtimeDate,
    // required this.startTime,
    // required this.endTime,
    // required this.bossStartTime,
    // required this.bossEndTime,
    // required this.regarding,
    // required this.hoursTotal,
    // required this.description,
    // required this.status,
    // required this.approvedDate,
    // required this.overtimeBranch,
    // required this.trackingJobTitleId,
    // required this.isHoliday,
    // required this.isCancel,
    // required this.totalMeal,
    // required this.statusDescription,
    // required this.isDone,
    // required this.isOpen,
    // required this.employee,
    // required this.boss,
    // required this.photo,
    // required this.tracking,
    // required this.branch,
  });

  factory DatumGetOvertimeByEmployee.fromJson(
    Map<String, dynamic> json,
  ) => DatumGetOvertimeByEmployee(
    id: json["id"],
    employeeId: json["employee_id"],
    // bossId: json["boss_id"],
    // isProject: json["is_project"],
    // overtimeDate: DateTime.parse(json["overtime_date"]),
    // startTime: json["start_time"],
    // endTime: json["end_time"],
    // bossStartTime: json["boss_start_time"],
    // bossEndTime: json["boss_end_time"],
    // regarding: json["regarding"],
    // hoursTotal: json["hours_total"],
    // description: json["description"],
    // status: json["status"],
    // approvedDate: json["approved_date"] == null ? null : DateTime.parse(json["approved_date"]),
    // overtimeBranch: overtimeBranchValues.map[json["overtime_branch"]]!,
    // trackingJobTitleId: json["tracking_job_title_id"],
    // isHoliday: json["is_holiday"],
    // isCancel: json["is_cancel"],
    // totalMeal: json["total_meal"],
    // statusDescription: json["status_description"],
    // isDone: json["is_done"],
    // isOpen: json["is_open"],
    // employee: Boss.fromJson(json["employee"]),
    // boss: Boss.fromJson(json["boss"]),
    // photo: List<Photo>.from(json["photo"].map((x) => Photo.fromJson(x))),
    // tracking: List<Tracking>.from(json["tracking"].map((x) => Tracking.fromJson(x))),
    // branch: Branch.fromJson(json["branch"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_id": employeeId,
    // "boss_id": bossId,
    // "is_project": isProject,
    // "overtime_date":
    //     "${overtimeDate.year.toString().padLeft(4, '0')}-${overtimeDate.month.toString().padLeft(2, '0')}-${overtimeDate.day.toString().padLeft(2, '0')}",
    // "start_time": startTime,
    // "end_time": endTime,
    // "boss_start_time": bossStartTime,
    // "boss_end_time": bossEndTime,
    // "regarding": regarding,
    // "hours_total": hoursTotal,
    // "description": description,
    // "status": status,
    // "approved_date":
    //     "${approvedDate!.year.toString().padLeft(4, '0')}-${approvedDate!.month.toString().padLeft(2, '0')}-${approvedDate!.day.toString().padLeft(2, '0')}",
    // "overtime_branch": overtimeBranchValues.reverse[overtimeBranch],
    // "tracking_job_title_id": trackingJobTitleId,
    // "is_holiday": isHoliday,
    // "is_cancel": isCancel,
    // "total_meal": totalMeal,
    // "status_description": statusDescription,
    // "is_done": isDone,
    // "is_open": isOpen,
    // "employee": employee.toJson(),
    // "boss": boss.toJson(),
    // "photo": List<dynamic>.from(photo.map((x) => x.toJson())),
    // "tracking": List<dynamic>.from(tracking.map((x) => x.toJson())),
    // "branch": branch.toJson(),
  };
}
