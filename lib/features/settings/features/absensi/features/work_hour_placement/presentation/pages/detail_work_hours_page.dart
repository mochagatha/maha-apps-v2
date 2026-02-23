import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/core/router/app_routes.dart';
import 'package:maha_apps_v2/features/settings/features/absensi/features/work_hour_placement/domain/entities/work_hour_entity.dart';
import 'package:maha_apps_v2/shared/theme/app_theme.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';

class DetailWorkHoursPage extends StatelessWidget {
  const DetailWorkHoursPage({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    final workHours = [
      WorkHourEntity(
        id: 1,
        code: "JK01",
        name: "Senin",
        startClockIn: "06:00:00",
        lateClockIn: "08:00:59",
        endClockIn: "08:30:59",
        startBreak: "12:50:00",
        lateBreak: "13:00:59",
        endBreak: "13:30:59",
        startClockOut: "17:00:00",
        endClockOut: "23:59:59",
      ),
      WorkHourEntity(
        id: 2,
        code: "JK02",
        name: "Selasa",
        startClockIn: "06:00:00",
        lateClockIn: "08:00:59",
        endClockIn: "08:30:59",
        startBreak: "12:50:00",
        lateBreak: "13:00:59",
        endBreak: "13:30:59",
        startClockOut: "17:00:00",
        endClockOut: "23:59:59",
      ),
      WorkHourEntity(
        id: 3,
        code: "JK03",
        name: "Rabu",
        startClockIn: "06:00:00",
        lateClockIn: "08:00:59",
        endClockIn: "08:30:59",
        startBreak: "12:50:00",
        lateBreak: "13:00:59",
        endBreak: "13:30:59",
        startClockOut: "17:00:00",
        endClockOut: "23:59:59",
      ),
      WorkHourEntity(
        id: 4,
        code: "JK04",
        name: "Kamis",
        startClockIn: "06:00:00",
        lateClockIn: "08:00:59",
        endClockIn: "08:30:59",
        startBreak: "12:50:00",
        lateBreak: "13:00:59",
        endBreak: "13:30:59",
        startClockOut: "17:00:00",
        endClockOut: "23:59:59",
      ),
      WorkHourEntity(
        id: 5,
        code: "JK05",
        name: "Jumat",
        startClockIn: "06:00:00",
        lateClockIn: "08:00:59",
        endClockIn: "08:30:59",
        startBreak: "13:20:00",
        lateBreak: "13:30:59",
        endBreak: "14:00:59",
        startClockOut: "17:00:00",
        endClockOut: "23:59:59",
      ),
    ];

    return Scaffold(
      appBar: CustomAppBar(title: "Jam Kerja $name"),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 8),
        itemCount: workHours.length,
        itemBuilder: (context, index) {
          final workHour = workHours[index];
          return Card(
            elevation: 5,
            shadowColor: Colors.black38,
            margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        workHour.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Kode: ${workHour.code}",
                        style: TextStyle(fontSize: 12),
                      ),
                      IconButton(
                        onPressed: () {
                          context.push(
                            AppRoutes.settingsAbsensiEditJamKerja.path,
                            extra: {"name": workHour.name},
                          );
                        },
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8),
                          ),
                          backgroundColor: Colors.grey.shade200,
                        ),
                        icon: Icon(
                          Icons.edit_note,
                          color: AppColors.blue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _buildWorkHourTime(
                              iconPath:
                                  "assets/images/icon/ic_in_time_lock.svg",
                              time: workHour.startClockIn,
                              name: "Awal Jam Masuk",
                            ),
                            _buildWorkHourTime(
                              iconPath:
                                  "assets/images/icon/ic_late_time_lock.svg",
                              time: workHour.lateClockIn,
                              name: "Telat Masuk",
                            ),
                            _buildWorkHourTime(
                              iconPath:
                                  "assets/images/icon/ic_out_time_lock.svg",
                              time: workHour.endClockIn,
                              name: "Akhir Jam Masuk",
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            _buildWorkHourTime(
                              iconPath:
                                  "assets/images/icon/ic_in_time_lock.svg",
                              time: workHour.startBreak,
                              name: "Awal Masuk Istirahat",
                            ),
                            _buildWorkHourTime(
                              iconPath:
                                  "assets/images/icon/ic_late_time_lock.svg",
                              time: workHour.lateBreak,
                              name: "Telat Masuk Istirahat",
                            ),
                            _buildWorkHourTime(
                              iconPath:
                                  "assets/images/icon/ic_out_time_lock.svg",
                              time: workHour.endBreak,
                              name: "Akhir Masuk Istirahat",
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            _buildWorkHourTime(
                              iconPath:
                                  "assets/images/icon/ic_in_time_lock.svg",
                              time: workHour.startClockOut,
                              name: "Awal Jam Pulang",
                            ),
                            _buildWorkHourTime(
                              iconPath:
                                  "assets/images/icon/ic_out_time_lock.svg",
                              time: workHour.endClockOut,
                              name: "Akhir Jam Pulang",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWorkHourTime({
    required String iconPath,
    required String time,
    required String name,
  }) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: 12),
          SvgPicture.asset(
            iconPath,
            height: 32,
            width: 32,
          ),
          Text(
            time,
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(height: 8),
          Text(
            "$name\n",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
